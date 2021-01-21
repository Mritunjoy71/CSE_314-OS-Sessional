#include<bits/stdc++.h>
#include <semaphore.h>
#include <pthread.h>
#include <time.h>
using namespace std;
///for 1st queue
sem_t empty_1;
sem_t full_1;
queue<int> q_1;

///for 2nd queue
sem_t empty_2;
sem_t full_2;
queue<int> q_2;

///for 3rd queue
sem_t empty_3;
sem_t full_3;
queue<int> q_3;





int main(){
    cout<<"This is IPC offline solution .Stay tuned....\n";



    return 0;
}
