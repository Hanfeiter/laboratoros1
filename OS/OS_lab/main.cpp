#include <stdio.h>
#include "factorial.h"

int main() {
    int n1 = 10, n2 = 15;
    
    printf("Factorial of %d (recursive) = %lld\n", n1, factorial_recursive(n1));
    printf("Factorial of %d (iterative) = %lld\n", n2, factorial_iterative(n2));
    
    return 0;
}
