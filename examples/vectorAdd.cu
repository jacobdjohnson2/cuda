#include <iostream>
#include <cuda_runtime.h>

#define SIZE 1024

__global__ void vectorAdd(int *a, int *b, int *c, int n) {
    int i = threadIdx.x;
    // int i = blockIdx.x;
    if (i < n) {
        c[i] = a[i] + b[i];
    }
}

int main() {
    int *a, *c;
    cudaMallocManaged(&a, SIZE * sizeof(int));
    cudaMallocManaged(&c, SIZE * sizeof(int));

    for (auto i = 0; i < SIZE; ++i) {
        a[i] = i;
        c[i] = 0;
    }

    vectorAdd<<<1, SIZE>>>(a, a, c, SIZE);
    cudaDeviceSynchronize();

    for (auto i = 0; i < 10; ++i) {
        std::cout << c[i] << std::endl;
    }

    cudaFree(a);
    cudaFree(c);
    
    return 0;
}