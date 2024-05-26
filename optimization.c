#include <stdio.h>
//#include <string.h>


void counting(char *input, int count) {
    for (int i = 0; i < count; i++){
        int waste = 1 + count;
	printf("%i\n", waste);
    }

    return;
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <input>\n", argv[0]);
        return 1;
    }

    counting(argv[1], 100);

    return 0;
}
