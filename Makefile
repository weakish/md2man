# Edit config.mk to change configurations.
# Why don’t you use autoconf, et al.?
# http://suckless.org/faq
include config.mk

# Simply expanded variables are defined by lines using `:=' (see section Setting
# Variables). The value of a simply expanded variable is scanned once and for
# all, expanding any references to other variables and functions, when the
# variable is defined. The actual value of the simply expanded variable is the
# result of expanding the text that you write. It does not contain any
# references to other variables; it contains their values as of the time this
# variable was defined.
scripts := $(basename $(wildcard *.sh))
Executables := $(addprefix bin/, ${scripts})
# wildcard is a function. A function call looks like `$(f args)` or `f{f args}`.
Markdwon_mans := $(wildcard *.*[0-9].md)
# We dose not use `wildcard` for `Mans` because these files may not exist yet.
# For the same reason, `mans_sorted` below uses `=` instead of `:=`.
Mans := $(basename ${Markdwon_mans})
# Call a function:
get_man_dir = $(subst .,man/man,$(suffix $(1)))
Man_dirs := $(call get_man_dir, ${Mans})
# We add `.` to restrict to current directory, otherwise `Man_dirs` may be
# empty, and `/*.*[0-9]` may be deleted when running `make clean`.
Mans_sorted := $(addsuffix /*.*[0-9], ${Man_dirs})
mans_sorted = $(wildcard ${Mans_sorted})
Executable_path := ${DESTDIR}${PREFIX}/bin
Man_path = ${DESTDIR}${MANPREFIX}


# make
all: clean install

# `%` matches any non empty string. `::` means terminal, %.sh must
# not be any intermediate files
bin/% :: %.sh
	@mkdir -p bin
	@cp --update $< $@
# `$<` first prerequisite; `$@` target.

build_man:
	@echo generating manual pages via md2man
	@sh md2man.sh

mandirs: build_man
	@mkdir -p ${Man_dirs}
#   $(foreach var, ${list}, text)
	$(foreach man, ${Mans}, cp --update ${man} $(call get_man_dir, ${man};))
# Note that we add semicolon at the end, otherwise the generated output will
# be `cmd cmd cmd ...`.

install: install_bin build_man install_man

install_bin: ${Executables}
# DESTDIR is a variable prepended to each installed target file.
# This provides for staged installs, where the installed files are
# not placed directly into their expected location but are instead
# copied into a temporary location (DESTDIR). The DESTDIR variable
# is specified by the user on the make command line as an absolute
# file name. For example:
# 		make DESTDIR=/tmp/stage install
# Pretend `@` before commands to bypass echoing command.
	@echo installing executable files to ${Executable_path}
	@mkdir -p ${Executable_path}
	$(foreach exe, ${Executables}, \
	install -m 755 ${exe} ${Executable_path};)
# Note `@install` is invalid in foreach.

install_man: mandirs
	@echo installing manual pages to ${Man_path}
	$(foreach man, ${mans_sorted}, \
		mkdir -p ${Man_path}/$(dir ${man}); install -m 644 ${man} ${Man_path}/$(dir ${man});)

clean:
	@echo cleaning
	@rm -f ${Executables}
	@rm -f ${mans_sorted}
	@rm -f ${Mans}

uninstall: mandirs
	@echo removing executable file from ${Executable_path}
	$(foreach bin, ${scripts}, \
		rm -f ${Executable_path}/${bin};)
	@echo removing manual page from  ${Man_path}
	$(foreach man, ${mans_sorted}, \
		rm -f ${Man_path}/${man};)

reinstall: uninstall all


# So `make install` and `make uninstall` will always run even if
# there are files called `install` and `uninstall` in the directory.
.PHONY: all install install_bin install_man clean uninstall reinstall build_man
