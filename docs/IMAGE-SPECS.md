# Image specs for the Sword World Roll20 sheet

This brief is for whoever (person or AI session) makes replacement art.
The sheet uses four images. Each one below says where it shows up, its
current size, and what the new one must get right for the CSS to work.

## General rules (all images)
- **Format:** `.webp` with a **transparent background** (lossless or quality 90+).
- **Size:** deliver at **2x** the size listed. The sheet scales them down, and 2x keeps them sharp on high-DPI screens.
- **File weight:** under 200 KB each, ideally under 100 KB.
- **Style:** fantasy / old-world ornament (filigree, scrollwork, engraved-metal or ink look).
  It must read well **small**, since most of it is shown at 20-120 px.
- **No official logos or trademarked art** (Group SNE / Sword World logos, book art). Everything must be original.
- **File names:** use the names given below, lower-case, no spaces.
- **Where to upload:** the `images/` folder on the `main` branch.

---

## 1. `logo.webp`: sheet header logo
- **Where:** top-left of page 1, in the header. It replaces the "Sword World 2.5" title text.
- **Current:** `logo.png`, 410 x 512 px (portrait, about 4:5): white "SW 2.5 RPG" lettering with a sword and a soft grey shadow.
- **Deliver:** **820 x 1024 px**, portrait 4:5.
- **Must:** stay inside the canvas. It is shown with `background-size: contain`, anchored top-left, so keep the artwork in the top-left and leave no big empty margins.
- **Ideas:** an original emblem for your table, e.g. a crest with crossed sword and staff, or "SW 2.5" in your own lettering.

## 2. `border.webp`: frame around the class/level ("guild") box
- **Where:** page 1, the box listing classes and adventurer level.
- **Current:** `border.png`, 195 x 195 px. Black ornate scroll corners with thin double-line edges; inside is empty and transparent.
- **Deliver:** **390 x 390 px**, square.
- **How it is used (important):** CSS `border-image` with a slice of 65 px at 1x (130 px at 2x).
  The image is cut into a 3 x 3 grid:
  ```
  +------+--------+------+
  |corner| edge   |corner|   outer band = 130 px at 2x
  +------+--------+------+
  | edge | (unused)| edge |
  +------+--------+------+
  |corner| edge   |corner|
  +------+--------+------+
  ```
  - The **4 corners** are drawn as-is, scaled down to 20 px on the sheet.
  - The **4 edges** are **stretched** to fill the box, so the edge art must be plain lines that still look fine stretched. No motifs in the middle of an edge.
  - The **centre** is thrown away. Leave it transparent.
- **Note:** the bottom-right corner sits under the level circle (image 3), so it can be simpler.

## 3. `circle.webp`: badge behind the adventurer level number
- **Where:** overlapping the bottom-right corner of the guild box. A number (24 px font) sits in the middle.
- **Current:** `circle.png`, 300 x 305 px. Black double-ring with scrollwork at top and bottom, white inside.
- **Deliver:** **600 x 600 px**, square.
- **Shown at:** 120 x 120 px.
- **Must:** have a **solid light (white or parchment) centre** about 50% of the width, so a dark number is easy to read. The ornament stays in the outer ring.
- **Should:** match the style of `border.webp`.

## 4. `border2.webp`: frame for the chat roll cards
- **Where:** the chat log, around every skill, damage and info roll the sheet posts.
- **Current:** `border2.png`, 238 x 237 px. Gold/tan acanthus-leaf corners and thin tan lines on a cream square.
- **Deliver:** **476 x 476 px**, square.
- **How it is used:** same `border-image` rules as image 2 (slice 65 px at 1x / 130 px at 2x, 20 px on screen, stretched edges, centre thrown away).
- **Must:** look right on Roll20's **light** and **dark** chat themes, e.g. mid-tone gold or bronze with a subtle dark outline.

---

## Optional extras (not used by the sheet yet)
If you want them, these can be added to the CSS:
- `parchment.webp`: a subtle, tileable paper texture for the sheet background (512 x 512, seamless).
- `divider.webp`: a horizontal ornament for between sections (1200 x 60).
- Class or race icons (e.g. Fighter, Sorcerer, Priest): 128 x 128 each, one consistent style.

## Delivered (10 Oct 2026)

All images are in `images/` as WebP. The source art was made in Google Flow and assembled in Python; the scripts are in `SwordWorld/Claude/sheet-art/` (`assemble.py`, `icons.py`, `preview.py`). The old PNGs were moved to `Images/_replaced/roll20-sheet/`.

| File | Size | Notes |
|---|---|---|
| `logo.webp` | 820 x 1024 | Crest with crossed sword and staff and "SW 2.5" ribbon, anchored top-left |
| `border.webp` | 390 x 390 | Black ink scroll corners, plain double-line edges; `sheet.css` slice changed to 130 |
| `circle.webp` | 600 x 600 | Ink double ring with scrollwork; solid light centre about 65% of the width |
| `border2.webp` | 476 x 476 | Gold acanthus corners with a dark outline for dark chat; slice 130 |
| `parchment.webp` | 1024 x 1024 | Seamless, subtle; the sheet background (`body .charsheet`) |
| `divider.webp` | 2400 x 120 | Ink filigree divider; `.divider` between sections on pages 1 and 2 |
| `icons/class-*.webp`, `icons/race-*.webp` | 256 x 256 | 29 classes and 27 races, round bronze-rimmed portraits cut from the Spirit Maze class and race art; Nightmare variants share `race-nightmare.webp`. Class icons show at 18 px beside each class name; the race portrait shows at 64 px beside the Race field, picked by a sheet worker that writes the `race_icon` attribute |

Frame thickness was raised to show more of the new corner art: the guild box border is 30 px (was 20) and the chat roll-card border is 26 px (was 20).

## Class icons (10 Oct 2026)

The class list uses bold emblem icons from `images/class-icons/` (29 files, 256 x 256, shown at 20 px), coloured by class type: crimson for warrior classes, sapphire for wizard classes, bronze for the rest. The earlier class portraits stay in `images/icons/` for other uses.

## Race icons (10 Oct 2026)

The race field uses bust emblems from `images/race-icons/` (47 files, 256 x 256, shown at 64 px), coloured by race group: green for common races, violet for rare races (including Noble Elf), rust for barbarous races. All six Nightmare variants share `race-nightmare.webp`. The earlier race portraits stay in `images/icons/`.
