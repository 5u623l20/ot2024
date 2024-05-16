#include <stdio.h>
#include "external_library.h" // Assuming external_library.h defines some functions from a third-party library

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <input>\n", argv[0]);
        return 1;
    }

    external_library_function(argv[1]);

    return 0;
}
