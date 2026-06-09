#!/usr/bin/env python3
"""Slice an AI parts-sheet into individual transparent PNGs, one per connected
part, in reading order.

Handles a transparent OR a flat-white background. Detection (connected
components) runs on a downscaled mask for speed; crops are taken at full
resolution and masked to the component so neighbours never bleed in. Pure Pillow.

Usage: python3 tools/slice_sheet.py <sheet.png> [out_dir] [min_area_frac=0.002]
"""
import os
import sys
from collections import deque
from PIL import Image


def main():
    if len(sys.argv) < 2:
        print("usage: slice_sheet.py <sheet.png> [out_dir] [min_area_frac=0.002]")
        sys.exit(1)
    path = sys.argv[1]
    out_dir = sys.argv[2] if len(sys.argv) > 2 else os.path.join(os.path.dirname(path), "slices")
    min_area_frac = float(sys.argv[3]) if len(sys.argv) > 3 else 0.002

    img = Image.open(path).convert("RGBA")
    W, H = img.size
    factor = max(1, round(max(W, H) / 700))
    sw, sh = max(1, W // factor), max(1, H // factor)
    small = img.resize((sw, sh), Image.BILINEAR)
    spx = small.load()

    def sidx(x, y):
        return y * sw + x

    use_alpha = sum(1 for p in small.getdata() if p[3] < 250) > 0.03 * sw * sh
    fg = bytearray(sw * sh)
    if use_alpha:
        for y in range(sh):
            for x in range(sw):
                if spx[x, y][3] >= 40:
                    fg[sidx(x, y)] = 1
    else:
        bg = bytearray(sw * sh)
        dq = deque()

        def whiteish(p):
            return p[0] >= 235 and p[1] >= 235 and p[2] >= 235

        edge = ([(x, 0) for x in range(sw)] + [(x, sh - 1) for x in range(sw)]
                + [(0, y) for y in range(sh)] + [(sw - 1, y) for y in range(sh)])
        for x, y in edge:
            i = sidx(x, y)
            if not bg[i] and whiteish(spx[x, y]):
                bg[i] = 1
                dq.append((x, y))
        while dq:
            x, y = dq.popleft()
            for dx, dy in ((1, 0), (-1, 0), (0, 1), (0, -1)):
                nx, ny = x + dx, y + dy
                if 0 <= nx < sw and 0 <= ny < sh:
                    j = sidx(nx, ny)
                    if not bg[j] and whiteish(spx[nx, ny]):
                        bg[j] = 1
                        dq.append((nx, ny))
        for i in range(sw * sh):
            if not bg[i]:
                fg[i] = 1

    label = [0] * (sw * sh)
    comps = []
    cur = 0
    for sy in range(sh):
        for sx in range(sw):
            i = sidx(sx, sy)
            if not fg[i] or label[i]:
                continue
            cur += 1
            q = deque([(sx, sy)])
            label[i] = cur
            minx = maxx = sx
            miny = maxy = sy
            area = 0
            while q:
                x, y = q.popleft()
                area += 1
                minx, maxx = min(minx, x), max(maxx, x)
                miny, maxy = min(miny, y), max(maxy, y)
                for dx in (-1, 0, 1):
                    for dy in (-1, 0, 1):
                        if dx == 0 and dy == 0:
                            continue
                        nx, ny = x + dx, y + dy
                        if 0 <= nx < sw and 0 <= ny < sh:
                            j = sidx(nx, ny)
                            if fg[j] and not label[j]:
                                label[j] = cur
                                q.append((nx, ny))
            comps.append({"id": cur, "bbox": (minx, miny, maxx, maxy), "area": area})

    comps = [c for c in comps if c["area"] >= min_area_frac * sw * sh]
    row_h = max(1, sh // 4)
    comps.sort(key=lambda c: (round((c["bbox"][1] + c["bbox"][3]) / 2 / row_h), c["bbox"][0]))

    os.makedirs(out_dir, exist_ok=True)
    print(f"{path}: {W}x{H} (detect {sw}x{sh} x{factor}, {'alpha' if use_alpha else 'white'} bg) -> {len(comps)} parts")
    pad = 2
    for n, c in enumerate(comps, 1):
        minx, miny, maxx, maxy = c["bbox"]
        fx0, fy0 = max(0, (minx - pad) * factor), max(0, (miny - pad) * factor)
        fx1, fy1 = min(W, (maxx + 1 + pad) * factor), min(H, (maxy + 1 + pad) * factor)
        crop = img.crop((fx0, fy0, fx1, fy1)).copy()
        cp = crop.load()
        cid = c["id"]
        cw, ch = crop.size
        for y in range(ch):
            ly = (fy0 + y) // factor
            for x in range(cw):
                lx = (fx0 + x) // factor
                li = sidx(min(lx, sw - 1), min(ly, sh - 1))
                if label[li] != cid:
                    r, g, b, a = cp[x, y]
                    cp[x, y] = (r, g, b, 0)
        name = f"part_{n:02d}.png"
        crop.save(os.path.join(out_dir, name))
        print(f"  {name}  bbox=({fx0},{fy0},{fx1},{fy1})  size={cw}x{ch}")


if __name__ == "__main__":
    main()
