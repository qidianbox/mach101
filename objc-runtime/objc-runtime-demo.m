#import <Foundation/Foundation.h>
#import <objc/runtime.h>

void getClassList();

int main(int argc, const char *argv[]) {
  getClassList();
  return 0;
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