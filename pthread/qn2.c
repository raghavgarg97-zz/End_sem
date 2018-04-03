#include<stdio.h>
#include<stdlib.h>
#include<pthread.h>
#include<string.h>
#include<sys/time.h>
int MAXVAL;

#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

typedef struct Transactions{
	int type;
	double amount;
	int acc1;
	int acc2;
	//int isdone;
}transaction;
transaction* curr;
double ar[10001];
pthread_mutex_t lock[2];
//pthread_mutex_t* lock=(pthread_mutex_t*)malloc(10002*sizeof(pthread_mutex_t));
int gl=0;
int br[10001]={0};
//for(int m=0;m<=10000;m++)br[m]=0;

void* acc_update(void* arg)
{	
	transaction* tcurr;
	int acin1,acin2;
	while(gl<MAXVAL){
		//printf("%d\n",gl);
		//gl++;if(gl<=MAXVAL){tcurr=curr+gl-1;
		//while(o<MAXVAL && curr[o].isdone!=0){o++;}curr[o].isdone=1;tcurr=curr+o;
		pthread_mutex_lock(&lock[0]);
		if(gl>=MAXVAL){pthread_mutex_unlock(&lock[0]);break;}
		tcurr=curr+gl;gl++;
		acin1=(tcurr->acc1)-1000;
		acin2=(tcurr->acc2)-1000;

		
		if(acin2>=1){while(br[acin1]==1 || br[acin2]==1);br[acin1]=1;br[acin2]=1;}
		else {while(br[acin1]==1);br[acin1]=1;}
		pthread_mutex_unlock(&lock[0]);
		
		
		//if(acin2>=1)pthread_mutex_lock(&lock[acin2]);
		if(tcurr->type==1){
		//pthread_mutex_lock(&lock[acin1]);
		ar[acin1]=ar[acin1]+0.99*(tcurr->amount);
		//pthread_mutex_unlock(&lock[acin1]);	
		}	
		else if(tcurr->type==2){
		//pthread_mutex_lock(&lock[acin1]);
		ar[acin1]=ar[acin1]-1.01*(tcurr->amount);
		//pthread_mutex_unlock(&lock[acin1]);	
		}
		else if(tcurr->type==3){
		//pthread_mutex_lock(&lock[acin1]);
		ar[acin1]=1.071*(ar[acin1]);
		//pthread_mutex_unlock(&lock[acin1]);	
		}
		else if(tcurr->type==4) {
		//pthread_mutex_lock(&lock[acin2]);
		ar[acin2]=ar[acin2]+0.99*(tcurr->amount);
		//pthread_mutex_unlock(&lock[acin2]);

		//pthread_mutex_lock(&lock[acin1]);
		ar[acin1]=ar[acin1]-1.01*(tcurr->amount);
		//pthread_mutex_unlock(&lock[acin1]);
		}	
		pthread_mutex_unlock(&lock[1]);
		if(acin2>=1){br[acin1]=0;br[acin2]=0;}
		else {br[acin1]=0;}
		pthread_mutex_unlock(&lock[1]);
	
}	
           
pthread_exit(NULL); 

	
}


int main(int argc,char**argv)
{	
	pthread_t *threads;
	struct timeval start, end;
	if(argc !=5)
		   printf("not enough parameters");
	  
	  int num_threads = atoi(argv[4]);
	  MAXVAL=atoi(argv[3]);
		curr=(transaction*)malloc(MAXVAL*sizeof(transaction));
	  threads=(pthread_t *)malloc(num_threads*sizeof(pthread_t));
	  if(num_threads <=0 || num_threads > 64){
		  printf("invalid num of threads");
	  }
	  ar[0]=0;

	FILE* fp;
	fp=fopen(argv[1],"r");
	if(fp==NULL)printf("Invalid file input");
	size_t size=0;
	char* line=NULL;
	char *pch;
	int acc;double val2;
	int count;
	for(int i=0;i<10000;i++)
	{
	   for(int j=0;j<2;j++)
	      {
		if(j==0)fscanf(fp,"%d",&acc);
		else fscanf(fp,"%lf",&val2);
		
	      }
		ar[acc-1000]=val2;
	}
	fclose(fp);
	fp=fopen(argv[2],"r");
	int dump;
		
	for(int  i=0;i<MAXVAL;i++)
	{
		 for(int j=0;j<5;j++)
	      {
		if(j==0)fscanf(fp,"%d",&dump);
		  else if(j==1)fscanf(fp,"%d",&(curr[i].type));
		  else if(j==2)fscanf(fp,"%lf",&(curr[i].amount));
		  else if(j==3)fscanf(fp,"%d",&(curr[i].acc1));
		  else fscanf(fp,"%d",&(curr[i].acc2));

	      }	   
	}
	fclose(fp);
	/*while(getline(&line,&size,fp)!=-1)
	{
		pch = strtok(line," ");
		count=0;
		while (pch != NULL)
		{
		  if(count==0){acc=atoi(pch);count++;}
		  else val2=atof(pch);
		  pch = strtok (NULL, " ");
		}
		ar[acc-1000]=val2;
	}*/
	
	/*fp=fopen(argv[2],"r");
	if(fp==NULL)printf("Invalid file input");
	int i=0;
	while(getline(&line,&size,fp)!=-1)
	{
		pch = strtok(line," ");
		count=0;
		while (pch != NULL)
		{
		  if(count==0){count++;}
		  else if(count==1){curr[i].type=atoi(pch);count++;}
		  else if(count==2){curr[i].amount=atof(pch);count++;}
		  else if(count==3){curr[i].acc1=atoi(pch);count++;}
		  else curr[i].acc2=atoi(pch);
		 // curr[i].isdone=0;
		
		  pch = strtok (NULL, " ");
		}
		//printf("%f\n",curr[i].amount);
		i++;
	}*/
	//printf("%d----",a);
	for(int k=0;k<2;k++)pthread_mutex_init(&lock[k], NULL);
	
	gettimeofday(&start, NULL);
	//printf("%d",MAXVAL);
	for(int j=0;j<num_threads;j++)
	{
		if(pthread_create(&threads[j], NULL,acc_update,NULL) != 0){
              		perror("pthread_create");
        	        exit(-1);}
        }
	for(int j=0;j<num_threads;j++)
	{
		pthread_join(threads[j], NULL);
        }
	gettimeofday(&end, NULL);	
	
	
	for(int j=1;j<=10000;j++)printf("%d %.2lf\n",j+1000,ar[j]);
	//printf("%d",gl);
	//printf("%lf",curr[100000-1].amount);
	free(curr);
	free(threads);
	//free(ar);
}



















