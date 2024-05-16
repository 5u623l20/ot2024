#include <stdio.h>
#include <string.h>

void external_library_function(char *input) {
    char buffer[8];
    strcpy(buffer, input);
    printf("External Library Buffer contents: %s\n", buffer);
}
