
//
// TODO: Define an enumeration to represent socket state.
//
enum state{CLOSE,LISTEN,CONNECT};
//
// TODO: Define a structure to represent a socket.
//

struct sock {
    int localport;
    int remoteport;
    enum state state;
    int owner;
    char buf[128];
    int dataAvailable;
};
