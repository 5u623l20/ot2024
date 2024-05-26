# Compiler settings
CC_GCC = gcc
CC_CLANG = clang
CFLAGS = -g
#LDFLAGS_GCC = -L./$(TARGET_DIR) -lrbtree -lm -lpthread
LDFLAGS_GCC =
#LDFLAGS_CLANG = -L./$(TARGET_DIR) -lrbtree -lm -lpthread
LDFLAGS_CLANG =
SRC = main.c
#LIB_SRC = rbtree.c
LIB_SRC =
#LIB_NAME = librbtree.so
LIB_NAME =
TARGET_DIR = bin
METRICS_SCRIPT = ./calculate_metrics.sh

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
all: $(TARGET_DIR) check-gcc check-clang lib gcc clang metrics

$(TARGET_DIR):
	mkdir -p $(TARGET_DIR)

# Check if GCC is installed
check-gcc:
	@if ! command -v $(CC_GCC) >/dev/null 2>&1; then \
		echo "$(CC_GCC) not found, installing..."; \
		apt install -y gcc; \
	fi

# Check if Clang is installed
check-clang:
	@if ! command -v $(CC_CLANG) >/dev/null 2>&1; then \
		echo "$(CC_CLANG) not found, installing..."; \
		apt install -y clang; \
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
	$(CC_GCC) -O$* $(CFLAGS) $(LDFLAGS_GCC) -o $@ $<

# Optimization level targets for Clang
$(TARGET_DIR)/main_clang_O%: $(SRC)
	$(CC_CLANG) -O$* $(CFLAGS) $(LDFLAGS_CLANG) -o $@ $<

# AddressSanitizer targets for GCC
$(TARGET_DIR)/main_gcc_ASan: $(SRC)
	$(CC_GCC) $(CFLAGS) -fsanitize=address $(LDFLAGS_GCC) -o $@ $<

# LeakSanitizer targets for GCC
$(TARGET_DIR)/main_gcc_LSan: $(SRC)
	$(CC_GCC) $(CFLAGS) -fsanitize=leak $(LDFLAGS_GCC) -o $@ $<

# ThreadSanitizer targets for GCC
$(TARGET_DIR)/main_gcc_TSan: $(SRC)
	$(CC_GCC) $(CFLAGS) -fsanitize=thread $(LDFLAGS_GCC) -o $@ $<

# UndefinedBehaviorSanitizer targets for GCC
$(TARGET_DIR)/main_gcc_UBSan: $(SRC)
	$(CC_GCC) $(CFLAGS) -fsanitize=undefined $(LDFLAGS_GCC) -o $@ $<

# AddressSanitizer targets for Clang
$(TARGET_DIR)/main_clang_ASan: $(SRC)
	$(CC_CLANG) $(CFLAGS) -fsanitize=address $(LDFLAGS_CLANG) -o $@ $<

# LeakSanitizer targets for Clang
$(TARGET_DIR)/main_clang_LSan: $(SRC)
	$(CC_CLANG) $(CFLAGS) -fsanitize=leak $(LDFLAGS_CLANG) -o $@ $<

# MemorySanitizer targets for Clang
$(TARGET_DIR)/main_clang_MSan: $(SRC)
	$(CC_CLANG) $(CFLAGS) -fsanitize=memory $(LDFLAGS_CLANG) -o $@ $<

# ThreadSanitizer targets for Clang
$(TARGET_DIR)/main_clang_TSan: $(SRC)
	$(CC_CLANG) $(CFLAGS) -fsanitize=thread $(LDFLAGS_CLANG) -o $@ $<

# UndefinedBehaviorSanitizer targets for Clang
$(TARGET_DIR)/main_clang_UBSan: $(SRC)
	$(CC_CLANG) $(CFLAGS) -fsanitize=undefined $(LDFLAGS_CLANG) -o $@ $<

# Stack protector targets for GCC
$(TARGET_DIR)/main_gcc_SP: $(SRC)
	$(CC_GCC) $(CFLAGS) -fstack-protector $(LDFLAGS_GCC) -o $@ $<

$(TARGET_DIR)/main_gcc_SP_STRONG: $(SRC)
	$(CC_GCC) $(CFLAGS) -fstack-protector-strong $(LDFLAGS_GCC) -o $@ $<

# Stack protector targets for Clang
$(TARGET_DIR)/main_clang_SP: $(SRC)
	$(CC_CLANG) $(CFLAGS) -fstack-protector $(LDFLAGS_CLANG) -o $@ $<

$(TARGET_DIR)/main_clang_SP_STRONG: $(SRC)
	$(CC_CLANG) $(CFLAGS) -fstack-protector-strong $(LDFLAGS_CLANG) -o $@ $<

# Position Independent Executable (PIE) targets for GCC
$(TARGET_DIR)/main_gcc_PIE: $(SRC)
	$(CC_GCC) $(CFLAGS) -fPIE -pie $(LDFLAGS_GCC) -o $@ $<

# Position Independent Executable (PIE) targets for Clang
$(TARGET_DIR)/main_clang_PIE: $(SRC)
	$(CC_CLANG) $(CFLAGS) -fPIE -pie $(LDFLAGS_CLANG) -o $@ $<

# Control Flow Integrity (CFI) targets for Clang
$(TARGET_DIR)/main_clang_CFI: $(SRC)
	$(CC_CLANG) $(CFLAGS) -fsanitize=cfi -flto -fvisibility=default $(LDFLAGS_CLANG) -o $@ $<

# Link-Time Optimization (LTO) targets for GCC
$(TARGET_DIR)/main_gcc_LTO: $(SRC)
	$(CC_GCC) $(CFLAGS) -flto $(LDFLAGS_GCC) -o $@ $<

# Link-Time Optimization (LTO) targets for Clang
$(TARGET_DIR)/main_clang_LTO: $(SRC)
	$(CC_CLANG) $(CFLAGS) -flto $(LDFLAGS_CLANG) -o $@ $<

# Relocation Read-Only (RELRO) targets for GCC
$(TARGET_DIR)/main_gcc_RELRO: $(SRC)
	$(CC_GCC) $(CFLAGS) -Wl,-z,relro,-z,now $(LDFLAGS_GCC) -o $@ $<

# Relocation Read-Only (RELRO) targets for Clang
$(TARGET_DIR)/main_clang_RELRO: $(SRC)
	$(CC_CLANG) $(CFLAGS) -Wl,-z,relro,-z,now $(LDFLAGS_CLANG) -o $@ $<

# Fortify Source targets for GCC
$(TARGET_DIR)/main_gcc_FORTIFY: $(SRC)
	$(CC_GCC) $(CFLAGS) -D_FORTIFY_SOURCE=2 $(LDFLAGS_GCC) -o $@ $<

# Fortify Source targets for Clang
$(TARGET_DIR)/main_clang_FORTIFY: $(SRC)
	$(CC_CLANG) $(CFLAGS) -D_FORTIFY_SOURCE=2 $(LDFLAGS_CLANG) -o $@ $<

# Metrics calculation
metrics: $(TARGET_DIR)
	for bin in $(TARGET_DIR)/*; do \
		if [ -x "$$bin" ]; then \
			$(METRICS_SCRIPT) $$bin; \
		fi \
	done

# Clean target
clean:
	rm -rf $(TARGET_DIR)

.PHONY: all check-gcc check-clang lib gcc clang clean metrics
