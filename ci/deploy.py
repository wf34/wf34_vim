#!/usr/bin/env python3

import glob
import json
import os
import sys
import subprocess
import shutil


def check_dir_existance(d):
    if not os.path.isdir(d):
       os.makedirs(d)
    assert os.path.isdir(d)


def show_diff(files):
    assert len(files) == 2
    for f in files:
        assert os.path.isfile(f), f
    c = ['gvimdiff'] + files
    rc = subprocess.call(c,
                         stdout = subprocess.DEVNULL,
                         stderr = subprocess.DEVNULL)
    if 0 != rc:
        raise subprocess.CalledProcessError(rc, c)

def query_choice(question, opts, default = None):
    if not default in opts and default is not None:
        raise ValueError("invalid default answer:", default)

    prompt = '[' + '/'.join(list(map( \
        lambda x : x.upper() if x == default else x.lower(), opts))) + ']'

    while True:
        sys.stdout.write(question + prompt)
        choice = input().lower()
        if default is not None and choice == '':
            return default
        elif choice in opts:
            return choice
        else:
            sys.stdout.write("Please respond with", opts)


def process_entry(s, d):
    print('from', s, 'to', d)
    assert os.path.isfile(s), s
    check_dir_existance(d)
    d_abs = os.path.join(d, os.path.basename(s))
    if os.path.isfile(d_abs):
        answer = query_choice('{} exists.\n View Diff/Prefer New/Prefer Old?' \
                                  .format(d_abs),
                              ['d', 'n', 'o'], 'n')
        if 'd' == answer:
            show_diff([s, d_abs])
        elif 'n' == answer:
            shutil.copy2(s, d)
        elif 'o' == answer:
            print('Did nothing')
    else:
        shutil.copy2(s, d)


def expand_wildcard_sequence(wp):
    return glob.glob(wp)


def deploy(cpath):
    print(cpath)
    with open(cpath, 'r') as the_file:
        src_dst_correspondencies = json.loads(the_file.read())
        for s, d in src_dst_correspondencies.items():
            ci_dir = os.path.dirname(sys.argv[0])
            s = os.path.join(os.path.dirname(ci_dir), s)
            slist = expand_wildcard_sequence(s) if '*' in s else [s]
            for s_ in slist:
                process_entry(s_, d)

cmdline_help = sys.argv[0] + ' Usage: <path to deploy_directions.json>'
if sys.version_info[0] < 3:
    raise ValueError('tested for python3 only')
elif '__main__' == __name__:
    if len(sys.argv) != 2 or not os.path.isfile(sys.argv[1]):
        raise ValueError(cmdline_help)
    deploy(sys.argv[1])
