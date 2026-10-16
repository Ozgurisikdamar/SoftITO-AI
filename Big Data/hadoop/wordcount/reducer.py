#!/usr/bin/env python3
"""Hadoop Streaming reducer: sum counts for each sorted word key."""
import sys

current_word = None
current_count = 0

for line in sys.stdin:
    line = line.rstrip("\n")
    if not line:
        continue
    word, count_text = line.split("\t", 1)
    try:
        count = int(count_text)
    except ValueError:
        continue

    if word == current_word:
        current_count += count
    else:
        if current_word is not None:
            print(f"{current_word}\t{current_count}")
        current_word = word
        current_count = count

if current_word is not None:
    print(f"{current_word}\t{current_count}")
