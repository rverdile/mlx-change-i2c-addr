I2C_MODE = LINUX
I2C_LIBS =
SRC_DIR = change_addr/src/
BUILD_DIR = change_addr/
LIB_DIR = $(SRC_DIR)lib/

program = change_addr
program_objects = $(addsuffix .o,$(addprefix $(SRC_DIR), $(program)))
program_output = $(addprefix $(BUILD_DIR), $(program))

all: program

program: $(program_output)

libMLX90640_API.so: mlx_driver_src/functions/MLX90640_API.o mlx_driver_src/functions/MLX90640_$(I2C_MODE)_I2C_Driver.o
	$(CXX) -fPIC -shared $^ -o $@ $(I2C_LIBS)

libMLX90640_API.a: mlx_driver_src/functions/MLX90640_API.o mlx_driver_src/functions/MLX90640_$(I2C_MODE)_I2C_Driver.o
	ar rcs $@ $^
	ranlib $@

mlx_driver_src/functions/MLX90640_API.o mlx_driver_src/functions/MLX90640_$(I2C_MODE)_I2C_Driver.o : CXXFLAGS+=-fPIC -I mlx_driver_src/headers -shared $(I2C_LIBS)

$(program_objects) : CXXFLAGS+=-std=c++11

$(program_output) : CXXFLAGS+=-I. -std=c++11

$(BUILD_DIR)change_addr: $(SRC_DIR)change_addr.o libMLX90640_API.a
	$(CXX) -L/home/pi/mlx90640-library $^ -o $@ $(I2C_LIBS)

clean:
	rm -f $(program_output)
	rm -f $(SRC_DIR)*.o
	rm -f $(LIB_DIR)*.o
	rm -f functions/*.o
	rm -f *.o
	rm -f *.so
	rm -f *.a
