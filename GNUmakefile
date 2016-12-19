include config.mk

scripts := $(basename $(wildcard *.sh))
Executables := $(addprefix bin/, ${scripts})
Markdwon_mans := $(wildcard *.*[0-9].md)
Mans := $(basename ${Markdwon_mans})
get_man_dir = $(subst .,man/man,$(suffix $(1)))
Man_dirs := $(call get_man_dir, ${Mans})
Mans_sorted := $(addsuffix /*.*[0-9], ${Man_dirs})
mans_sorted = $(wildcard ${Mans_sorted})
Executable_path := ${DESTDIR}${PREFIX}/bin
Man_path = ${DESTDIR}${MANPREFIX}


all: clean install

bin/% :: %.sh
	@mkdir -p bin
	@cp --update $< $@

build_man:
	@echo generating manual pages via md2man
	@sh md2man.sh

mandirs: build_man
	@mkdir -p ${Man_dirs}
	$(foreach man, ${Mans}, cp --update ${man} $(call get_man_dir, ${man};))

install: install_bin build_man install_man

install_bin: ${Executables}
	@echo installing executable files to ${Executable_path}
	@mkdir -p ${Executable_path}
	$(foreach exe, ${Executables}, \
	install -m 755 ${exe} ${Executable_path};)

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


.PHONY: all install install_bin install_man clean uninstall reinstall build_man
