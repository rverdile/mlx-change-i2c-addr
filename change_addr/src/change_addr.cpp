#include <stdio.h>
#include "../../mlx_driver_src/headers/MLX90640_I2C_Driver.h"

#define MLX_I2C_ADDR 0x32
#define NEW_I2C_ADDR 0xBE37 // address you change to needs BE prefix, e.g. 0x37 => 0xBE37
#define MLX_EEPROM_ADDR 0x240F
#define MLX_REGISTER_ADDR 0x8010

int setI2CAddr(uint8_t slaveAddr, uint16_t newAddr) {
	
	uint16_t eeprom_val;
	uint16_t register_val;
	
	// Write new I2C address to MLX EEPROM
	if ( MLX90640_I2CWrite(slaveAddr, MLX_EEPROM_ADDR, NEW_I2C_ADDR) != 0) {
		printf("ERROR: Could not write to EEPROM address %#x\n");
		return -1;
	}
	
	// Write new I2C address to MLX Register
	if ( MLX90640_I2CWrite(slaveAddr, MLX_REGISTER_ADDR, NEW_I2C_ADDR) != 0) {
		printf("ERROR: Could not write to Register address %#x\n");
		return -1;
	}

	return 0;
}

int main() {
	
	if(setI2CAddr(MLX_I2C_ADDR, NEW_I2C_ADDR) == -1) {
		printf("\nERROR: Could not set new I2C address.\n");	
		printf("DO NOT POWER OFF DEVICE IF VALUE AT EEPROM IS 0. MLX90640 WILL NOT WORK AFTER REBOOT.\n");
	}
	
	return 0;
	
}
