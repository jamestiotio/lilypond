# gen-emmentaler-brace.fontforge.py
#
# This file is part of LilyPond, the GNU music typesetter.
#
# Copyright (C) 2020--2023  Han-Wen Nienhuys <hanwen@lilypond.org>
#
# LilyPond is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# LilyPond is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with LilyPond.  If not, see <http://www.gnu.org/licenses/>.


import getopt
import os
import re
import sys

import fontforge
import psMat

(options, files) = \
    getopt.getopt(sys.argv[1:],
                  '',
                  ['in=', 'out=', 'version='])

version = "dev"
indir = ""
output = ""
for opt in options:
    o = opt[0]
    a = opt[1]
    if o == '--in':
        indir = a
    elif o == '--out':
        output = a
    elif o == '--version':
        version = a
    else:
        print(o)
        raise getopt.error

font = fontforge.font()

scale = 1.0
subfonts = []
for c in "abcdefghi":
    subfont = "feta-braces-%s" % c
    subfonts.append(subfont)
    f = fontforge.open(os.path.join(indir, subfont + ".pfb"))
    f.selection.all()
    f.transform(psMat.scale(scale))

    # mergeFonts takes a font, but this is a recent innovation of
    # b53e885e Aug 28, 2018 "Allow passing a font object to
    # mergeFonts()"
    tmp = "tmp.feta-brace-scaled.pfb"
    # Normally, generate() outputs a corresponding *.afm
    # file when creating *.pfb files. Avoid that by calling
    # it with an empty 'flags' tuple.
    f.generate(tmp, flags=())
    font.mergeFonts(tmp)
    os.remove(tmp)
    scale += 1.0

font.fontname = "Emmentaler-Brace"
font.familyname = "Emmentaler-Brace"
font.fullname = "Emmentaler-Brace"
font.weight = "Regular"
font.copyright = "GNU GPL"
font.version = version
# The next field is needed for FontConfig, which bases the selection of
# identical fonts (at least from FontConfig's view) on the font revision
# field of the 'head' table.
ver = version.split(".")
v = int(ver[0])
v += int(ver[1]) / 100
v += int(ver[2]) / 100 / 100 if len(ver) > 2 else 0
font.sfntRevision = v

# Set code points to PUA (Private Use Area)
i = 0
for glyph in font.glyphs():
    glyph.unicode = i + 0xE000
    i += 1

lisp = b""
for sub in subfonts:
    lisp += open(os.path.join(indir, sub) + ".lisp", "rb").read()

font.setTableData("LILC", lisp)
font.setTableData("LILY", b'(design_size . 20)')

font.generate(output)
base, ext = os.path.splitext(output)

font.generate(base + ".svg")
