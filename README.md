# mlx-change-i2c-addr

This is a program to change the I2C address of the Melexis MLX90640. It was written and tested on the Raspberry Pi.

Edit the MLX_I2C_ADDR and NEW_I2C_ADDR values in `change_addr/src/change_adrr.cpp` to the values needed.

Use the command `sudo i2cdetect -y 1` to test on RPi. If MLX90640 is detected, the I2C address will be shown in the table.
