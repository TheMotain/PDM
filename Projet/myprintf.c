#include<inttypes.h>

void myPrintf(char*,int64_t);
void myPrintfChar(char);

void myPrintf(char * format, int64_t entier){
    int idx = 0;
    while(format[idx] != '\0'){
        myPrintfChar(format[idx]);
        idx++;
    }
}

int main(){
    myPrintf("toto\n",0);
}