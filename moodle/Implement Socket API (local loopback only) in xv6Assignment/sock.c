#include "types.h"
#include "defs.h"
#include "param.h"
#include "spinlock.h"
#include "sock.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"

//
// TODO: Create a structure to maintain a list of sockets
// Should it have locking?
//

struct {
  struct spinlock lock;
  struct sock sock[NPROC];
} stable;
 
void
sinit(void)
{
  initlock(&stable.lock, "stable");
}

int
listen(int lport) {
    //lock stable
    //listen ta kore hocche server
    //remote host er socket ta choose hobe
    //ekta socket k remote port
    //stable.socktable[10].remoteport=10
    //unlock stable
    
    acquire(&stable.lock);
    int i;
    for(i=0;i<NSOCK;i++){
        if(stable.sock[i].localport==lport &&stable.sock[i].state==LISTEN)
            goto LISTENING;    
    }
    
    for(i=0;i<NSOCK;i++){
        if(stable.sock[i].state!=LISTEN && stable.sock[i].state!=CONNECT)
            stable.sock[i].state=LISTEN;
             stable.sock[i].localport=lport;
             break;                        
    }
    release(&stable.lock);
    return 0;
    LISTENING:
    release(&stable.lock);
    return -1;
}

int
connect(int rport, const char* host) {
  //stable lock
  //remote port
  //listen ...remote same
  //client er jonno remote socket er localport arbitary local
  //stable unlock
  
  acquire(&stable.lock);
  int d=-1;
  int i;
  for(i=0;i<NSOCK;i++){
    if(stable.sock[i].localport==rport && stable.sock[i].state==LISTEN){
        d=i;
        goto NEWPORT;  
        }  
    }
  release(&stable.lock);
  return -1;    
NEWPORT:
  for(i=0;i<NSOCK;i++){
    if(stable.sock[i].state!=LISTEN && stable.sock[i].state!=CONNECT){
        stable.sock[i].remoteport=rport;
        stable.sock[i].state=LISTEN;
        stable.sock[i].localport=120;
        stable.sock[d].remoteport=120;
        d=120;
        break;
        }                        
    }
    
  
  release(&stable.lock);
  

  return d;
}

int
send(int lport, const char* data, int n) {
  //localport ->remoteport->buf->data
  //remoteport.data!=hang()
  

  return 0;
}


int
recv(int lport, char* data, int n) {
  //server ...remoteport
  //stable -remoteport-write -read-delete
  

  return 0;
}

int
disconnect(int lport) {
  //
  // TODO: Put the actual implementation of disconnect here.
  //

  return 0;
}
