include config.mk

install:
	@echo Installing exectuable to to ${PREFIX}/bin ...
	@mkdir -p ${PREFIX}/bin
	@cp -f md2man.sh ${PREFIX}/bin/md2man
	@chmod 755 ${PREFIX}/bin/md2man
	@echo Installing manpage to ${MANPREFIX} ...
	@cp -f md2man.1 ${MANPREFIX}/md2man.1
	@cp -f md2man.5 ${MANPREFIX}/md2man.5

uninstall:
	@echo Uninstalling exectuable from ${PREFIX}/bin ...
	@rm -f ${PREFIX}/bin/md2man
	@echo Uninstalling manpage from ${MANPREFIX} ...
	@rm -f ${MANPREFIX}/md2man.1
	@rm -f ${MANPREFIX}/md2man.5