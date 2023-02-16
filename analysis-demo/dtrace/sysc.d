#!/usr/sbin/dtrace -s

syscall:::entry
/execname == "toolsdemo"/ 
{
    printf("%s called %s\n", execname, probefunc);
}
