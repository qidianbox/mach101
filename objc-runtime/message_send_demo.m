#import <Foundation/Foundation.h>
@interface AClass : NSObject
@end
@implementation AClass : NSObject
@end

int main() {
  id a = @"this is nstring";
  [a characterAtIndex:1];

  id acls = [AClass new];
  [acls characterAtIndex:2];
}