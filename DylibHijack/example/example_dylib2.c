// clang -shared example_dylib2.c -o libexample.dylib
// OR: gcc -dynamiclib example_dylib2.c -o libexample.dylib
#include <stdio.h>
#include <syslog.h>
__attribute__((constructor)) static void myconstructor(int argc, const char **argv)
{
    printf("[+] dylib constructor called from %s\n", argv[0]);
    syslog(LOG_ERR, "[+]  dylib  constructor  called   from  %s\n", argv[0]);
}