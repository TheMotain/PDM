#include <stdio.h>
#include <inttypes.h>

int64_t fibonacci(int64_t);

int main() {
    printf("%ld\n",fibonacci(9));
}

int64_t fibonacci(int64_t i) {
    if(i == 0) return 0;
    if(i == 1) return 1;
    return fibonacci(i-1) + fibonacci(i-2);
}
