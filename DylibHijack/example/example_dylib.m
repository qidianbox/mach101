// clang -shared -framework Foundation example_dylib.m -o libexample.dylib
#import <Foundation/Foundation.h>
static void __attribute__((constructor)) initialize(void) {
  NSLog(@"insert_dylib i'm here");
}