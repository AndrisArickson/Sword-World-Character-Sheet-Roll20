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

## Changes from the original sheet
**Permanent bonuses.** Hover a box and click the pencil to add a permanent bonus, as with Fortitude and Willpower. A small `+N` in the corner shows a bonus is set.
- **Monster Knowledge** has two bonuses:
  - **Knowledge**, added to both results.
  - **Weakness**, added only to the weakness-detection result, for items that improve weakness detection.

  The roll uses one 2d6 and posts two results to chat: `Knowledge XX` and `Weakness XX`. With no weakness bonus the two numbers match. A natural 12 still counts as an automatic success (+5) for both. When a weakness bonus is set, the sheet also shows `Weakness XX` under the Monster Knowledge value.
- **Initiative**: the bonus is included in the Initiative roll.
- **Technique, Movement, Observation and Knowledge** (check packages on page 1): the bonus is included in their value and roll.
- **Base Accuracy** and **Extra Damage**: the bonus is shown on page 2 and added to every weapon's Total Accuracy and Total Extra Damage. Each also has a one-line note under it, for recording where the numbers come from (e.g. `+1 Accuracy Ring`).
- **Limited Move**: the default of 3 is replaced by Normal Move ÷ 6, rounded down, plus the bonus.

**Temporary ability modifiers.** Each ability score's pencil now opens two fields:
- **+ Bonus**: the existing permanent adjustment.
- **± Temp**: a temporary bonus or penalty.

The temporary amount is added to the score, so it also changes the modifier and everything calculated from it. It shows in deep purple under the score (for example `+2 temp` or `-1 temp`). It disappears when set back to 0.

**Movement Enhancements** can have extra lines (use **+Add**), for example boots on one line and a spell on another. The first line and every extra line are added together. The total, shown at the bottom of the box, is added to Normal Move, and Full Move and Limited Move follow it.
