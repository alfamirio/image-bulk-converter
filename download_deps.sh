#!/usr/bin/env bash
# download_deps.sh
# Downloads all external dependencies used by index.html so they can be
# served locally or committed to GitHub alongside the app.
#
# Usage:
#   chmod +x download_deps.sh
#   ./download_deps.sh
#
# After running, update index.html references:
#   CDN URLs  →  relative paths under ./deps/
#
# The jsquash WASM codecs (avif / webp / jpeg) are ES modules loaded
# dynamically inside a Web Worker. They are downloaded as-is but need
# an ES-module-aware local server (e.g. `npx serve .`) to work — they
# will NOT work when opening index.html via file:// due to CORS rules.

set -euo pipefail

DEPS_DIR="deps"
mkdir -p "$DEPS_DIR"

# ── Helper ────────────────────────────────────────────────────────────────────
download() {
  local url="$1"
  local dest="$DEPS_DIR/$2"
  mkdir -p "$(dirname "$dest")"
  if [ -f "$dest" ]; then
    echo "  [skip]  $dest (already exists)"
  else
    echo "  [dl]    $dest"
    curl -fsSL "$url" -o "$dest"
  fi
}

echo ""
echo "=== Downloading dependencies into ./$DEPS_DIR/ ==="
echo ""

# ── Bootstrap 5.3.2 ──────────────────────────────────────────────────────────
echo "▸ Bootstrap CSS"
download \
  "https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" \
  "bootstrap/5.3.2/bootstrap.min.css"

echo "▸ Bootstrap JS bundle"
download \
  "https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" \
  "bootstrap/5.3.2/bootstrap.bundle.min.js"

# ── JSZip 3.10.1 ─────────────────────────────────────────────────────────────
echo "▸ JSZip"
download \
  "https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js" \
  "jszip/3.10.1/jszip.min.js"

# ── @jsquash/avif 1.0.2 ──────────────────────────────────────────────────────
# The package ships an index.js + avif_enc.wasm / avif_dec.wasm.
# We grab them from unpkg which mirrors the npm package layout.
echo "▸ @jsquash/avif (index + WASM)"
download \
  "https://unpkg.com/@jsquash/avif@1.0.2/index.js" \
  "jsquash/avif/1.0.2/index.js"
download \
  "https://unpkg.com/@jsquash/avif@1.0.2/codec/enc/avif_enc.js" \
  "jsquash/avif/1.0.2/codec/enc/avif_enc.js"
download \
  "https://unpkg.com/@jsquash/avif@1.0.2/codec/enc/avif_enc.wasm" \
  "jsquash/avif/1.0.2/codec/enc/avif_enc.wasm"
download \
  "https://unpkg.com/@jsquash/avif@1.0.2/codec/dec/avif_dec.js" \
  "jsquash/avif/1.0.2/codec/dec/avif_dec.js"
download \
  "https://unpkg.com/@jsquash/avif@1.0.2/codec/dec/avif_dec.wasm" \
  "jsquash/avif/1.0.2/codec/dec/avif_dec.wasm"

# ── @jsquash/webp 1.2.0 ──────────────────────────────────────────────────────
echo "▸ @jsquash/webp (index + WASM)"
download \
  "https://unpkg.com/@jsquash/webp@1.2.0/index.js" \
  "jsquash/webp/1.2.0/index.js"
download \
  "https://unpkg.com/@jsquash/webp@1.2.0/codec/enc/webp_enc.js" \
  "jsquash/webp/1.2.0/codec/enc/webp_enc.js"
download \
  "https://unpkg.com/@jsquash/webp@1.2.0/codec/enc/webp_enc.wasm" \
  "jsquash/webp/1.2.0/codec/enc/webp_enc.wasm"
download \
  "https://unpkg.com/@jsquash/webp@1.2.0/codec/dec/webp_dec.js" \
  "jsquash/webp/1.2.0/codec/dec/webp_dec.js"
download \
  "https://unpkg.com/@jsquash/webp@1.2.0/codec/dec/webp_dec.wasm" \
  "jsquash/webp/1.2.0/codec/dec/webp_dec.wasm"

# ── @jsquash/jpeg 1.4.0 ──────────────────────────────────────────────────────
echo "▸ @jsquash/jpeg (index + WASM)"
download \
  "https://esm.sh/@jsquash/jpeg@1.4.0" \
  "jsquash/jpeg/1.4.0/index.js"
download \
  "https://unpkg.com/@jsquash/jpeg@1.4.0/codec/enc/mozjpeg_enc.js" \
  "jsquash/jpeg/1.4.0/codec/enc/mozjpeg_enc.js"
download \
  "https://unpkg.com/@jsquash/jpeg@1.4.0/codec/enc/mozjpeg_enc.wasm" \
  "jsquash/jpeg/1.4.0/codec/enc/mozjpeg_enc.wasm"
download \
  "https://unpkg.com/@jsquash/jpeg@1.4.0/codec/dec/mozjpeg_dec.js" \
  "jsquash/jpeg/1.4.0/codec/dec/mozjpeg_dec.js"
download \
  "https://unpkg.com/@jsquash/jpeg@1.4.0/codec/dec/mozjpeg_dec.wasm" \
  "jsquash/jpeg/1.4.0/codec/dec/mozjpeg_dec.wasm"

# ── Done ─────────────────────────────────────────────────────────────────────
echo ""
echo "=== Download complete ==="
echo ""
echo "Replace these lines in index.html:"
echo ""
echo "  BEFORE (CDN)"
echo "  ────────────────────────────────────────────────────────────────"
echo "  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css\" ...>"
echo "  <script src=\"https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js\"></script>"
echo "  <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js\"></script>"
echo "  import * as avifCodec from \"https://unpkg.com/@jsquash/avif@1.0.2/index.js?module\";"
echo "  import * as webpCodec from \"https://unpkg.com/@jsquash/webp@1.2.0/index.js?module\";"
echo "  import * as jpegCodec from \"https://esm.sh/@jsquash/jpeg@1.4.0\";"
echo ""
echo "  AFTER (local)"
echo "  ────────────────────────────────────────────────────────────────"
echo "  <link href=\"deps/bootstrap/5.3.2/bootstrap.min.css\" ...>"
echo "  <script src=\"deps/jszip/3.10.1/jszip.min.js\"></script>"
echo "  <script src=\"deps/bootstrap/5.3.2/bootstrap.bundle.min.js\"></script>"
echo "  import * as avifCodec from \"../deps/jsquash/avif/1.0.2/index.js\";"
echo "  import * as webpCodec from \"../deps/jsquash/webp/1.2.0/index.js\";"
echo "  import * as jpegCodec from \"../deps/jsquash/jpeg/1.4.0/index.js\";"
echo ""
echo "NOTE: The jsquash ES modules require a local HTTP server to load"
echo "      (CORS blocks WASM from file:// origins). Run one with:"
echo "        npx serve ."
echo "        python3 -m http.server 8080"
echo ""
