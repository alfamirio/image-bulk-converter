# Local Bulk Image Converter

A fast, privacy-focused, browser-based bulk image converter. It allows you to convert multiple images simultaneously to modern formats like **AVIF** and **WebP** without uploading anything to a server. Everything runs completely client-side.

For image to image comparison use [squoosh](https://squoosh.app/).

---

## Features

- **100% Client-Side Processing** — Images never leave your device.
- **Batch Conversion** — Process multiple images simultaneously.
- **Modern Formats** — Convert between AVIF, WebP, MozJPEG, JPEG, and PNG.
- **Drag & Drop Uploads** — Drop files directly into the browser.
- **Resize & Rotation Tools** — Resize by percentage, dimensions, width, or height.
- **Quality Presets** — From lossless to highly compressed.
- **Performance Controls** — Adjust encoding speed and concurrent worker count.
- **SSIM Benchmarking** — Measure visual similarity between original and converted images.
- **ZIP Downloads** — Download individual files or export everything as a ZIP archive.
- **Persistent Settings** — Configuration is automatically stored in localStorage.
- **Guess Game Mode** — Compare original vs converted images without seeing metadata.


### Compression & Conversion

Choose between several output formats and quality presets to balance image quality, file size, and encoding speed.

### Resize Options

- Keep original dimensions
- Scale by percentage
- Maximum width
- Maximum height
- Exact dimensions
  - Fit (preserve image)
  - Fill (crop)
  - Stretch

### Rotation

Apply a global rotation to all images:

- 90° clockwise
- 180°
- 270° counter-clockwise

### Benchmarking

Optional SSIM analysis allows objective quality comparison between the original and converted image.

### Bulk Operations

- Convert all selected images
- Download everything as ZIP
- Test all quality levels
- Test all output formats

---

## Quality Presets

The application provides presets ranging from:

- Maximum (90%)
- High (80%)
- Standard (65%)
- Medium (50%)
- Low (30%)
- Minimum (15%)
- Draft (5%)

Advanced mode exposes the complete preset matrix for fine-grained control.

---

## Quality

| Name | Label / Target % | AVIF (cqLevel ↓) | WebP (quality ↑) | MozJPEG (quality ↑) | JPEG (quality ↑) |
| --- | --- | --- | --- | --- | --- |
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

* **Frontend UI:** HTML5, CSS3, [Bootstrap 5](https://getbootstrap.com/)
* **Codec Engines (WebAssembly):** * [@jsquash/avif](https://www.google.com/search?q=https://github.com/GoogleChromeLabs/jsquash) for AVIF decoding and encoding.
* [@jsquash/webp](https://www.google.com/search?q=https://github.com/GoogleChromeLabs/jsquash) for WebP decoding and encoding.


* **Archive Utility:** [JSZip](https://stuk.github.io/jszip/) for client-side ZIP generation.

---

## Tests
### Automated Testing

The project includes an automated end-to-end testing suite using **Playwright** to validate the frontend conversion workflow under a local server environment.

### Prerequisites

Ensure you have installed the development dependencies in the root directory:
```bash
npm install -D @playwright/test http-server
npx playwright install

```

The test execution is orchestrated via playwright.config.js in the root folder, which manages the lifecycle of the local server automatically:

### Running the Tests

To execute the suite, run the following commands from the project root:

* **Headless execution (default):**
```bash
npx playwright test

```


* **Headed execution (see the browser actions live):**
```bash
npx playwright test --headed

```


* **Debug mode (step-by-step inspector):**
```bash
npx playwright test --debug

```

---

## Getting Started

### Prerequisites

Since the application uses **ES Modules** and fetches specialized WebAssembly codecs dynamically from an external CDN (`unpkg.com`), running the file directly via `file://` protocol in your browser will trigger CORS restrictions.

You **must** serve the project using a local HTTP server.

### Running it Locally

1. Clone or save the project files into a folder:

2. Start a simple local server. You can use any of the following standard developer tools:
* **Using NodeJS (npx):**
```bash
npx serve .

```


* **Using Python 3:**
```bash
python -m http.server 8080

```


* **Using VS Code:** Install the **Live Server** extension, right-click `index.html`, and select *Open with Live Server*.


3. Open your browser and navigate to the address provided by your server (usually `http://localhost:8080` or `http://localhost:3000`).

---

## Architecture Note

The application employs an asynchronous **Worker Pool** queue pattern. When you hit **Convert**, the application allocates your chosen number of execution slots (Threads) and consumes the image queue concurrently.

> [!NOTE]
> Because tasks run inside the browser's primary execution frame, OS-level multi-core hardware spikes might appear grouped under a single process thread depending on your browser's WebAssembly sandbox configuration.

---
