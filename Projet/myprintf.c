#include<inttypes.h>

void myPrintf(char*,int64_t);
//void myPrintf2(char*,...);
void myPrintfASM(char*,int64_t);

void myPrintf(char * format, int64_t pointeur){
    myPrintfASM(format,pointeur);
}

/*void myPrintf2(char * format, ...){
    va_list ap;
    va_start(ap,format);
}*/

int main(){
    char * str = "La string";
    int val = 76;
    myPrintf("Un message\n",(int64_t)val);
    myPrintf("Un caractère %c\n",(int64_t)val);
    myPrintf("Un entier %d\n",(int64_t)val);
    myPrintf("Une string: %s\n",(int64_t)&str);
 //   myPrintf2("toto %c %c\n", (int64_t)&str,(int64_t)&str);
    return 0;
}
