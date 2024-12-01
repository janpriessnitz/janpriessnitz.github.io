#!/usr/bin/env python3
from bs4 import BeautifulSoup
import base64
import sys
import gzip
assert len(sys.argv) >= 3

with open(sys.argv[1]) as html_fp:
  soup = BeautifulSoup(html_fp, 'html.parser')

plot_elems = soup.find_all(attrs={'class': 'prizz_plot'})

for elem in plot_elems:
  ext_fname = elem.attrs['src']
  with open(ext_fname, 'rb') as ext_fp:
    ext_bytes = ext_fp.read()
  compressed = gzip.compress(ext_bytes)
  b = base64.b64encode(compressed)
  s = b.decode()
  new_attr = "data:text/plain;base64,"+s
  elem.attrs['src'] = new_attr
  elem.attrs['compressed'] = "true"

with open(sys.argv[2], "w", encoding='utf-8') as file:
  file.write(str(soup))