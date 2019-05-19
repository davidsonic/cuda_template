/*
 * calc_3d_unique.cu
 *
 *  Created on: May 19, 2019
 *      Author: jiali
 */




#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <stdio.h>
#include <time.h>
#include <stdlib.h>

__global__ void calc_index(int*data, int size){
	int tid = threadIdx.x + blockDim.x * threadIdx.y + blockDim.x * blockDim.y * threadIdx.z;

	int num_thread_in_block = blockDim.x * blockDim.y * blockDim.z;
	int block_offset = num_thread_in_block * blockIdx.x ;

	int num_thread_in_row = num_thread_in_block * gridDim.x;
	int row_offset = num_thread_in_row * blockIdx.y;

	int num_thread_in_dep = num_thread_in_row * gridDim.y;
	int dep_offset = num_thread_in_dep * blockIdx.z;

	int gid = tid + block_offset + row_offset + dep_offset;
	printf("tid=%d, gid=%d, num=%d\n", tid, gid, data[gid]);


}


int main3(){
	int size = 512;
	int byte_size = size * sizeof(int);
	int *hdata = (int*)malloc(sizeof(int)*size);

	time_t time;
	srand((unsigned)time);
	for(int i=0;i<size;i++){
		hdata[i] = (int)(rand()%0xff);
	}

	int *dData;
	cudaMalloc((int**)&dData, byte_size);
	cudaMemcpy(dData, hdata, byte_size, cudaMemcpyHostToDevice);

	dim3 grid(4,4,4);
	dim3 block(2,2,2);
	calc_index<< <grid, block>> >(dData,size);

	cudaDeviceSynchronize();
	cudaDeviceReset();

	return 0;
}
