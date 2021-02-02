#!/usr/bin/env python
# vi: ft=python

import os
import subprocess

from pathlib import Path

IGNORES = ["install.sh", "README.md", ".git", ".gitattributes", ".gitignore"]

def link_files(src, dest):
    # src: the dots directory
    # dest: the directory where links should be made, typically $HOME
    src_files = []
    src_dirs = []
    for entry in src.iterdir():
        if entry.name in IGNORES:
            continue
        if entry.is_file():
            src_files.append(entry)
        else:
            src_dirs.append(entry)
    for srcfile in src_files + src_dirs:
        destlink = dest / ("." + srcfile.name)
        if destlink.exists():
            if destlink.is_symlink():
                destlink.unlink()
            else:
                print("Renaming %s to %s.bak" % (destlink, destlink))
                destlink.rename(destlink.with_suffix(".bak"))
        print("Linking %s to %s" % (destlink, srcfile.resolve()))
        destlink.symlink_to(srcfile.resolve())
        if srcfile.is_dir():
            init = srcfile / "init.sh"
            if init.exists() and os.access(init, os.X_OK):
                print("Running init.sh in %s" % srcfile)
                subprocess.run(init, cwd=srcfile)

if __name__ == "__main__":
    link_files(Path.cwd(), Path.home())
