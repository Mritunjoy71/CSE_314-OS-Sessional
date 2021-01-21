#include<unistd.h>
#include<stdlib.h>
#include<stdio.h>
#include<string.h>
#include <sys/shm.h>

#include "on.h"
int main()
{
	int running = 1;
	void *shared_memory = (void *)0;
	struct shared_use_st *shared_stuff;
	int shmid;
	shmid = shmget((key_t)1234, sizeof(struct shared_use_st), 0666 | IPC_CREAT);
	if (shmid == -1) {
		printf("shmget failed\n");
		exit(EXIT_FAILURE);
	}
	shared_memory = shmat(shmid, (void *)0, 0);
	if (shared_memory == (void *)-1) {
		printf("shmat failed\n");
		exit(EXIT_FAILURE);
	}
	printf("Memory attached at %p\n", shared_memory);	
	shared_stuff = (struct shared_use_st *)shared_memory;
	shared_stuff->written_by_you = 0;
	shared_stuff->A=5;
	shared_stuff->B=5;
	shared_stuff->C=5;
	while(running) {
		if (shared_stuff->written_by_you) {
			//printf("You wrote: %s", shared_stuff->some_text);
			//sleep(4); /* make the other process wait for us ! */
			if(shared_stuff->some_text=='A')
			{
			    shared_stuff->A=shared_stuff->A-1;
			    if(shared_stuff->A<0)
                {
                    shared_stuff->A=0;
                }
                else{
                    printf("New value of %c is %d \n",shared_stuff->some_text,(5-shared_stuff->A-1));
                    
                }
                
			    
			}
			shared_stuff->written_by_you = 0;
			
		}
	}
	if (shmdt(shared_memory) == -1) {
		printf("shmdt failed\n");
		exit(EXIT_FAILURE);
	}
	if (shmctl(shmid, IPC_RMID, 0) == -1) {
		printf("shmctl(IPC_RMID) failed\n");
		exit(EXIT_FAILURE);
	}
	exit(EXIT_SUCCESS);
}
