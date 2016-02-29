#include <stdio.h>

int saisir(int * list);
void tier(int * list, int nb_elements);

int saisir(int * list) {
    int x = 0;
    int i = 0;
    while(x != -1){
        scanf("%d",&x);
        if(x != -1){
            list[i] = x;
            i++;
        }
    }
    return i;
}

void trier (int * list, int nb_elemnts){
    int i,k,tmp;
    for(i=0;i < nb_elemnts;i++){
        k=i;
        while((k>0) && (list[k] < list[k-1])){
            tmp = list[k-1];
            list[k-1] = list[k];
            list[k] = tmp;
            k--;
        }
    }
}
