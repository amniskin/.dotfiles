#!/usr/bin/env python3
import json
import re
from pathlib import Path


if __name__ == '__main__':
    jsonfile = str(Path.home())+'/.config/powerline/colors.json'
    colorjson = json.load(open(jsonfile))
    resources = open(str(Path.home())+'/.Xresources', 'r')

    defs = []
    colors = []

    for row in resources:
        words = row.split()
        if len(words) > 2 and words[0] == "#define":
            defs.append([words[1], words[2][1:]])
        elif len(words) > 0 and re.search("\*color", words[0]):
            num = re.split('(\D+)', words[0][:-1])[2]
            colors.append([words[0][1:-1], num, words[1]])

    out = []

    for col in colors:
        for d in defs:
            if d[0] == col[2]:
                tmp = [col[0], [int(col[1]), d[1]]]
                out.append(tmp)

    for c in out:
        colorjson['colors'][c[0]] = c[1]

    with open(jsonfile, "w") as outfile:
        json.dump(colorjson, outfile)
