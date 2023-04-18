#import <Foundation/Foundation.h>
#import <objc/message.h>
#import <objc/runtime.h>

void getClassList();
void testRuntimeApi();

int main(int argc, const char *argv[]) {
  // getClassList();
  testRuntimeApi();
  return 0;
}

void testRuntimeApi() {
  NSString *str = @"My string";
  id str2 = @"Another string";

  Class strClass = [str class];
  Class str2Class = [str2 class];

  NSLog(@"str's Class name: %s", class_getName(strClass));
  NSLog(@"str2's Class name: %s", class_getName(str2Class));

  Class strSuper = class_getSuperclass(strClass);
  NSLog(@"Superclass name: %@", NSStringFromClass(strSuper));

  SEL sel1 = @selector(isEqual:);
  NSLog(@"Selector name: %@", NSStringFromSelector(sel1));

  Method m = class_getInstanceMethod(strClass, sel1);
  NSLog(@"Number of arguments: %d", method_getNumberOfArguments(m));
  NSLog(@"Implementation address: 0x%lx",
        (unsigned long)method_getImplementation(m));

  if ([str respondsToSelector:@selector(length)]) {
    NSUInteger num = (NSUInteger)[str performSelector:@selector(length)];
    NSLog(@"length of str: %lu", num);
  }

  NSUInteger i = ((NSUInteger(*)(id, SEL))objc_msgSend)(str, @selector(length));
  NSLog(@"length of str: %lu", i);

  // get the function address
  IMP imp = method_getImplementation(
      class_getInstanceMethod(strClass, @selector(length)));

  // create a variable callImp, and make it a function, which expects the object
  // and selectors as arguments, returning NSUInteger
  NSUInteger (*callImp)(id, SEL) = (typeof(callImp))imp;

  // we make our call, like in C
  NSUInteger j = callImp(str, @selector(length));
  NSLog(@"length of str: %lu", j);
}

void getClassList() {
  int numClasses;
  Class *classes = NULL;

  classes = NULL;
  numClasses = objc_getClassList(NULL, 0);

  if (numClasses > 0) {
    classes = malloc(sizeof(Class) * numClasses);
    numClasses = objc_getClassList(classes, numClasses);
    free(classes);
  }
}