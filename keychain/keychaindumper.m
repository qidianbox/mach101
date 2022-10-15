#import <AppKit/AppKit.h>
#import <Security/Security.h>

int main(int argc, char **argv) 
{
    // http://stackoverflow.com/questions/28177950/how-can-i-enumerate-all-keychain-items-in-my-os-x-application
    @autoreleasepool {
        // 构建查询字典
        // dictionaryWithObjectsAndKeys用法：https://developer.apple.com/documentation/foundation/nsdictionary/1574181-dictionarywithobjectsandkeys
        NSMutableDictionary *query = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    (__bridge id)kCFBooleanTrue, // value
                                    (__bridge id)kSecReturnAttributes, // key
                                    (__bridge id)kSecMatchLimitAll, 
                                    (__bridge id)kSecMatchLimit,
                                    nil];
        // 包含所有类 keychain 的数组
        // arrayWithObjects用法：https://developer.apple.com/documentation/foundation/nsarray/1460145-arraywithobjects
        NSArray *secItemClasses = [NSArray arrayWithObjects:
                                    (__bridge id)kSecClassGenericPassword,
                                    (__bridge id)kSecClassInternetPassword,
                                    (__bridge id)kSecClassCertificate,
                                    (__bridge id)kSecClassKey,
                                    (__bridge id)kSecClassIdentity,
                                    nil];

        for (id secItemClass in secItemClasses) {
            [query setObject:secItemClass forKey:(__bridge id)kSecClass];

            CFTypeRef result = NULL;
            SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
            NSLog(@"%@", (__bridge id)result);
            if (result != NULL)
                CFRelease(result);
        }
    }
    return 0;
}