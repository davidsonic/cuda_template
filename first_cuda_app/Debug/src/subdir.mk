################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CU_SRCS += \
../src/first_cuda_appp.cu 

OBJS += \
./src/first_cuda_appp.o 

CU_DEPS += \
./src/first_cuda_appp.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.cu
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/bin/nvcc -G -g -O0 -gencode arch=compute_20,code=sm_20  -odir "src" -M -o "$(@:%.o=%.d)" "$<"
	/usr/bin/nvcc -G -g -O0 --compile --relocatable-device-code=false -gencode arch=compute_20,code=compute_20 -gencode arch=compute_20,code=sm_20  -x cu -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


