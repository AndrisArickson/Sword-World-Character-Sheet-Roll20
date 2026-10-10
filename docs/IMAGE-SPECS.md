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
