#import <Foundation/Foundation.h>

int main(int argc, char *argv[]) {
  @autoreleasepool {
    // NSString
    NSString *myStr1 = [[NSString alloc] initWithCString:"Lord of The Rings"
                                                encoding:NSUTF8StringEncoding];
    NSString *myStr2 = [NSString stringWithCString:"Dune"
                                          encoding:NSUTF8StringEncoding];
    NSString *combine = [NSString
        stringWithFormat:@"%@ is a great book and %@ is also a great book",
                         myStr1, myStr2];
    NSLog(combine);

    // NSMutableString
    NSMutableString *mut = [NSMutableString stringWithString:@"This is"];
    [mut appendString:@" a mutable string"];
    NSLog(mut);

    // NSNumber
    // character literals.
    NSNumber *theLetterZ = @'Z'; // equivalent to [NSNumber numberWithChar:'Z']

    // integral literals.
    NSNumber *fortyTwo = @42; // equivalent to [NSNumber numberWithInt:42]
    NSNumber *fortyTwoUnsigned =
        @42U; // equivalent to [NSNumber numberWithUnsignedInt:42U]
    NSNumber *fortyTwoLong =
        @42L; // equivalent to [NSNumber numberWithLong:42L]
    NSNumber *fortyTwoLongLong =
        @42LL; // equivalent to [NSNumber numberWithLongLong:42LL]

    // floating point literals.
    NSNumber *piFloat =
        @3.141592654F; // equivalent to [NSNumber numberWithFloat:3.141592654F]
    NSNumber *piDouble =
        @3.1415926535; // equivalent to [NSNumber numberWithDouble:3.1415926535]

    // // BOOL literals.
    NSNumber *yesNumber = @YES; // equivalent to [NSNumber numberWithBool:YES]
    NSNumber *noNumber = @NO;   // equivalent to [NSNumber numberWithBool:NO]
    NSLog(@"%@, %@, %@, %@, %@, %@, %@, %@, %@", theLetterZ, fortyTwo,
          fortyTwoUnsigned, fortyTwoLong, fortyTwoLongLong, piFloat, piDouble,
          yesNumber, noNumber);

    // NSArray 初始化
    NSArray *array1 = [NSArray arrayWithObjects:@"one", @"two", @1, nil];
    NSArray *array2 = @[ @"Hello", [NSNumber numberWithInt:42] ];
    NSArray *array3 = @[ @"1", @"one", @"3", @4, @"ONE" ];
    NSLog(@"array1=%@ \n array2=%@ \n array3=%@", array1, array2, array3);

    // NSMutableArray 初始化
    NSMutableArray *myMutantArray = [NSMutableArray array];
    // 添加元素
    [myMutantArray addObject:@"Leonardo"];
    [myMutantArray addObject:@"Raphael"];
    [myMutantArray addObject:@"Donatello"];
    [myMutantArray addObject:@"Michalangelo"];
    // 修改元素
    [myMutantArray replaceObjectAtIndex:0 withObject:@"turtle"];
    NSLog(@"myMutantArray=%@", myMutantArray);

    // NSDictionary @{} 初始化
    NSDictionary *someDictionary1 = @{
      @"key1" : @42,
      @"key2" : @"Some string",
      @"key3" : myMutantArray,
      @"key4" : myStr1
    };
    // NSDictionary 快速枚举
    for (id key in someDictionary1) {
      id obj = [someDictionary1 objectForKey:key];
      NSLog(@"someDictionary1.%@=%@", key, obj);
    }

    // NSDictionary dictionaryWithObjectsAndKeys 初始化
    NSDictionary *someDictionary2 = [NSDictionary
        dictionaryWithObjectsAndKeys:@42, @"key1", @"Some string", @"key2",
                                     myMutantArray, @"key3", myStr1, @"key4",
                                     nil];
    NSLog(@"someDictionary2=%@", someDictionary2);
    // NSDictionary objectForKey 获取元素
    NSNumber *theAnswerForEverything = [someDictionary2 objectForKey:@"key1"];
    NSLog(@"someDictionary2.key1 = %@", theAnswerForEverything);

    // NSMutableDictionary
    // NSMutableDictionary 初始化
    NSMutableDictionary *myMutantDictionary = [NSMutableDictionary dictionary];
    // NSMutableDictionary setObject 添加元素
    [myMutantDictionary setObject:@1 forKey:@"newkey"];
    [myMutantDictionary setObject:@2 forKey:@"newkey1"];
    [myMutantDictionary setObject:@100 forKey:@"newkey2"];
    // NSMutableDictionary 修改元素1
    myMutantDictionary[@"newkey1"] = @45;
    // NSMutableDictionary 修改元素2
    [myMutantDictionary setValue:@46 forKey:@"newkey"];
    // NSMutableDictionary removeObjectForKey 删除元素
    [myMutantDictionary removeObjectForKey:@"newkey2"];
    NSLog(@"myMutantDictionary = %@", myMutantDictionary);
  }
  return 0;
}