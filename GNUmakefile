# Compiler options
CC := gcc
CXX := clang
CFLAGS := -Wall -Wextra
LDFLAGS :=

# Source files
SRC := main.c

# Targets
TARGET_GCC := exploit_gcc
TARGET_CLANG := exploit_clang

# Default target
all: check-clang check-gcc clang gcc
# Check if Clang is installed

check-clang:
	@if ! command -v $(CC_CLANG) >/dev/null 2>&1; then \
		echo "$(CC_CLANG) not found, installing..."; \
		apt install -y clang llvm; \
	fi

# Check if GCC is installed
check-gcc:
	@if ! command -v $(CC_GCC) >/dev/null 2>&1; then \
		echo "$(CC_GCC) not found, installing..."; \
		apt install -y gcc; \
	fi


# GCC compilation options
gcc: gcc_o0 gcc_o1 gcc_o2 gcc_o3 gcc_os gcc_ofast gcc_lto gcc_pgo gcc_asan gcc_ubsan gcc_stack_protector gcc_aslr

gcc_o0:
	$(CC) $(SRC) -o $(TARGET_GCC)_o0

gcc_o1:
	$(CC) $(SRC) -o $(TARGET_GCC)_o1 -O1

gcc_o2:
	$(CC) $(SRC) -o $(TARGET_GCC)_o2 -O2

gcc_o3:
	$(CC) $(SRC) -o $(TARGET_GCC)_o3 -O3

gcc_os:
	$(CC) $(SRC) -o $(TARGET_GCC)_os -Os

gcc_ofast:
	$(CC) $(SRC) -o $(TARGET_GCC)_ofast -Ofast

gcc_lto:
	$(CC) $(SRC) -o $(TARGET_GCC)_lto -flto

gcc_pgo:
	$(CC) $(SRC) -o $(TARGET_GCC)_pgo -fprofile-generate=$(TARGET_GCC)_pgo.profdata
	./$(TARGET_GCC)_pgo test
	$(CC) $(SRC) -o $(TARGET_GCC)_pgo -fprofile-use=$(TARGET_GCC)_pgo.profdata

gcc_asan:
	$(CC) $(SRC) -o $(TARGET_GCC)_asan -fsanitize=address

#gcc_tsan:
#	$(CC) $(SRC) -o $(TARGET_GCC)_tsan -fsanitize=thread

gcc_ubsan:
	$(CC) $(SRC) -o $(TARGET_GCC)_ubsan -fsanitize=undefined

gcc_stack_protector:
	$(CC) $(SRC) -o $(TARGET_GCC)_stack_protector -fstack-protector

gcc_aslr:
	$(CC) $(SRC) -o $(TARGET_GCC)_aslr -Wl,-z,relro,-z,now

# Clang compilation options
clang: clang_o0 clang_o1 clang_o2 clang_o3 clang_os clang_ofast clang_lto clang_pgo clang_asan clang_msan clang_tsan clang_ubsan clang_stack_protector clang_aslr

clang_o0:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_o0

clang_o1:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_o1 -O1

clang_o2:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_o2 -O2

clang_o3:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_o3 -O3

clang_os:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_os -Os

clang_ofast:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_ofast -Ofast

clang_lto:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_lto -flto

clang_pgo:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_pgo -fprofile-generate=$(TARGET_CLANG)_pgo.profdata
	LLVM_PROFILE_FILE="exploit_clang_pgo.profdata/default.profraw" ./$(TARGET_CLANG)_pgo test
	llvm-profdata merge -sparse exploit_clang_pgo.profdata/default.profraw -o exploit_clang_pgo.profdata/default.profdata
	$(CXX) $(SRC) -o $(TARGET_CLANG)_pgo -fprofile-use=$(TARGET_CLANG)_pgo.profdata

clang_asan:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_asan -fsanitize=address

clang_msan:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_msan -fsanitize=memory

clang_tsan:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_tsan -fsanitize=thread

clang_ubsan:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_ubsan -fsanitize=undefined

clang_stack_protector:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_stack_protector -fstack-protector

clang_aslr:
	$(CXX) $(SRC) -o $(TARGET_CLANG)_aslr -Wl,-z,relro,-z,now

clean:
	rm -rf $(TARGET_GCC)_* $(TARGET_CLANG)_*
