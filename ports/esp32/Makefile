# Makefile for MicroPython on ESP32.
#
# This is a simple, convenience wrapper around idf.py (which uses cmake).

# Select the board to build for, defaulting to GENERIC.
BOARD ?= LOLIN_S3

# If the build directory is not given, make it reflect the board name.
BUILD ?= build-$(BOARD)

# Device serial settings.
PORT ?= /dev/ttyACM0
BAUD ?= 460800

PYTHON ?= python3

# Would be good to use cmake to discover submodules (see how rp2/Makefile does
# it), but on ESP32 the same trick doesn't work because "idf.py build" fails
# on berkeley-db dependency before printing out the submodule list.
# For now just force the submodule dependencies here.
GIT_SUBMODULES += lib/berkeley-db-1.xx lib/micropython-lib

.PHONY: all clean deploy erase submodules FORCE

CMAKE_ARGS =

ifdef USER_C_MODULES
	CMAKE_ARGS += -DUSER_C_MODULES=${USER_C_MODULES}
endif

IDFPY_FLAGS += -D MICROPY_BOARD=$(BOARD) -B $(BUILD) $(CMAKE_ARGS)

ifdef FROZEN_MANIFEST
       IDFPY_FLAGS += -D MICROPY_FROZEN_MANIFEST=$(FROZEN_MANIFEST)
endif

HELP_BUILD_ERROR ?= "See \033[1;31mhttps://github.com/micropython/micropython/wiki/Build-Troubleshooting\033[0m"

define RUN_IDF_PY
	idf.py $(IDFPY_FLAGS) -p $(PORT) -b $(BAUD) $(1)
endef

all:
	idf.py $(IDFPY_FLAGS) build || (echo -e $(HELP_BUILD_ERROR); false)
	@$(PYTHON) makeimg.py \
		$(BUILD)/sdkconfig \
		$(BUILD)/bootloader/bootloader.bin \
		$(BUILD)/partition_table/partition-table.bin \
		$(BUILD)/micropython.bin \
		$(BUILD)/firmware.bin \
		$(BUILD)/micropython.uf2

$(BUILD)/bootloader/bootloader.bin $(BUILD)/partition_table/partition-table.bin $(BUILD)/micropython.bin: FORCE

clean:
	$(call RUN_IDF_PY,fullclean)

deploy:
	esptool.py --chip esp32s3 --no-stub --port $(PORT) --baud $(BAUD) write_flash  -z 0x0 $(BUILD)/firmware.bin
	#$(call RUN_IDF_PY,flash)

erase:
	#$(call RUN_IDF_PY,erase-flash)
	esptool.py -p $(PORT) -b 460800 erase_flash

monitor:
	$(call RUN_IDF_PY,monitor)

size:
	$(call RUN_IDF_PY,size)

size-components:
	$(call RUN_IDF_PY,size-components)

size-files:
	$(call RUN_IDF_PY,size-files)

submodules:
	$(MAKE) -f ../../py/mkrules.mk GIT_SUBMODULES="$(GIT_SUBMODULES)" submodules
