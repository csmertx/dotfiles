// source: https://superuser.com/questions/684890/swap-performance-testing
// needs: root echo 1 > /proc/sys/vm/overcommit_memory

#include <stdio.h>
#include <stdlib.h>


#define MB(size) ( (size) * 1024 * 1024 )

int main(){
    char *p;
    if((p = (char *)malloc(MB(256))) != NULL){
            memset(p, "A", MB(256));
            sleep(300);
    }
}
