#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>

int seed;

#define CUDA_ERROR_EXIT(str) do{\
                                    cudaError err = cudaGetLastError();\
                                    if( err != cudaSuccess){\
                                             printf("Cuda Error: '%s' for %s\n", cudaGetErrorString(err), str);\
                                             exit(-1);\
                                    }\
                             }while(0);


__global__ void XOR(int *da,int cskip, int num)
{
	
	
	long long int thread_no=blockDim.x * blockIdx.x + threadIdx.x;
	long long int start= thread_no*cskip;
	if(start>=num)return;	
	long long int end=start+cskip-1;
	if(end>=num){end=num-1;}

	
	if(start==end)return;
	if(da[end]!=-1){
		if(thread_no%2!=0){da[end]=da[end]^da[start];da[start]=-1;}
		else {da[start]=da[start]^da[end];da[end]=-1;}
	}
	else {
		if(thread_no%2!=0){da[end]=da[start];da[start]=-1;}
		else {da[end]=-1;}
		

	}
	
	
 
}


int main(int argc,char** argv){

int *ar,num;

if(argc!=3){
		printf("Invalid number of Arguments");
		exit(-1);
}

num=atoi(argv[1]);
seed=atoi(argv[2]);

if(num<=0){
printf("Invalid Number");
		exit(-1);
}

ar=(int*)malloc(num*sizeof(int));
 if(!ar){
          perror("malloc");
          exit(-1);
    }

srand(seed);
for(int i=0;i<num;i++){
	ar[i]=random();
}


int skip=2;
int size=num*sizeof(int);
int xor_output;

int*dA;
cudaMalloc(&dA,size);
CUDA_ERROR_EXIT("cudaMalloc");

//int*cskip;
//cudaMalloc(&cskip,sizeof(int));
//CUDA_ERROR_EXIT("cudaMalloc");

cudaMemcpy(dA, ar, size, cudaMemcpyHostToDevice);
CUDA_ERROR_EXIT("memcpy1");

//cudaMemcpy(&xor_output,&dA[0],sizeof(int), cudaMemcpyDeviceToHost);
//printf("%d\n",xor_output);

//cudaMemcpy(cskip,&skip, sizeof(int), cudaMemcpyHostToDevice);
//CUDA_ERROR_EXIT("memcpy1");


while(skip/2<num){
int num_threads=num/skip;
if(num%skip)num_threads++;
int num_blocks=num_threads/1024;
if(num_threads%1024)num_blocks++;
XOR<<<num_blocks, 1024 >>>(dA,skip,num);
CUDA_ERROR_EXIT("kernel invocation");
skip*=2;
}

cudaMemcpy(&xor_output,&dA[0],sizeof(int), cudaMemcpyDeviceToHost);
CUDA_ERROR_EXIT("memcpy2");

printf("%d\n",xor_output);

cudaFree(dA);
free(ar);

return 0;
}
