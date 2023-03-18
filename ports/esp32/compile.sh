# N16R8

#esptool.py -p /dev/ttyACM0 -b 460800 erase_flash
#esptool.py -p /dev/ttyACM0 -b 460800 --before default_reset --after no_reset --no-stub --chip esp32s3  write_flash --flash_mode qio --flash_size detect --flash_freq 80m  0x0 build-GENERIC_S3/bootloader/bootloader.bin
#esptool.py -p /dev/ttyACM0 -b 460800 --before default_reset --after no_reset --no-stub --chip esp32s3  write_flash --flash_mode qio --flash_size detect --flash_freq 80m 0x8000 build-GENERIC_S3/partition_table/partition-table.bin 
esptool.py -p /dev/ttyACM0 -b 460800 --before default_reset --after no_reset --no-stub --chip esp32s3  write_flash --flash_mode qio --flash_size detect --flash_freq 80m  0x10000 build-GENERIC_S3_SPIRAM/micropython.bin


