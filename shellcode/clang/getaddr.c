// clang -arch x86_64 -o getaddr getaddr.c
#include <unistd.h>
#include <stdio.h>
int main(void)
{
    printf("0x%lx \n", execv);
}