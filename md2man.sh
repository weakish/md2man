#!/bin/sh

### Convert markdown file to groff man.
usage() {
  echo "Usage: md2man [cmd.1.md ...]"
}

markdown_to_man() {
  for i in "$@"; do
    pandoc --standalone --from markdown --to man --output ${i%.*} $i
  done
}

if [ $# -eq 0 ]; then
  md2man *.*[0-9].m[ad]*
else
  case $1 in
    -h|--help|help) usage;;
    *.*[0-9].m[ad]*) markdown_to_man "$@";;
    *) usage && exit 1;;
  esac
fi
