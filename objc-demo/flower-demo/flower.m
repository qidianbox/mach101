#import <Foundation/Foundation.h>

// @protocol 声明协议(myFireProtocol)
@protocol  myFireProtocol
// 默认为 @required 强制
- (void) killLeaves;
@optional // 可选
- (void) zznQ;
@end


// @interface 定义类(myFlower)
@interface myFlower : NSObject <myFireProtocol>
// @property 定义属性
@property NSString *flowerType;
@property int numberOfLeaves;

// - 实例方法
- (void)cutFlower;
- (void)growFlower:(int)value;

// + 类方法
+ (void)hello;
@end


// @implementation 实现类(myFlower)
@implementation myFlower : NSObject
- (void)cutFlower {
    self.numberOfLeaves = 0;
}

- (void)growFlower:(int)value {
    self.numberOfLeaves += value;
}

- (void)trimFlower{
    if (self.numberOfLeaves == 0) {
        return;
    } else if(self.numberOfLeaves < 3){
        self.numberOfLeaves = 0;
    } else{
        self.numberOfLeaves -= 3;
    }
}

- (void)killLeaves {
    [self cutFlower];
}

- (void)addMagicPotion {
    // _numberOfLeaves 私有属性 == self.numberOfLeaves
    _numberOfLeaves  +=  10000;
    NSLog(@"Number  of  leaves:  %i",  self .numberOfLeaves);
}

@end

int main(int argc, char *argv[])
{
    @autoreleasepool
    {
        // 创建myFlower实例
        // myFlower* newFlower = [[myFlower alloc] init];
        myFlower* newFlower = [myFlower new];
        [newFlower growFlower:5];
        newFlower.numberOfLeaves = 2;
        NSLog(@"Number of leaves: %i", newFlower.numberOfLeaves);
        [newFlower setNumberOfLeaves:3];
        NSLog(@"Number of leaves: %i", [newFlower numberOfLeaves]);
        [newFlower addMagicPotion];

        [newFlower trimFlower];
        NSLog(@"Number of leaves: %i", newFlower.numberOfLeaves);
        [newFlower killLeaves];
        NSLog(@"Number of leaves: %i", newFlower.numberOfLeaves);
    }
    return 0;
}