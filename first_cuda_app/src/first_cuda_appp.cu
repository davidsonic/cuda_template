#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>

__global__ void hello_cuda(){
	printf("hello cuda\n");

}

int main(){

	dim3 block(4,1,1);
	dim3 grid(8);
	hello_cuda<< <grid, block>> >();
	cudaDeviceSynchronize();
	cudaDeviceReset();
	return 0;
}
