#include <stdio.h>
#include <stdlib.h>
#include <sys/ptrace.h>

// Anti-debugging function
void anti_debug() {
    if (ptrace(PTRACE_TRACEME, 0, 1, 0) == -1) {
        printf("Debugger detected!\n");
        exit(EXIT_FAILURE);
    }
}

void foo(int *arr, int size) {
    for (int i = 0; i < size; i++) {
        arr[i] = arr[i] * 2;
    }
}

int main() {
    anti_debug();
    int size = 10;
    int *arr = (int *)malloc(size * sizeof(int));
    for (int i = 0; i < size; i++) {
        arr[i] = i;
    }

    foo(arr, size);

    for (int i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    free(arr);
    return 0;
}
