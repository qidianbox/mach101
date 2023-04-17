#import <Foundation/Foundation.h>
#import <mach/mach_vm.h>
#import <malloc/malloc.h>
#import <objc/runtime.h>

static kern_return_t read_local_memory(task_t remote_task,
                                       vm_address_t remote_address,
                                       vm_size_t size, void **local_memory);

int main(int argc, const char *argv[]) {
  pid_t pid = 0;
  task_t remoteTask;

  if (argc > 1) {
    pid = atoi(argv[1]);
  } else {
    printf("Usage: %s <pid>\n", argv[0]);
    exit(-1);
  }

  kern_return_t kr = task_for_pid(mach_task_self(), pid, &remoteTask);
  if (kr != KERN_SUCCESS) {
    printf("[-] Failed to get task port for pid:%d, error: %s\n", pid,
           mach_error_string(kr));
    exit(-1);
  }

  unsigned malloc_zone_count = 0;
  vm_address_t *malloc_zone_addresses;
  malloc_get_all_zones(remoteTask, read_local_memory, &malloc_zone_addresses,
                       &malloc_zone_count);

  for (i = 0; i != malloc_zone_count; i++) {
    vm_address_t zone_address = malloc_zone_addresses[i];
    malloc_zone_t *zone = (malloc_zone_t *)zone_address;
    // TODO...
  }
}

static kern_return_t read_local_memory(task_t remote_task,
                                       vm_address_t remote_address,
                                       vm_size_t size, void **local_memory) {
  *local_memory = (void *)remote_address;
  return KERN_SUCCESS;
}