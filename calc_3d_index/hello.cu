
#include <stdio.h>
#include <iostream>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <stdlib.h>
#include <time.h>

using namespace std;

__global__ void calc_inde(int * hdata, int size){

	int tid = blockDim.x * threadIdx.y + threadIdx.x;
	int num_thread_in_block = blockDim.x * blockDim.y;
	int block_offset = num_thread_in_block * blockIdx.x;

	int num_thread_in_row = num_thread_in_block * gridDim.x;
	int row_offset = num_thread_in_row * blockIdx.y;

	int gid = tid + row_offset + block_offset;

	printf("tid = %d, gid = %d, num = %d\n", tid, gid, hdata[gid]);


}

int main2(){
	int size = 16;
	int byte_size = sizeof(int)*size;
	int *h = (int*)malloc(byte_size);

	time_t time;
	srand((unsigned)time);
	for (int i=0;i<size;i++){
		h[i] = (int)(rand()%0xff);
	}

	int *cudaData;
	cudaMalloc((int**)&cudaData, byte_size);
	cudaMemcpy(cudaData, h, byte_size, cudaMemcpyHostToDevice);

	dim3 grid(2,2);
	dim3 block(2,2);
	calc_inde<< <grid, block>> >(cudaData, size);

	cudaDeviceSynchronize();
	cudaDeviceReset();


	return 0;
}
