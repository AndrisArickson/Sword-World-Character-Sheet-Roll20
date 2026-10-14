# Tracking the original sheet

This fork is built on the **Sword World** sheet in Roll20's
[roll20-character-sheets](https://github.com/Roll20/roll20-character-sheets/tree/master/Sword%20World)
repository, by Robert Burson (robert-b) and Chris Casey (miriable). The original authors update it
about once or twice a year.

## What is recorded
| Path | Purpose |
| --- | --- |
| `upstream/BASE` | The upstream commit and version our fork currently includes |
| `upstream/base/` | Untouched copies of upstream `sheet.html`, `sheet.css` and `sheet.json` at that commit |
| `tools/upstream.sh` | Checks for upstream changes and merges them |
| `.github/workflows/upstream-watch.yml` | Runs the check every Monday and opens an issue when upstream has changed |

## Checking and merging updates
```
tools/upstream.sh check          # what changed upstream since our base?
tools/upstream.sh check --diff   # ...with the full diff
tools/upstream.sh merge          # merge it into our files
```
`merge` combines our files with the changes upstream made, the same way git merges two branches.
Where upstream and this fork edited the same lines, the file gets conflict markers:
```
<<<<<<< this fork
(our version)
=======
(upstream's version)
>>>>>>> upstream abc1234
```
Edit each one to the line you want (usually our version plus upstream's change), then delete the
markers. Afterwards:
1. Update the version numbers in the footer (`content:` line in `sheet.css`, search for `Fork `).
2. Test in a backup game.
3. Commit.

Upstream images and translation files are not merged automatically; the script lists them so they
can be copied by hand.

## Where this fork differs from upstream
Use this list when resolving conflicts: if a conflict touches one of these, keep our side and re-apply
upstream's change on top of it.

| Change | sheet.html | sheet.css |
| --- | --- | --- |
| Footer credits original and fork | – | footer `content:` line |
| Art loaded from this repo (WebP) | – | the 4 `url(...)` lines; `border-image` slice 130 |
| Thicker frames, parchment background | – | `.guild`, `.guild:before`, roll-template `.sheet-container` border, `body .charsheet` background |
| Race list and icons | all 2.5/2.0 races + Noble Elf in the `race` datalist; `race-row` wrapper around the Race field; `race_icons` worker | `/* ===== Art ... */` block at the end (images in `images/race-icons/`) |
| Class icons | `class-icon cls-…` classes on the class-list labels | `.cls-…:before` rules at the end (images in `images/class-icons/`) |
| Dividers | five `<div class="divider">` | `.divider` |
| Permanent bonuses (Monster Knowledge, Initiative, Technique, Movement, Observation, Knowledge, Base Accuracy, Extra Damage, Limited Move) | `editable` wrappers with `*_mod` inputs; `modifier_list`; package calculation; weapon totals (both calculation paths) | `toggle-bonus`, `bonus-note`, `.box + div .editable` overrides |
| Limited Move = Normal Move ÷ 6 + bonus | `triggerAbility` | – |
| Monster Knowledge Knowledge/Weakness roll | `act_monster_knowledge-action` button and its worker; `{{knowledge}}` lines in the `swskill` roll template | `weakness-note`, `bonus-row` |
| Temporary ability modifiers | `*_temp` inputs in each ability editor; `triggerAbility` | `temp-note`, `editbox.multi.inline` |
| Multi-line Movement Enhancements | `repeating_moveenh`; `sumMoveEnhancements` worker; `movement_enhancements_total` | `.move-enh` |
| Base Accuracy / Extra Damage notes | `*_note` inputs | `input.stat-note` |
| Credits | – (`sheet.json` authors and instructions) | – |
| Parchment behind everything | – | `/* ===== Parchment everywhere` block at the end (overrides only) |
| Chat cards: smaller heading, bigger results, half-size portrait | – | `/* chat cards: ... */` and `/* chat-card portrait at half size */` blocks at the end |
| Portrait in chat rolls can be switched off | `attr_roll_portrait` switch on the Settings tab; `character_token` worker | – |

## Roll20's CSS filter (read before editing sheet.css)
Roll20 scans the whole stylesheet and silently drops ALL roll-template (chat card) styling if it finds a
"potential security violation". Keep these out of sheet.css, comments included:
- banned words, even inside comments: `window`, `eval`, `cookie`, `this`, `behavior`/`behaviour`, `data:`
- HTML tags such as `<img>`
- escaped characters in `content:` (for example `\A` or `\2713`); type the character itself instead
- non-ASCII characters beyond those the original sheet already uses
