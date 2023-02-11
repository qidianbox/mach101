#import <Foundation/Foundation.h>

// 定义一个 callbackLogger 块类型
typedef void (^callbackLogger)(void);
// 作为一个函数的参数
void genericLogger(callbackLogger blockParam) {
    blockParam();
    NSLog(@"%@", @"This is my function");
}

int main(int argc, char *argv[])
{
    @autoreleasepool
    {
        // Block 声明
        // returnType (^blockName)(argumentType1, argumentType2, ...);
        // Block 实现
        // returnType (^blockName)(argumentType1, argumentType2, ...) = ^(argumentType1 param1, argumentType2 param2, ...){
        //     //do  something   here
        // };

        // exmaple 1：将一个值乘以2
        int (^multiply)(int) = ^(int a){
            return a*2;
        };
        NSLog(@"Multiply x2: %d",  multiply(3));

        // exmaple 2：作为函数参数
        callbackLogger myLogger = ^{
            NSLog(@"%@", @"This is my block");
        };
        genericLogger(myLogger);
        // exmaple 2.1： inline 调用
        genericLogger(^{
            NSLog(@"%@", @"This is my second block");
        });

    }
    return 0;
}