# Sword-World-Character-Sheet-Roll20
Update on the classic Sword World 2.5/2.0 character sheet used on Roll20.

## Origin
The starting point is the community **Sword World** sheet from Roll20's
[roll20-character-sheets](https://github.com/Roll20/roll20-character-sheets/tree/master/Sword%20World)
repository, imported unchanged at commit
`fed38cd56d073ae59bbdb18c0c4d7e9b0f9ea2ad`.

Original authors: Robert Burson (robert-b), Chris Casey (miriable).
That repository is MIT-licensed (Copyright (c) 2014-2018 Roll20); the licence text is in [LICENSE](LICENSE).

## Files
| File | Purpose |
| --- | --- |
| `sheet.html` | Sheet layout, roll templates and sheet workers |
| `sheet.css` | Sheet styling |
| `sheet.json` | Roll20 sheet metadata |
| `sheet.png` | Preview image |
| `images/` | Border, circle and logo art used by the CSS |

## Using it in Roll20
In a game's **Settings → Game Settings → Character Sheet Template**, choose
**Custom** (requires a Pro subscription), then paste `sheet.html` into the
HTML tab and `sheet.css` into the CSS tab.

## Images
`sheet.css` loads its art straight from this repository's `main` branch:
`https://raw.githubusercontent.com/AndrisArickson/Sword-World-Character-Sheet-Roll20/main/images/<file>`.

Roll20 fetches those URLs from the players' browsers, so they only work when
the repository is **public** and the files are on `main`.
