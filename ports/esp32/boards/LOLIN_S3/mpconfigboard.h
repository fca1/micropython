#define MICROPY_HW_BOARD_NAME               "LOLIN S3"
#define MICROPY_HW_MCU_NAME                 "ESP32S3"

#define MICROPY_PY_MACHINE_DAC              (0)

// Enable UART REPL for modules that have an external USB-UART and don't use native USB.
#define MICROPY_HW_ENABLE_UART_REPL         (0)

#define MICROPY_HW_I2C0_SCL                 (41)
#define MICROPY_HW_I2C0_SDA                 (42)

#define MICROPY_HW_SPI1_MOSI                (11)
#define MICROPY_HW_SPI1_MISO                (13)
#define MICROPY_HW_SPI1_SCK                 (12)
