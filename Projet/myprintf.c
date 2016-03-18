#include <stdarg.h>
#include <inttypes.h>
#include <stdio.h>

void myPrintf(char*,...);
void myPrintfASM(char*,int64_t*);

void myPrintf(char * format, ...){
    va_list ap;
    va_start(ap,format);
    int nb_param = 30;
    int64_t param[nb_param];
    int i = 0;
    for(i = 0; i < nb_param; i++)
        param[i] = 0;
    i = 0;
    do{
        param[i] = va_arg(ap,int64_t);
        i++;
    } while(i < nb_param);
    va_end(ap);
    myPrintfASM(format,param);
}

int main(){
    char * str = "La string";
    int val = 76;
    int val2 = 79;
    myPrintf("Un message\n",(int64_t)val);
    myPrintf("Un caractère %c\n",(int64_t)val);
    myPrintf("Un entier %d\n",(int64_t)val);
    myPrintf("Une string: %s\n",(int64_t)str);
    myPrintf("Deux caractères %c %c\n", (int64_t)val,(int64_t)val2);
    myPrintf("Medley: %c, %d, %s\n",(int64_t)val,(int64_t)val2,(int64_t)str);
    return 0;
}
