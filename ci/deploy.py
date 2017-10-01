#!/usr/bin/env python3

import glob
import json
import os
import sys
import subprocess
import shutil
import shlex
import hashlib

def check_dir_existance(d):
    if not os.path.isdir(d):
       os.makedirs(d)
    assert os.path.isdir(d)


def copy(s, d, root_access_needed):
    if root_access_needed:
        subprocess.call(shlex.split('sudo cp {} {}'.format(s, d)))
    else:
        shutil.copy2(s, d)


def get_md5(f):
    return hashlib.md5(open(f, 'rb').read()).hexdigest()


def is_same(*args):
    assert len(args) == 2
    assert all(list(filter(lambda x : os.path.isfile(x), args)))
    return get_md5(args[0]) == get_md5(args[1])


def show_diff(files, root_access_needed):
    assert len(files) == 2
    for f in files:
        assert os.path.isfile(f), f
    c = ['gvimdiff'] + files
    if root_access_needed:
        c = shlex.split('sudo ' + ' '.join(c))

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
    d = os.path.expanduser(d)
    root_access_needed = not d.startswith('/home')
    print('from', s, 'to', d)
    assert os.path.isfile(s), s
    check_dir_existance(d)
    d_abs = os.path.join(d, os.path.basename(s))
    if os.path.isfile(d_abs) and is_same(s, d_abs):
       print('{} and {} are same. Do nothing.'.format(s, d_abs)) 
    elif os.path.isfile(d_abs):
        answer = query_choice('{} exists.\n View Diff/Prefer New/Prefer Old?' \
                                  .format(d_abs),
                              ['d', 'n', 'o'], 'n')
        if 'd' == answer:
            show_diff([s, d_abs], root_access_needed)
        elif 'n' == answer:
            copy(s, d, root_access_needed)
        elif 'o' == answer:
            print('Did nothing')
    else:
        copy(s, d, root_access_needed)


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
