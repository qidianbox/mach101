#import <Foundation/Foundation.h>

int main(int argc, char *argv[]) {
  @autoreleasepool {
    // 初始化 NSFileManager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // fileExistsAtPath 判断路径是是否存在
    if ([fileManager fileExistsAtPath:@"/tmp/zznQ.txt"] == YES) {
      NSLog(@"File exists");
    } else {
      NSLog(@"File not exists");
    }

    // contentsEqualAtPath 比较两个文件的内容
    if ([fileManager contentsEqualAtPath:@"/tmp/file1.txt"
                                 andPath:@"/tmp/file2.txt"] == YES) {
      NSLog(@"File contents match");
    }

    // copyItemAtPath 复制一个文件
    if ([fileManager copyItemAtPath:@"/tmp/file1.txt"
                             toPath:@"/tmp/file2.txt"
                              error:nil] == YES) {
      NSLog(@"Copy successful");
    }
    // 移动文件
    // moveItemAtPath:toPath:error:
    // 删除文件
    // removeItemAtPath:error:

    // 文件管理器接受 NSURL 类型参数的版本来定位资源。
    // copyItemAtURL:toURL:error:
    // removeItemAtURL:error:

    // NSURL
    // fileURLWithPath 创建NSURL对象
    NSURL *fileSrc = [NSURL fileURLWithPath:@"/tmp/file1.txt"];
    NSURL *fileDst = [NSURL fileURLWithPath:@"/tmp/file2.txt"];
    [fileManager moveItemAtURL:fileSrc toURL:fileDst error:nil];

    // 快捷的写入文件方式
    NSString *tmp = @"something temporary";
    [tmp writeToFile:@"/tmp/tmp1.txt"
          atomically:YES
            encoding:NSASCIIStringEncoding
               error:nil];
    // NSURL版本：writeToURL:atomically:encoding:error:

    // 通过 NSFileHandle 写入文件
    NSFileHandle *fileHandle =
        [NSFileHandle fileHandleForWritingAtPath:@"/tmp/tmp2.txt"];
    // 内容追加到文件末尾
    [fileHandle seekToEndOfFile];
    [fileHandle writeData:[tmp dataUsingEncoding:NSUTF8StringEncoding]];
    [fileHandle closeFile];
  }
  return 0;
}