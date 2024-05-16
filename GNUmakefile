# Compiler options
CC := gcc
CXX := clang++
CFLAGS := -Wall -Wextra
#LDFLAGS := -L./ -lexternallib
#LDFLAGS := -Wl,-rpath='$ORIGIN' -lexternallib
LDFLAGS = '-Wl,-rpath,$$ORIGIN'
LDLIBS = -L. -lexternallib

# Source files
SRC := main.c
EXTERNAL_SRC := external_library.c

# Targets
TARGET_GCC := exploit_gcc
TARGET_CLANG := exploit_clang
EXTERNAL_TARGET := externallib.so

# Default target
all: $(EXTERNAL_TARGET) gcc clang

# Compile external library
$(EXTERNAL_TARGET): $(EXTERNAL_SRC)
	$(CC) -shared -o $@ $^

# GCC compilation options
gcc: gcc_o0 gcc_o1 gcc_o2 gcc_o3 gcc_os gcc_ofast gcc_lto gcc_pgo gcc_asan gcc_msan gcc_tsan gcc_ubsan gcc_stack_protector gcc_aslr

gcc_o0:
	$(CC) $(SRC) -o $(TARGET_GCC)_o0 $(LDFLAGS) $(LDLIBS)

gcc_o1:
	$(CC) $(SRC) -o $(TARGET_GCC)_o1 -O1 $(LDFLAGS) $(LDLIBS)

gcc_o2:
	$(CC) $(SRC) -o $(TARGET_GCC)_o2 -O2 $(LDFLAGS) $(LDLIBS)

gcc_o3:
	$(CC) $(SRC) -o $(TARGET_GCC)_o3 -O3 $(LDFLAGS) $(LDLIBS)

gcc_os:
	$(CC) $(SRC) -o $(TARGET_GCC)_os -Os $(LDFLAGS) $(LDLIBS)

gcc_ofast:
	$(CC) $(SRC) -o $(TARGET_GCC)_ofast -Ofast $(LDFLAGS) $(LDLIBS)

gcc_lto:
	$(CC) $(SRC) -o $(TARGET_GCC)_lto -flto $(LDFLAGS) $(LDLIBS)

gcc_pgo:
	$(CC) $(SRC) -o $(TARGET_GCC)_pgo -fprofile-generate=$(TARGET_GCC)_pgo.profdata $(LDFLAGS) $(LDLIBS)
	# Run the program to generate profile data
	./$(TARGET_GCC)_pgo
	$(CC) $(SRC) -o $(TARGET_GCC)_pgo -fprofile-use=$(TARGET_GCC)_pgo.profdata $(LDFLAGS) $(LDLIBS)

gcc_asan:
	$(CC) $(SRC) -o $(TARGET_GCC)_asan -fsanitize=address $(LDFLAGS) $(LDLIBS)

gcc_msan:
	$(CC) $(SRC) -o $(TARGET_GCC)_msan -fsanitize=memory $(LDFLAGS) $(LDLIBS)

gcc_tsan:
	$(CC) $(SRC) -o $(TARGET_GCC)_tsan -fsanitize=thread $(LDFLAGS) $(LDLIBS)

gcc_ubsan:
	$(CC) $(SRC) -o $(TARGET_GCC)_ubsan -fsanitize=undefined $(LDFLAGS) $(LDLIBS)

gcc_stack_protector:
	$(CC) $(SRC) -o $(TARGET_GCC)_stack_protector -fstack-protector $(LDFLAGS) $(LDLIBS)

gcc_aslr:
	$(CC) $(SRC) -o $(TARGET_GCC)_aslr -Wl,-z,relro,-z,now $(LDFLAGS) $(LDLIBS)

# Clang compilation options
clang: clang_o0 clang_o1 clang_o2 clang_o3 clang_os clang_ofast clang_lto clang_pgo clang_asan clang_msan clang_tsan clang_ubsan clang_stack_protector clang_aslr

clang_o0:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_o0 $(LDFLAGS) $(LDLIBS)

clang_o1:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_o1 -O1 $(LDFLAGS) $(LDLIBS)

clang_o2:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_o2 -O2 $(LDFLAGS) $(LDLIBS)

clang_o3:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_o3 -O3 $(LDFLAGS) $(LDLIBS)

clang_os:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_os -Os $(LDFLAGS) $(LDLIBS)

clang_ofast:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_ofast -Ofast $(LDFLAGS) $(LDLIBS)

clang_lto:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_lto -flto $(LDFLAGS) $(LDLIBS)

clang_pgo:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_pgo -fprofile-generate=$(TARGET_CLANG)_pgo.profdata $(LDFLAGS) $(LDLIBS)
	# Run the program to generate profile data
	./$(TARGET_CLANG)_pgo
	$(CXX) $(SRC) -o $(TARGET_CLANG)_pgo -fprofile-use=$(TARGET_CLANG)_pgo.profdata $(LDFLAGS) $(LDLIBS)

clang_asan:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_asan -fsanitize=address $(LDFLAGS) $(LDLIBS)

clang_msan:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_msan -fsanitize=memory $(LDFLAGS) $(LDLIBS)

clang_tsan:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_tsan -fsanitize=thread $(LDFLAGS) $(LDLIBS)

clang_ubsan:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_ubsan -fsanitize=undefined $(LDFLAGS) $(LDLIBS)

clang_stack_protector:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_stack_protector -fstack-protector $(LDFLAGS) $(LDLIBS)

clang_aslr:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_aslr -Wl,-z,relro,-z,now $(LDFLAGS) $(LDLIBS)

clean:
	rm -f $(TARGET_GCC)_* $(TARGET_CLANG)_*
