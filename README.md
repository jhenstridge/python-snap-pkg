[![Snap Status](https://build.snapcraft.io/badge/jhenstridge/python-snap-pkg.svg)](https://build.snapcraft.io/user/jhenstridge/python-snap-pkg)

This repository contains snap packaging for the Python language
interpreter and standard library.

When installed normally, the interpreter will be run under a strict
confinement policy that will prevent it from accessing files in the
home directory or using the network.  Confinement can be switched off
by installing the snap using the `--devmode` option.

The package also exports two content interface slots that make Python
available to other snap packages.  This provides a safe way for
multiple snap packages to share the same Python interpreter.

Both the `python3` and `python3.6` slots export the same content: the
intention is that newer releases of Python might also provide the
`python3` content ID, but not `python3.6`.  For pure Python packages,
the first might be appropriate.  While packages that contain extension
modules compiled for Python 3.6, the second makes sense.
