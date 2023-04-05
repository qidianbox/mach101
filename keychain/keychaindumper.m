#import <AppKit/AppKit.h>
#import <Security/Security.h>

int main(int argc, char **argv) {
  // http://stackoverflow.com/questions/28177950/how-can-i-enumerate-all-keychain-items-in-my-os-x-application
  @autoreleasepool {
    // 构建查询字典
    // dictionaryWithObjectsAndKeys用法：https://developer.apple.com/documentation/foundation/nsdictionary/1574181-dictionarywithobjectsandkeys
    NSMutableDictionary *query = [NSMutableDictionary
        dictionaryWithObjectsAndKeys:(id)kCFBooleanTrue,       // value
                                     (id)kSecReturnAttributes, // key
                                     (id)kSecMatchLimitAll, (id)kSecMatchLimit,
                                     nil];
    // 包含所有类 keychain 的数组
    // arrayWithObjects用法：https://developer.apple.com/documentation/foundation/nsarray/1460145-arraywithobjects
    NSArray *secItemClasses =
        [NSArray arrayWithObjects:(id)kSecClassGenericPassword,
                                  (id)kSecClassInternetPassword,
                                  (id)kSecClassCertificate, (id)kSecClassKey,
                                  (id)kSecClassIdentity, nil];

    for (id secItemClass in secItemClasses) {
      [query setObject:secItemClass forKey:(id)kSecClass];

      CFTypeRef result = NULL;
      SecItemCopyMatching((CFDictionaryRef)query, &result);
      NSLog(@"%@", (id)result);
      if (result != NULL)
        CFRelease(result);
    }
  }
  return 0;
}