#!/usr/bin/env python
import sys
import os

# Locate MOOSE directory
MOOSE_DIR = os.getenv('MOOSE_DIR', os.path.abspath(os.path.join(os.path.dirname(__name__), '..', 'moose')))
if not os.path.exists(MOOSE_DIR):
    MOOSE_DIR = os.path.abspath(os.path.join(os.path.dirname(__name__), '..', '..', 'moose'))
if not os.path.exists(MOOSE_DIR):
    raise Exception('Failed to locate MOOSE, specify the MOOSE_DIR environment variable.')
os.environ['MOOSE_DIR'] = MOOSE_DIR

# Locate BlackBear directory
BLACKBEAR_DIR = os.getenv('BLACKBEAR_DIR', os.path.join(os.getcwd(), '..', 'blackbear'))
if not os.path.exists(os.path.join(BLACKBEAR_DIR, 'src')):
  BLACKBEAR_DIR = os.getenv('BLACKBEAR_DIR', os.path.join(os.getcwd(), '..', '..', 'blackbear'))
if not os.path.exists(BLACKBEAR_DIR):
  raise Exception('Failed to locate BlackBear, specify the BLACKBEAR_DIR environment variable.')
os.environ['BLACKBEAR_DIR'] = os.path.abspath(BLACKBEAR_DIR)

if 'MASTODON_DIR' not in os.environ:
    os.environ['MASTODON_DIR'] = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))

# Append MOOSE python directory
MOOSE_PYTHON_DIR = os.path.join(MOOSE_DIR, 'python')
if MOOSE_PYTHON_DIR not in sys.path:
    sys.path.append(MOOSE_PYTHON_DIR)

import MooseDocs
import mooseutils
MooseDocs.PROJECT_FILES.update(mooseutils.git_ls_files(BLACKBEAR_DIR))

from MooseDocs import main
if __name__ == '__main__':
    sys.exit(main.run())
