import os
import sys
import site

def main():
    if 'SNAP' not in os.environ:
        return
    snap = os.environ['SNAP']
    site.addsitepackages(None, [snap])
