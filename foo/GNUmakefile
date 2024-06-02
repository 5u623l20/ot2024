# Compiler settings
CC_GCC = gcc
CC_CLANG = clang
CFLAGS = -g
#CFLAGS_GCC = -L./$(TARGET_DIR) -lrbtree -lm -lpthread
#CFLAGS_GCC = -fprofile-arcs -ftest-coverage
CFLAGS_GCC =
#CFLAGS_CLANG = -L./$(TARGET_DIR) -lrbtree -lm -lpthread
#CFLAGS_CLANG = -fprofile-instr-generate -fcoverage-mapping
CFLAGS_CLANG =
SRC = main.c
#LIB_SRC = rbtree.c
LIB_SRC =
#LIB_NAME = librbtree.so
LIB_NAME =
TARGET_DIR = bin
METRICS_SCRIPT = ./calculate_metrics.sh
ENT_BIN=ent
VALGRIND_BIN=valgrind

# Optimization levels
OPT_LEVELS = O0 O1 O2 O3

# Sanitizers
SANITIZERS = ASan LSan MSan TSan UBSan
GSANITIZERS = ASan LSan TSan UBSan

# Stack protection options
STACK_PROTECTORS = SP SP_STRONG

# ASLR related (PIE)
PIE = PIE

# Control Flow Integrity (CFI) for Clang
CFI = CFI

# Link-Time Optimization (LTO)
LTO = LTO

# Relocation Read-Only (RELRO)
RELRO = RELRO

# Fortify Source
FORTIFY = FORTIFY

# Create target directory
all: $(TARGET_DIR) check-clang check-ent check-gcc check-valgrind lib gcc clang metrics

$(TARGET_DIR):
	mkdir -p $(TARGET_DIR)

# Check if Clang is installed
check-clang:
	@if ! command -v $(CC_CLANG) >/dev/null 2>&1; then \
		echo "$(CC_CLANG) not found, installing..."; \
		apt install -y clang llvm; \
	fi

# Check if ent is installed
check-ent:
	@if ! command -v $(ENT_BIN) >/dev/null 2>&1; then \
		echo "$(ENT_BIN) not found, installing..."; \
		apt install -y ent; \
	fi

# Check if GCC is installed
check-gcc:
	@if ! command -v $(CC_GCC) >/dev/null 2>&1; then \
		echo "$(CC_GCC) not found, installing..."; \
		apt install -y gcc; \
	fi

# Check if valgrind is installed
check-valgrind:
	@if ! command -v $(VALGRIND_BIN) >/dev/null 2>&1; then \
		echo "$(VALGRIND_BIN) not found, installing..."; \
		apt install -y valgrind; \
	fi

# Compile the external library
#lib: $(TARGET_DIR)/$(LIB_NAME)

#$(TARGET_DIR)/$(LIB_NAME): $(LIB_SRC)
#	$(CC_GCC) -shared -fPIC $(LIB_SRC) -o $(TARGET_DIR)/$(LIB_NAME)

# GCC compilation
gcc: $(addprefix $(TARGET_DIR)/main_gcc_, $(OPT_LEVELS)) $(addprefix $(TARGET_DIR)/main_gcc_, $(GSANITIZERS)) $(addprefix $(TARGET_DIR)/main_gcc_, $(STACK_PROTECTORS)) $(addprefix $(TARGET_DIR)/main_gcc_, $(PIE)) $(addprefix $(TARGET_DIR)/main_gcc_, $(LTO)) $(addprefix $(TARGET_DIR)/main_gcc_, $(RELRO)) $(addprefix $(TARGET_DIR)/main_gcc_, $(FORTIFY))

# Clang compilation
clang: $(addprefix $(TARGET_DIR)/main_clang_, $(OPT_LEVELS)) $(addprefix $(TARGET_DIR)/main_clang_, $(SANITIZERS)) $(addprefix $(TARGET_DIR)/main_clang_, $(STACK_PROTECTORS)) $(addprefix $(TARGET_DIR)/main_clang_, $(PIE)) $(addprefix $(TARGET_DIR)/main_clang_, $(CFI)) $(addprefix $(TARGET_DIR)/main_clang_, $(LTO)) $(addprefix $(TARGET_DIR)/main_clang_, $(RELRO)) $(addprefix $(TARGET_DIR)/main_clang_, $(FORTIFY))

# Optimization level targets for GCC
$(TARGET_DIR)/main_gcc_O%: $(SRC)
	$(CC_GCC) -O$* $(CFLAGS) $(CFLAGS_GCC) -o $@ $<

# Optimization level targets for Clang
$(TARGET_DIR)/main_clang_O%: $(SRC)
	$(CC_CLANG) -O$* $(CFLAGS) $(CFLAGS_CLANG) -o $@ $<

# AddressSanitizer targets for GCC
$(TARGET_DIR)/main_gcc_ASan: $(SRC)
	$(CC_GCC) $(CFLAGS) -fsanitize=address $(CFLAGS_GCC) -o $@ $<

# LeakSanitizer targets for GCC
$(TARGET_DIR)/main_gcc_LSan: $(SRC)
	$(CC_GCC) $(CFLAGS) -fsanitize=leak $(CFLAGS_GCC) -o $@ $<

# ThreadSanitizer targets for GCC
$(TARGET_DIR)/main_gcc_TSan: $(SRC)
	$(CC_GCC) $(CFLAGS) -fsanitize=thread $(CFLAGS_GCC) -o $@ $<

# UndefinedBehaviorSanitizer targets for GCC
$(TARGET_DIR)/main_gcc_UBSan: $(SRC)
	$(CC_GCC) $(CFLAGS) -fsanitize=undefined $(CFLAGS_GCC) -o $@ $<

# AddressSanitizer targets for Clang
$(TARGET_DIR)/main_clang_ASan: $(SRC)
	$(CC_CLANG) $(CFLAGS) -fsanitize=address $(CFLAGS_CLANG) -o $@ $<

# LeakSanitizer targets for Clang
$(TARGET_DIR)/main_clang_LSan: $(SRC)
	$(CC_CLANG) $(CFLAGS) -fsanitize=leak $(CFLAGS_CLANG) -o $@ $<

# MemorySanitizer targets for Clang
$(TARGET_DIR)/main_clang_MSan: $(SRC)
	$(CC_CLANG) $(CFLAGS) -fsanitize=memory $(CFLAGS_CLANG) -o $@ $<

# ThreadSanitizer targets for Clang
$(TARGET_DIR)/main_clang_TSan: $(SRC)
	$(CC_CLANG) $(CFLAGS) -fsanitize=thread $(CFLAGS_CLANG) -o $@ $<

# UndefinedBehaviorSanitizer targets for Clang
$(TARGET_DIR)/main_clang_UBSan: $(SRC)
	$(CC_CLANG) $(CFLAGS) -fsanitize=undefined $(CFLAGS_CLANG) -o $@ $<

# Stack protector targets for GCC
$(TARGET_DIR)/main_gcc_SP: $(SRC)
	$(CC_GCC) $(CFLAGS) -fstack-protector-all $(CFLAGS_GCC) -o $@ $<

$(TARGET_DIR)/main_gcc_SP_STRONG: $(SRC)
	$(CC_GCC) $(CFLAGS) -fstack-protector-strong $(CFLAGS_GCC) -o $@ $<

# Stack protector targets for Clang
$(TARGET_DIR)/main_clang_SP: $(SRC)
	$(CC_CLANG) $(CFLAGS) -fstack-protector-all $(CFLAGS_CLANG) -o $@ $<

$(TARGET_DIR)/main_clang_SP_STRONG: $(SRC)
	$(CC_CLANG) $(CFLAGS) -fstack-protector-strong $(CFLAGS_CLANG) -o $@ $<

# Position Independent Executable (PIE) targets for GCC
$(TARGET_DIR)/main_gcc_PIE: $(SRC)
	$(CC_GCC) $(CFLAGS) -fPIE -pie $(CFLAGS_GCC) -o $@ $<

# Position Independent Executable (PIE) targets for Clang
$(TARGET_DIR)/main_clang_PIE: $(SRC)
	$(CC_CLANG) $(CFLAGS) -fPIE -pie $(CFLAGS_CLANG) -o $@ $<

# Control Flow Integrity (CFI) targets for Clang
$(TARGET_DIR)/main_clang_CFI: $(SRC)
	$(CC_CLANG) $(CFLAGS) -fsanitize=cfi -flto -fvisibility=default $(CFLAGS_CLANG) -o $@ $<

# Link-Time Optimization (LTO) targets for GCC
$(TARGET_DIR)/main_gcc_LTO: $(SRC)
	$(CC_GCC) $(CFLAGS) -flto $(CFLAGS_GCC) -o $@ $<

# Link-Time Optimization (LTO) targets for Clang
$(TARGET_DIR)/main_clang_LTO: $(SRC)
	$(CC_CLANG) $(CFLAGS) -flto $(CFLAGS_CLANG) -o $@ $<

# Relocation Read-Only (RELRO) targets for GCC
$(TARGET_DIR)/main_gcc_RELRO: $(SRC)
	$(CC_GCC) $(CFLAGS) -Wl,-z,relro,-z,now $(CFLAGS_GCC) -o $@ $<

# Relocation Read-Only (RELRO) targets for Clang
$(TARGET_DIR)/main_clang_RELRO: $(SRC)
	$(CC_CLANG) $(CFLAGS) -Wl,-z,relro,-z,now $(CFLAGS_CLANG) -o $@ $<

# Fortify Source targets for GCC
$(TARGET_DIR)/main_gcc_FORTIFY: $(SRC)
	$(CC_GCC) $(CFLAGS) -D_FORTIFY_SOURCE=3 $(CFLAGS_GCC) -o $@ $<

# Fortify Source targets for Clang
$(TARGET_DIR)/main_clang_FORTIFY: $(SRC)
	$(CC_CLANG) $(CFLAGS) -D_FORTIFY_SOURCE=3 $(CFLAGS_CLANG) -o $@ $<

# Metrics calculation
metrics: $(TARGET_DIR)
	echo "|                 NAME |  SIZE | FUNCTIONS | JUMP |  ENTROPY | MEMORY | ASAN | CFI | FS | LSAN | LTO | MSAN | PIE | RRO | SP | SPS | TSAN | UBSAN | SCORE |" > result.txt
	for bin in $(TARGET_DIR)/*; do \
		if [ -x "$$bin" ]; then \
			$(METRICS_SCRIPT) $$bin; \
		fi \
	done
	cat result.txt

# Clean target
clean:
	rm -rf $(TARGET_DIR)

.PHONY: all check-gcc check-clang lib gcc clang clean metrics
