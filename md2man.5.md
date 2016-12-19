%MD2MAN(5) md2man-0.0.0 | File Formats Manual

NAME
-----

md2man -- markdown syntax for **md2man**(1)

DESCRIPTION
--------------

First line:

    % COMMAND(n) command-version | Title

- `n` is section number.
- `command-version` will be displayed in footer.
- `Title` will be displayed in Header.

Others are just normal pandoc markdown.

EXAMPLE
--------

```markdown
% MD2MAN(1) md2man-0.0.0 | General Commands Manual

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

...
```

Will be rendered as:

MD2MAN(5)                   File Formats Manual                 MD2MAN(5)

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

...

md2man-0.0.0                                                    MD2MAN(5)

SEE ALSO
----------

**md2man**(1), **pandoc**(1), **pandoc**(5)


