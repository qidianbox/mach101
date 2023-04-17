// from https://gist.github.com/samdmarshall/17f4e66b5e2e579fd396

#import <Foundation/Foundation.h>
#include <mach/mach.h>
#include <malloc/malloc.h>
#include <objc/objc-api.h>
#include <objc/runtime.h>

@interface TEST : NSObject
@end

@implementation TEST
@end

@interface lolol : TEST
@end

@implementation lolol
@end

static Class *internalClassList;
static uint64_t classCount;

void CanHasObjects(task_t task, void *context, unsigned type, vm_range_t *addr,
                   unsigned count) {
  for (uint64_t index = 0; index < count; index++) {
    vm_range_t *range = &addr[index];
    uintptr_t *address = ((uintptr_t *)range->address)[0];
    size_t size = range->size;
    if (size >= sizeof(Class) && address != NULL) {
      for (uint64_t lookupIndex = 0; lookupIndex < classCount; lookupIndex++) {
        Class testClass = (internalClassList[lookupIndex]);
        if (address == testClass) {
          printf("0x%016x -- Class: %s\n", address,
                 object_getClassName((__bridge id)address));
          break;
        }
      }
    }
  }
}

int main(int argc, const char *argv[]) {
  TEST *a = [[TEST alloc] init];
  lolol *b = [[lolol alloc] init];

  internalClassList = objc_copyClassList(&classCount);

  vm_address_t *zones;
  uint64_t count;
  kern_return_t error =
      malloc_get_all_zones(mach_task_self(), NULL, &zones, &count);
  if (error == KERN_SUCCESS) {
    for (uint64_t index = 0; index < count; index++) {
      malloc_zone_t *zone = (malloc_zone_t *)zones[index];
      if (zone != NULL && zone->introspect != NULL) {
        zone->introspect->enumerator(mach_task_self(), NULL,
                                     MALLOC_PTR_IN_USE_RANGE_TYPE, zone, NULL,
                                     &CanHasObjects);
      }
    }
  }
  return 0;
}
