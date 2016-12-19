%MD2MAN(1) md2man-0.0.0 | General Commands Manual

NAME
-----

md2man(1) -- convert markdown to groff man

SYNOPSIS
----------

`md2man` [*cmd.1.md* ...]
`md2man` [**-h**]

DESCRIPTION
------------

`md2man [cmd.1.md ...]` converts markdown files to groff man.

Running `md2man` without any arguments will convert all '*.*[0-9].m[^.]*' files
under the current directory.

`md2man` requires `pandoc`.

OPTIONS
--------

**-h, --help**

> Print usage message.

AUTHOR
-------

Jakukyo Friel <weakish@gmail.com>

COPYRIGHT
----------

Copyright (c) 2015 Jakukyo Friel.

License MIT.

SEE ALSO
----------

**md2man**(5), **pandoc**(1), **pandoc**(5)
