#!/usr/bin/env python3
"""Hadoop Streaming mapper: emit (word, 1) pairs."""
import re
import sys

WORD_RE = re.compile(r"[^\W_]+", flags=re.UNICODE)

for line in sys.stdin:
    for word in WORD_RE.findall(line.lower()):
        print(f"{word}\t1")
