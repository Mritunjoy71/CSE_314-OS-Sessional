#include<bits/stdc++.h>
#include <semaphore.h>
#include <pthread.h>
#include <time.h>
#include<string.h>
#include<unistd.h>
using namespace std;
///for 1st queue
sem_t empty_1;
sem_t full_1;
queue<string> q_1;
pthread_mutex_t q1_lock;

///for 2nd queue
sem_t empty_2;
sem_t full_2;
queue<string> q_2;
pthread_mutex_t q2_lock;

///for 3rd queue
sem_t empty_3;
sem_t full_3;
queue<string> q_3;
pthread_mutex_t q3_lock;

void init_semaphore()
{
    pthread_mutex_init(&q1_lock,0);
    pthread_mutex_init(&q2_lock,0);
    pthread_mutex_init(&q3_lock,0);
	sem_init(&empty_1,0,5);
	sem_init(&full_1,0,0);
	
	sem_init(&empty_2,0,5);
	sem_init(&full_2,0,0);
	
	sem_init(&empty_3,0,5);
	sem_init(&full_3,0,0);	
	
}


void* chef_X(void * arg){
    printf("%s",(char*)arg);
    while(true)
	{
		sem_wait(&empty_1);
        sleep(1);
		pthread_mutex_lock(&q1_lock);		
		//sleep(1);	
		q_1.push("chocolate");
		printf("Chef X produced  chocolate\n");
		printf("Size of queue 1 : %lu\n\n",q_1.size());
		//printf("Size of queue 2(vanilla) : %lu\n",q_2.size());
		//printf("Size of queue 3(chocolate) : %lu\n\n",q_3.size());
		
		pthread_mutex_unlock(&q1_lock);
	
		sem_post(&full_1);
	}

}

void* chef_Y(void * arg){
     printf("%s",(char*)arg);
     
     while(true)
	 {
		sem_wait(&empty_1);
        sleep(1);
		pthread_mutex_lock(&q1_lock);		
		//sleep(1);	
		q_1.push("vanilla");
		printf("Chef Y produced  vanilla cake\n");
		printf("Size of queue 1 : %lu\n\n",q_1.size());
		//printf("Size of queue 2(vanilla) : %lu\n",q_2.size());
		//printf("Size of queue 3(chocolate) : %lu\n\n",q_3.size());
		
		pthread_mutex_unlock(&q1_lock);
	
		sem_post(&full_1);
	}

}

void* chef_Z(void * arg){
     printf("%s",(char*)arg);
     
     while(true)
	 {	
		sem_wait(&full_1);
 		sleep(0.5);
		string item = q_1.front();
		if(item=="chocolate")
		{
		    sem_wait(&empty_3);
            //sleep(1);
		    pthread_mutex_lock(&q1_lock);
            pthread_mutex_lock(&q3_lock);		
		    //sleep(1);	
		    q_1.pop();
		    q_3.push("chocolate");
		    printf("Chef Z transfer chocolate cake from Q_1 --> Q_3 \n");	
		    printf("Size of queue 1 : %lu\n",q_1.size());
		   // printf("Size of queue 2(vanilla) : %lu\n",q_2.size());
		    printf("Size of queue 3(chocolate) : %lu\n\n",q_3.size());
		    
		    pthread_mutex_unlock(&q3_lock);
	    
		    sem_post(&full_3);
		    
		    pthread_mutex_unlock(&q1_lock);
		    
		
		}
		else
        {
            sem_wait(&empty_2);
            //sleep(1);
		    pthread_mutex_lock(&q1_lock);
            pthread_mutex_lock(&q2_lock);			
		    //sleep(1);	
		    q_1.pop();
		    q_2.push("vanilla");
		    printf("Chef Z transfer vanilla cake from Q_1-->Q_2 \n");
		    printf("Size of queue 1 : %lu\n",q_1.size());
	        printf("Size of queue 2(vanilla) : %lu\n\n",q_2.size());
	    	//printf("Size of queue 3(chocolate) : %lu\n\n",q_3.size());
		    
		    pthread_mutex_unlock(&q2_lock);
	    
		    sem_post(&full_2);
		    
		    pthread_mutex_unlock(&q1_lock);
        
        }
		
		sem_post(&empty_1);
	}

}

void* waiter_1(void * arg){
     printf("%s",(char*)arg);
     while(true)
     {	
		sem_wait(&full_3);
 		sleep(1);
		pthread_mutex_lock(&q3_lock);
			
		//sleep(1);
		string item = q_3.front();
		q_3.pop();
		printf("Waiter 1 serverd chocolate\n");
		//printf("Size of queue 1 : %lu\n",q_1.size());
		//printf("Size of queue 2(vanilla) : %lu\n",q_2.size());
		printf("Size of queue 3(chocolate) : %lu\n\n",q_3.size());

		pthread_mutex_unlock(&q3_lock);
		
		sem_post(&empty_3);
	}
}

void* waiter_2(void * arg){
     printf("%s",(char*)arg);
     while(true)
     {	
		sem_wait(&full_2);
 		sleep(1);
		pthread_mutex_lock(&q2_lock);
			
		//sleep(1);
		string item = q_2.front();
		q_2.pop();
		printf("Waiter 2 serverd vanilla\n");
		//printf("Size of queue 1 : %lu\n",q_1.size());
		printf("Size of queue 2(vanilla) : %lu\n\n",q_2.size());
		//printf("Size of queue 3(chocolate) : %lu\n\n",q_3.size());

		pthread_mutex_unlock(&q2_lock);
		
		sem_post(&empty_2);
	}
}

int main(){
    cout<<".....This is IPC offline solution .Stay tuned.....\n\n";
    init_semaphore();
    pthread_t X;
	pthread_t Y;
	pthread_t Z;
	pthread_t W1;
	pthread_t W2;
	char * message1 = (char*)"i am CHEF_X(Chocolate producer)\n";
	char * message2 = (char*)"i am CHEF_Y(Vanilla producer)\n";
	char * message3 =(char*) "i am CHEF_Z(decorator)\n";
	char * message4 = (char*)"i am WAITER_1(Chocolate server)\n";
	char * message5 = (char*)"i am WAITER_2(Vanilla server)\n\n";
    pthread_create(&Z,NULL,chef_Z,(void*)message3 );	
	pthread_create(&Y,NULL,chef_Y,(void*)message2 );
	pthread_create(&W1,NULL,waiter_1,(void*)message4 );
	pthread_create(&X,NULL,chef_X,(void*)message1 );
	pthread_create(&W2,NULL,waiter_2,(void*)message5 );

	pthread_exit(NULL);
	//while(1);
	return 0;

}



