#!/usr/bin/env python3
import os

root = os.path.dirname(os.path.abspath(__file__))
missing = []
for dirpath, _, filenames in os.walk(root):
    for name in filenames:
        if name.endswith('.txt'):
            path = os.path.join(dirpath, name)
            if os.path.getsize(path) == 0:
                missing.append(path)

if missing:
    print('Empty canned output files:')
    for path in missing:
        print(' -', path)
    raise SystemExit(1)

print('All canned output files contain content.')
