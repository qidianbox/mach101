#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>

int hello() {
    printf("Hello from hello function!\n");
    return rand();
}

int main() {
    // print call
    printf("Hello  World!\n");
    // regular C file operation
    FILE *fp;
    fp = fopen("/tmp/hello-c.txt", "w");
    fprintf(fp, "Hello C!\n");
    fclose(fp);
    
    // call a function
    int r = hello();
    printf("Random number is: %i\n", r);
    
    // obj-c calls
    NSString *hello = @"Hello Obj-C!\n";
    [hello writeToFile:@"/tmp/hello-objc.txt" atomically:YES encoding:NSASCIIStringEncoding error:nil];

    return 0;
}