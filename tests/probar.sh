#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$ROOT/tests/salidas"
mkdir -p "$OUT"

# Gaussian debe reconstruir exactamente el mismo resultado sin importar
# si la imagen se divide entre 1, 2, 4 u 8 procesos.
for P in 1 2 4 8; do
  "$ROOT/image_processor" "$ROOT/tests/entrada.ppm" "$OUT/gaussian_${P}.ppm" "$P" gaussian 3
done
cmp "$OUT/gaussian_1.ppm" "$OUT/gaussian_2.ppm"
cmp "$OUT/gaussian_1.ppm" "$OUT/gaussian_4.ppm"
cmp "$OUT/gaussian_1.ppm" "$OUT/gaussian_8.ppm"

"$ROOT/image_processor" "$ROOT/tests/entrada.ppm" "$OUT/gaussian5.ppm" 4 gaussian 5
"$ROOT/image_processor" "$ROOT/tests/entrada.ppm" "$OUT/grayscale.ppm" 4 grayscale
"$ROOT/image_processor" "$ROOT/tests/entrada.ppm" "$OUT/invert.ppm" 4 invert
"$ROOT/image_processor" "$ROOT/tests/entrada.ppm" "$OUT/brightness.ppm" 4 brightness 30
"$ROOT/image_processor" "$ROOT/tests/entrada.ppm" "$OUT/threshold.ppm" 4 threshold 128
"$ROOT/image_processor" "$ROOT/tests/bordes.ppm" "$OUT/sharpen.ppm" 4 sharpen
"$ROOT/image_processor" "$ROOT/tests/bordes.ppm" "$OUT/sobel.ppm" 4 sobel

echo "Pruebas completadas correctamente en $OUT"
