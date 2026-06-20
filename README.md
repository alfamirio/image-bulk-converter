# Local Bulk Image Converter

A fast, privacy-focused, browser-based bulk image converter. It allows you to convert multiple images simultaneously to modern formats like **AVIF** and **WebP** without uploading anything to a server. Everything runs completely client-side.

For image to image comparison use [squoosh](https://squoosh.app/).

## Features

* **100% Local Processing:** Your images never leave your computer. Processing happens entirely within the browser via WebAssembly (Wasm).
* **Next-Gen Formats:** Convert standard images (PNG, JPEG, WebP, AVIF) into highly optimized AVIF or WebP files.
* **Batch Conversion:** Drop or select dozens of images at once.
* **Virtual Multi-Threading:** Fine-tune performance by selecting 1, 2, or 4 concurrent processing pipelines.
* **Smart Compression Metrics:** Instantly view the final file size ratio compared to the original. Badges turn red if the file size exceeds the original.
* **Bulk Download:** Download individual converted images or grab them all at once in a single structured `.zip` archive.
* **Persistent Settings:** Your preferred format, quality, speed, and thread settings are automatically saved via `localStorage`.

---

## Quality

| Label / Target % | AVIF (cqLevel ↓) | WebP (quality ↑) | MozJPEG (quality ↑) | JPEG (quality ↑) |
| --- | --- | --- | --- | --- |
| Lossless — 100% | 0 | 100 | 100 | 100 |
| Q95 — 95% | 4 | 95 | 95 | 96 |
| Maximum — 90% | 8 | 90 | 90 | 92 |
| Q85 — 85% | 12 | 85 | 85 | 87 |
| High — 80% | 16 | 80 | 80 | 82 |
| Q75 — 75% | 20 | 75 | 75 | 78 |
| Q70 — 70% | 24 | 70 | 70 | 73 |
| Standard — 65% | 28 | 65 | 65 | 68 |
| Q60 — 60% | 32 | 60 | 60 | 63 |
| Q55 — 55% | 34 | 55 | 56 | 59 |
| Medium — 50% | 36 | 50 | 52 | 55 |
| Q45 — 45% | 40 | 45 | 47 | 50 |
| Q40 — 40% | 43 | 40 | 42 | 45 |
| Q35 — 35% | 46 | 35 | 38 | 41 |
| Low — 30% | 48 | 30 | 35 | 38 |
| Q25 — 25% | 51 | 25 | 29 | 32 |
| Q20 — 20% | 54 | 20 | 23 | 25 |
| Min — 15% | 56 | 15 | 18 | 20 |
| Q10 — 10% | 59 | 10 | 12 | 14 |
| Draft — 5% | 62 | 5 | 8 | 10 |
| Worst — 0% | 63 | 1 | 1 | 1 |

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
