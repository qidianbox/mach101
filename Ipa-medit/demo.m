// clang -framework Foundation demo.m -o demo
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int count = 10000;
        char none[30] = {0};
        NSLog(@"[tap1000]pid -> %d", getpid());
        NSLog(@"-> %d", count);

        while (count>0) {
            gets(none);
            count--;
            NSLog(@"-> %d", count);
        }
    }
    return 0;
}