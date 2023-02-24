// clang -arch x86_64 -shared -fno-stack-protector -o execve2 execve2.c
// objdump -d --x86-asm-syntax=intel --print-imm-hex execve2
#include <unistd.h>
int main(void)
{
    execv("/bin/bash", 0);
}