#include <stdio.h>
#include <unistd.h>

#include <sys/types.h>
#include <sys/ptrace.h>
#include <sys/sysctl.h>

#include <mach/mach.h>
#include <mach/mach_init.h>
#include <mach/mach_vm.h>

#include "libkern/OSCacheControl.h"

#import <Foundation/Foundation.h>

mach_vm_address_t get_basic_address(){
    mach_vm_size_t region_size = 0;
    mach_vm_address_t region = 0;
    mach_port_t task = 0;
    int ret = 0;
    // 获取 pid 进程信息
    ret = task_for_pid(mach_task_self(), getpid(), &task);
    if (ret != 0)
    {
        NSLog(@"task_for_pid() error %s!\n", mach_error_string(ret));
        return 0;
    }
    
    vm_region_basic_info_data_64_t info;
    mach_msg_type_number_t info_count = VM_REGION_BASIC_INFO_COUNT_64;
    vm_region_flavor_t flavor = VM_REGION_BASIC_INFO_64;
    // mach_vm_region 列出内存区域
    ret = mach_vm_region(mach_task_self(), &region, &region_size, flavor,
                            (vm_region_info_t)&info,
                            (mach_msg_type_number_t*)&info_count,
                            (mach_port_t*)&task);
    if (ret != KERN_SUCCESS)
    {
        NSLog(@"mach_vm_region() error: %s!\n",mach_error_string(ret));
        return 0;
    }
    return region;
}

int main(int argc, char *argv[])
{
    @autoreleasepool
    {
        mach_vm_address_t address = get_basic_address();
        NSLog(@"Target pid     : %d\n", getpid());
        NSLog(@"Base address   : %llx\n", address);
    }
    return 0;
}