#!/usr/bin/env bash

BINARY=$1
SCORE=0

echo "Analyzing binary: $BINARY"

# Binary size
SIZE=$(ls -lh $BINARY | awk '{print $5}')
echo "Binary Size($BINARY):         $SIZE"

# Number of functions
NUM_FUNCTIONS=$(nm $BINARY | grep ' T ' | wc -l)
echo "Number of Functions($BINARY): $NUM_FUNCTIONS"

# Number of indirect jumps
NUM_INDIRECT_JUMPS=$(objdump -d $BINARY | grep -E 'jmp\s+\*|call\s+\*' | wc -l)
echo "Number of Indirect Jumps($BINARY): $NUM_INDIRECT_JUMPS"

# Entropy of the binary
ENTROPY=$(ent $BINARY | grep 'Entropy' | awk '{print $3}')
echo "Entropy of the Binary($BINARY): $ENTROPY"

# Control Flow Complexity
#CFC=$(r2 -qc 'agcc' $BINARY | grep 'Cyclomatic complexity' | awk '{print $3}')
#echo "Control Flow Complexity (Cyclomatic Complexity): $CFC"

# Memory Access Patterns (valgrind)
#MEMORY_ACCESS=$(valgrind --tool=memcheck ./$BINARY 2>&1 | grep 'total heap usage' | awk '{print $5 " allocations, " $7 " frees"}')
#echo "Memory Access Patterns($BINARY): $MEMORY_ACCESS"

# Code Coverage (gcov)
#gcov $(basename $BINARY .c) > /dev/null 2>&1
#COVERAGE=$(gcov $(basename $BINARY .c) | grep 'Lines executed' | awk '{print $3}')
#echo "Code Coverage (gcov): $COVERAGE"

# Obfuscation Patterns and Anti-Debugging Techniques (manual inspection or pattern matching)
#echo "Checking for Anti-Debugging Techniques..."
if strings $BINARY | grep -q 'ptrace'; then
    echo "Anti-Debugging Techniques Detected"
    SCORE=$((SCORE + 9))
fi

# Checking for AddressSanitizer
if nm $BINARY | grep -q '__asan_init'; then
    echo "AddressSanitizer Enabled"
    SCORE=$((SCORE + 5))
fi

# Checking for LeakSanitizer
if nm $BINARY | grep -q '__lsan_init'; then
    echo "LeakSanitizer Enabled"
    SCORE=$((SCORE + 3))
fi

# Checking for MemorySanitizer
if nm $BINARY | grep -q '__msan_init'; then
    echo "MemorySanitizer Enabled"
    SCORE=$((SCORE + 7))
fi

# Checking for ThreadSanitizer
if nm $BINARY | grep -q '__tsan_init'; then
    echo "ThreadSanitizer Enabled"
    SCORE=$((SCORE + 6))
fi

# Checking for UndefinedBehaviorSanitizer
if nm $BINARY | grep -q '__ubsan_init'; then
    echo "UndefinedBehaviorSanitizer Enabled"
    SCORE=$((SCORE + 4))
fi

# Checking for Stack Protector
if nm $BINARY | grep -q '__stack_chk_fail'; then
    echo "Stack Protector Enabled"
    SCORE=$((SCORE + 5))
fi

# Checking for Stack Protector Strong
if nm $BINARY | grep -q '__stack_chk_guard'; then
    echo "Stack Protector Strong Enabled"
    SCORE=$((SCORE + 6))
fi

# Checking for Position Independent Executable (PIE)
if readelf -h $BINARY | grep -q 'Type:.*EXEC'; then
    echo "Position Independent Executable (PIE) Enabled"
    SCORE=$((SCORE + 8))
fi

# Checking for Control Flow Integrity (CFI)
if nm $BINARY | grep -q '__cfi_slowpath'; then
    echo "Control Flow Integrity (CFI) Enabled"
    SCORE=$((SCORE + 10))
fi

# Checking for Link-Time Optimization (LTO)
if nm $BINARY | grep -q '__lto'; then
    echo "Link-Time Optimization (LTO) Enabled"
    SCORE=$((SCORE + 7))
fi

# Checking for Relocation Read-Only (RELRO)
if readelf -l $BINARY | grep -q 'GNU_RELRO'; then
    echo "Relocation Read-Only (RELRO) Enabled"
    SCORE=$((SCORE + 6))
fi

# Checking for Fortify Source
if nm $BINARY | grep -q '__fortify_fail'; then
    echo "Fortify Source Enabled"
    SCORE=$((SCORE + 5))
fi

echo "RESULT | $BINARY | $SIZE | $NUM_FUNCTIONS | $NUM_INDIRECT_JUMPS |"
echo "Score for $BINARY: $SCORE"
