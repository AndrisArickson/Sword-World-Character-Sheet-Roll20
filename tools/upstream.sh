#!/usr/bin/env bash
# Track the upstream Roll20 "Sword World" sheet and merge its updates into this fork.
#
#   tools/upstream.sh check         list upstream commits since our base (exit 10 if there are any)
#   tools/upstream.sh check --diff  ...and print the full upstream diff
#   tools/upstream.sh merge         3-way merge the upstream changes into sheet.html/css/json
#
# How it works: upstream/base/ holds the untouched upstream files our fork was built
# from, and upstream/BASE records which upstream commit they came from. "merge" combines
# (our file) + (what upstream changed between base and now), the same way git merges
# branches, then moves upstream/base and upstream/BASE forward to the new upstream commit.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BASE_FILE="$ROOT/upstream/BASE"
FILES=(sheet.html sheet.css sheet.json)

while IFS='=' read -r key value; do
    case "$key" in
        UPSTREAM_REPO|UPSTREAM_PATH|BASE_COMMIT|BASE_DATE|UPSTREAM_VERSION) printf -v "$key" '%s' "$value" ;;
    esac
done < <(grep -E '^[A-Z_]+=' "$BASE_FILE")

mode="${1:-check}"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "Fetching upstream history since $BASE_DATE (this takes a minute)..." >&2
git clone --quiet --bare --filter=blob:none --shallow-since="$BASE_DATE" "$UPSTREAM_REPO" "$TMP/up.git"
UP=(git -C "$TMP/up.git")

if ! "${UP[@]}" cat-file -e "$BASE_COMMIT^{commit}" 2>/dev/null; then
    echo "Base commit $BASE_COMMIT is not in the fetched history; check upstream/BASE." >&2
    exit 2
fi

# Compare the folder's contents, not commit ids: merge commits "touch" the folder without changing it.
LATEST="$("${UP[@]}" rev-parse HEAD)"
if [ "$("${UP[@]}" rev-parse "$BASE_COMMIT:$UPSTREAM_PATH")" = "$("${UP[@]}" rev-parse "$LATEST:$UPSTREAM_PATH")" ]; then
    echo "Up to date: upstream '$UPSTREAM_PATH' has not changed since ${BASE_COMMIT:0:10} ($BASE_DATE, Ver.$UPSTREAM_VERSION)."
    exit 0
fi

echo "Upstream '$UPSTREAM_PATH' has changed since our base ${BASE_COMMIT:0:10} ($BASE_DATE):"
echo
"${UP[@]}" log --no-merges --format='  %h %cs %an: %s' "$BASE_COMMIT..$LATEST" -- "$UPSTREAM_PATH"
echo
echo "Files changed upstream:"
"${UP[@]}" diff --stat "$BASE_COMMIT" "$LATEST" -- "$UPSTREAM_PATH" | sed 's/^/  /'

case "$mode" in
check)
    if [ "${2:-}" = "--diff" ]; then
        echo
        "${UP[@]}" diff "$BASE_COMMIT" "$LATEST" -- "$UPSTREAM_PATH"
    fi
    echo
    echo "Run 'tools/upstream.sh merge' to merge these changes into the fork."
    exit 10
    ;;
merge)
    conflicts=0
    for f in "${FILES[@]}"; do
        if ! "${UP[@]}" cat-file -e "$LATEST:$UPSTREAM_PATH/$f" 2>/dev/null; then
            echo "  $f: removed upstream; left as is here." >&2
            continue
        fi
        "${UP[@]}" show "$LATEST:$UPSTREAM_PATH/$f" > "$TMP/new-$f"
        set +e
        git merge-file -L "this fork" -L "upstream ${BASE_COMMIT:0:10}" -L "upstream ${LATEST:0:10}" \
            "$ROOT/$f" "$ROOT/upstream/base/$f" "$TMP/new-$f"
        rc=$?
        set -e
        if [ "$rc" -lt 0 ] || [ "$rc" -gt 127 ]; then
            echo "  $f: merge failed." >&2
            exit 3
        elif [ "$rc" -gt 0 ]; then
            echo "  $f: $rc conflict(s) - search the file for '<<<<<<<' and resolve them."
            conflicts=$((conflicts + rc))
        else
            echo "  $f: merged cleanly."
        fi
        cp "$TMP/new-$f" "$ROOT/upstream/base/$f"
    done

    others="$("${UP[@]}" diff --name-only "$BASE_COMMIT" "$LATEST" -- "$UPSTREAM_PATH" | grep -v -E "/($(IFS='|'; echo "${FILES[*]}"))$" || true)"
    if [ -n "$others" ]; then
        echo
        echo "Other upstream files changed (images, translations...); copy them over by hand if wanted:"
        echo "$others" | sed 's/^/  /'
    fi

    new_date="$("${UP[@]}" log -1 --format=%cs "$LATEST" -- "$UPSTREAM_PATH")"
    new_version="$(grep -o -m1 "Ver\.[0-9][0-9.]*" "$TMP/new-sheet.css" | sed 's/^Ver\.//' || true)"
    sed -i.bak -e "s/^BASE_COMMIT=.*/BASE_COMMIT=$LATEST/" -e "s/^BASE_DATE=.*/BASE_DATE=$new_date/" \
        -e "s/^UPSTREAM_VERSION=.*/UPSTREAM_VERSION=${new_version:-$UPSTREAM_VERSION}/" "$BASE_FILE"
    rm -f "$BASE_FILE.bak"

    echo
    echo "upstream/BASE now points at ${LATEST:0:10} ($new_date, Ver.${new_version:-$UPSTREAM_VERSION})."
    echo "Review with 'git diff', update the version in the sheet footer (sheet.css), then commit."
    [ "$conflicts" -eq 0 ] || exit 1
    ;;
*)
    echo "usage: tools/upstream.sh check [--diff] | merge" >&2
    exit 64
    ;;
esac
