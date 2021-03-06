DYNAMIPS_CMAKE_FLAGS := \
	-DDYNAMIPS_CODE=stable -DCMAKE_C_COMPILER=/usr/bin/gcc

.PHONY: all dynamips ubridge iouyap

all: dynamips ubridge iouyap

dynamips:
	cd dynamips && \
	cmake $(DYNAMIPS_CMAKE_FLAGS) && $(MAKE) install

ubridge:
	sed -i '1s/^/\#include \<sys\/types\.h\>\n/' ubridge/src/netlink/nl.c
	$(MAKE) -C ubridge install

iouyap:
	sed -i -E 's/#include <net\/ethernet.h>/\#if defined\(\_\_UCLIBC\_\_\) \|\| defined\(\_\_GLIBC\_\_\)\n\#include \<net\/ethernet\.h\>\n\#endif/' iouyap/iouyap.c
	sed -i '1s/^/\#include \<pthread\.h\>\n/' iouyap/iouyap.h
	sed -i '1s/^/\#include \<sys\/types\.h\>\n/' iouyap/iouyap.h
	cd iniparser && \
	$(MAKE) && \
	cp libiniparser.* /usr/lib/ && \
	cp src/iniparser.h src/dictionary.h /usr/include
	$(MAKE) -C iouyap
	$(MAKE) -C iouyap install
