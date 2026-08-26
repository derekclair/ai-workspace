"""Pytest bootstrap: make the ``src`` layout importable as top-level packages.

This lets tests use ``from risk.engine import RiskEngine`` without installing the
project or adding ``__init__.py`` files (``risk`` is an implicit namespace package).
"""

import pathlib
import sys

SRC = pathlib.Path(__file__).parent / "src"
if str(SRC) not in sys.path:
    sys.path.insert(0, str(SRC))
