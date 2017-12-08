DYNAMIPS_CMAKE_FLAGS := \
	-DDYNAMIPS_CODE=stable -DCMAKE_C_COMPILER=/usr/bin/gcc

.PHONY: all dynamips ubridge iouyap init

all: dynamips ubridge iouyap

dynamips:
	cd dynamips && \
	cmake $(DYNAMIPS_CMAKE_FLAGS) && $(MAKE) install

ubridge:
	$(MAKE) -C ubridge install

iouyap:
	cd iniparser && \
	$(MAKE) && \
	cp libiniparser.* /usr/lib/ && \
	cp src/iniparser.h src/dictionary.h /usr/include
	$(MAKE) -C iouyap
	$(MAKE) -C iouyap install