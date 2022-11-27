// clang -framework Foundation hello.m -o hello
// DYLD_INSERT_LIBRARIES=./libexample.dylib ./hello
#import <Foundation/Foundation.h>
int main(int argc, char **argv) {
    @autoreleasepool {
    NSLog(@"HelloWorld!");
    }
}