FILES = escapeorangebox
PYTHON = python3

help:
	@echo "usage: make <tag>"
	@echo
	@echo "setup   - setup environment for developing"
	@echo "check   - check code for style"
	@echo "format  - try to autoformat code"
	@echo "todo    - list all XXX, TODO and FIXME flags"
	@echo "publish - publish project to pypi"
	@echo "clean   - remove all artifacts"

setup:
	$(PYTHON) -m venv .
	bin/pip install -U pip setuptools
	bin/pip install -e '.[dev]'

check:
	bin/flake8 $(FILES)

format:
	bin/autopep8 -ri $(FILES)

todo:
	grep -nrIF -e TODO -e XXX -e FIXME --color=always README.md $(FILES)

publish:
	bin/python setup.py sdist bdist_wheel
	bin/twine upload -u erik.brinkman dist/*

clean:
	rm -rf bin build dist include lib lib64 share pyvenv.cfg escapeorangebox.egg-info pip-selfcheck.json __pycache__ site-packages

.PHONY: check format todo setup publish clean
