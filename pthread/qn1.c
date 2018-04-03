#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#include<string.h>
#include<pthread.h>
#include<math.h>

#define SEED 0x7458
#define MAX_THREADS 64
#define USAGE_EXIT(s) do{ \
                             printf("Usage: %s <# of elements> <# of threads> \n %s\n", argv[0], s); \
                            exit(-1);\
                    }while(0);

#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

int isprime(int n)
{ 
	if(n==2)return 1;
	if(n==3)return 1;
	if(n%2==0)return 0;
	if(n%3==0)return 0;
	int i=5,w=2;
	while(i*i<n)
	{
		if(n%i==0)return 0;
		i=i+w;w=6-w;
	} 
	return 1;   
}


struct thread_param{
	pthread_t tid;
	int* ar;
	int size;
	int skip;
	int max;
};

void* max_pr(void*arg)
{
struct thread_param* param=(struct thread_param*)arg;
int ctr=0;
param->max=-1;
int val;
while(ctr<param->size)
{	
	val=(param->ar)[ctr];
	if(isprime(val)){
		if(val>param->max){
			param->max=val;
		}
	}
	ctr += param->skip;	
}
return NULL;
}

int main(int argc,char**argv)
{
struct thread_param *params;
  struct timeval start, end;
  int *a, num_elements, ctr, num_threads;
  int max;
  int max_index;

  if(argc !=3)
           USAGE_EXIT("not enough parameters");

  num_elements = atoi(argv[1]);
  if(num_elements <=0)
          USAGE_EXIT("invalid num elements");
  
  num_threads = atoi(argv[2]);
  if(num_threads <=0 || num_threads > MAX_THREADS){
          USAGE_EXIT("invalid num of threads");
  }


  
  a = malloc(num_elements * sizeof(int));
  if(!a){
          USAGE_EXIT("invalid num elements, not enough memory");
  }

  srand(SEED);  
  for(ctr=0; ctr<num_elements; ++ctr)
        a[ctr] = random(); 

  

  
  params = malloc(num_threads * sizeof(struct thread_param));
  bzero(params, num_threads * sizeof(struct thread_param));
  
  gettimeofday(&start, NULL);

      
  for(ctr=0; ctr < num_threads; ++ctr){
        struct thread_param *param = params + ctr;
        param->size = num_elements - ctr;
        param->skip = num_threads;
        param->ar = a + ctr;
        
        if(pthread_create(&(param->tid), NULL, max_pr,param) != 0){
              perror("pthread_create");
              exit(-1);
        }
 
  }
  
       
  for(ctr=0; ctr < num_threads; ++ctr){
        struct thread_param *param = params + ctr;
        pthread_join(param->tid, NULL);
        if(ctr == 0 || (ctr > 0 && param->max > max)){
             max = param->max;    
        }
  }
  
  if(max!=-1) 
  printf("Max = %d  ", max);
  else printf("No prime in random sample ");
  gettimeofday(&end, NULL);
  printf("Time taken = %ld microsecs\n", TDIFF(start, end));
  free(a);
  free(params);


}

























