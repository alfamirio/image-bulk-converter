# Local Bulk Image Converter

A fast, privacy-focused, browser-based bulk image converter. Convert multiple images simultaneously to modern formats like **AVIF** and **WebP** without uploading anything to a server. Everything runs completely client-side.

For side-by-side image quality comparison, see [Squoosh](https://squoosh.app/).

---

## Features

- **100% Client-Side Processing** — Images never leave your device.
- **Batch Conversion** — Process multiple images simultaneously with a configurable worker pool.
- **Modern Formats** — Convert between AVIF, WebP, MozJPEG, JPEG, and PNG.
- **Drag & Drop Uploads** — Drop files directly into the browser or click to browse.
- **Resize & Rotation Tools** — Resize by percentage, max width/height, or exact dimensions; rotate globally.
- **Max File Size Mode** — Binary-search encoding finds the highest quality that fits a target file size.
- **Quality Presets** — 21 levels from Lossless (100%) to Worst (0%), with an optional Fine/Advanced matrix view.
- **Performance Controls** — Adjust encoding speed (0–4) and concurrent thread count (1–8).
- **SSIM Benchmarking** — Optional per-image SSIM score (Y+Cb+Cr, 11×11 Gaussian window, matches ffmpeg output).
- **Synchronized Pan & Zoom** — Full-screen side-by-side preview with linked zoom (up to 16×), drag-to-pan, pinch-to-zoom, and keyboard shortcuts.
- **ZIP Downloads** — Download individual files or export everything as a ZIP archive.
- **Persistent Settings** — All configuration is automatically saved in `localStorage`.
- **Guess Game Mode** — Compare original vs. converted images without seeing metadata; randomises image positions and tracks your score.
- **Live Stats Bar** — Real-time totals for size before/after, compression ratio, success count, errors, and elapsed time.

---

## Conversion

### Output Formats

| Format | Notes |
|---|---|
| **WebP** | Optimised — broad browser support, excellent compression |
| **AVIF** | Next-Gen — best compression, slower to encode |
| **MozJPEG** | Better JPEG — improved compression over standard JPEG |
| **PNG** | Lossless — no quality loss |
| **JPEG** | Standard — widest compatibility |

### Processing Speed

Levels 0–4 trade encode time for compression efficiency. Levels 3–4 can be very slow for AVIF; a warning is shown when selected.

### Threads

Choose 1, 2, 4, ..., 2n concurrent workers. Workers run inside the browser's execution frame using a queue-based pool pattern.

---

## Resize Options

| Mode | Description |
|---|---|
| Original Size | No resizing applied |
| Scale (%) | Proportional scale by percentage |
| Max Width (px) | Constrain to maximum width |
| Max Height (px) | Constrain to maximum height |
| Exact Size | Set explicit width and height |

When using **Exact Size**, choose a fitting strategy:

- **Fit** — Preserve aspect ratio, no cropping
- **Fill** — Crop to fill the target dimensions
- **Stretch** — Stretch to fill exactly

---

## Rotation

Apply a global rotation to all images before encoding:

- No Rotation (default)
- 90° Clockwise
- 180° Flip
- 270° Counter-Clockwise

---

## Max File Size

Set a target maximum output file size using preset pills (128 KiB, 256 KiB, 512 KiB, 1 MiB) or a custom KiB value. The encoder runs a binary search across quality presets to find the best quality that fits within the limit.

---

## SSIM Benchmarking

Enable the **SSIM** toggle to compute a per-image structural similarity score after each conversion. The implementation uses an 11×11 Gaussian-weighted sliding window across Y, Cb, and Cr channels (BT.601), averaged equally — matching the output of `ffmpeg`'s `ssim` filter.

---

## Guess Game

Enable the **🎮 Guess** toggle to enter game mode. The full-screen preview hides file metadata and randomly places the original and converted images on either side. Click the button matching whichever image you think is the original. Your running score is shown in the stats bar.

---

## Quality Presets

21 levels covering the full range from lossless to maximum compression. **Fine** mode exposes the complete preset matrix for per-codec fine-grained control.

| Name | Label / Target % | AVIF (cqLevel ↓) | WebP (quality ↑) | MozJPEG (quality ↑) | JPEG (quality ↑) |
|---|---|---|---|---|---|
| q100 | Lossless — 100% | 0 | 100 | 100 | 100 |
| q95 | Q95 — 95% | 4 | 95 | 95 | 96 |
| q90 | Maximum — 90% | 8 | 90 | 90 | 92 |
| q85 | Q85 — 85% | 12 | 85 | 85 | 87 |
| q80 | High — 80% | 16 | 80 | 80 | 82 |
| q75 | Q75 — 75% | 20 | 75 | 75 | 78 |
| q70 | Q70 — 70% | 24 | 70 | 70 | 73 |
| q65 | Standard — 65% | 28 | 65 | 65 | 68 |
| q60 | Q60 — 60% | 32 | 60 | 60 | 63 |
| q55 | Q55 — 55% | 34 | 55 | 56 | 59 |
| q50 | Medium — 50% | 36 | 50 | 52 | 55 |
| q45 | Q45 — 45% | 40 | 45 | 47 | 50 |
| q40 | Q40 — 40% | 43 | 40 | 42 | 45 |
| q35 | Q35 — 35% | 46 | 35 | 38 | 41 |
| q30 | Low — 30% | 48 | 30 | 35 | 38 |
| q25 | Q25 — 25% | 51 | 25 | 29 | 32 |
| q20 | Q20 — 20% | 54 | 20 | 23 | 25 |
| q15 | Min — 15% | 56 | 15 | 18 | 20 |
| q10 | Q10 — 10% | 59 | 10 | 12 | 14 |
| q5 | Draft — 5% | 62 | 5 | 8 | 10 |
| q0 | Worst — 0% | 63 | 1 | 1 | 1 |

---

## Tech Stack

- **Frontend UI:** HTML5, CSS3, [Bootstrap 5](https://getbootstrap.com/) (dark theme, always on)
- **Codec Engines (WebAssembly via CDN):**
  - [`@jsquash/avif@1.0.2`](https://github.com/GoogleChromeLabs/jsquosh) — AVIF encode/decode
  - [`@jsquash/webp@1.2.0`](https://github.com/GoogleChromeLabs/jsquosh) — WebP encode/decode
  - [`@jsquash/jpeg@1.4.0`](https://esm.sh/@jsquash/jpeg) — MozJPEG encode
- **Archive Utility:** [JSZip 3.10.1](https://stuk.github.io/jszip/) — client-side ZIP generation
- **SSIM:** Custom implementation, BT.601 YCbCr, 11×11 Gaussian kernel (matches ffmpeg)
- **Canvas API:** Native JPEG/PNG decode and fallback encode path

> **Note:** The app fetches WebAssembly codecs dynamically from `unpkg.com` and `esm.sh`. It must be served over HTTP, not opened as a `file://` URL, to avoid CORS restrictions.

---

## Architecture

The app uses an asynchronous **Worker Pool** pattern. On Convert, it allocates the selected number of execution slots (Threads) and drains the image queue concurrently. Each worker:

1. Receives the image buffer and encoding parameters.
2. Decodes using a jsquash WASM codec (or falls back to `OffscreenCanvas` for JPEG/PNG).
3. Applies rotation and resize transforms via `OffscreenCanvas` when needed.
4. Encodes to the target format and posts the result back.

A separate **binary-search worker** is spawned per image when Max File Size mode is active, running independent encode trials without blocking the main pool.

> Because tasks run inside the browser's primary execution frame, OS-level multi-core spikes may appear grouped under a single process thread depending on your browser's WebAssembly sandbox configuration.

---

## Getting Started

### Prerequisites

Serve the project over HTTP (required for ES Modules and CDN-fetched WASM codecs).

### Running Locally

```bash
# Node.js
npx serve .

# Python 3
python -m http.server 8080
```

Or use the **Live Server** extension in VS Code: right-click `index.html` → *Open with Live Server*.

Open your browser at `http://localhost:8080` (or whichever port your server reports).

---

## Automated Testing

The project includes an end-to-end test suite using **Playwright**.

### Prerequisites

```bash
npm install -D @playwright/test http-server
npx playwright install
```

Test lifecycle (local HTTP server startup/shutdown) is managed automatically via `playwright.config.js` in the project root.

### Running Tests

```bash
# Headless (default)
npx playwright test

# Headed — watch the browser actions live
npx playwright test --headed

# Debug — step-by-step inspector
npx playwright test --debug
```
