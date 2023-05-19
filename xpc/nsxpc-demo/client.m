#import <Foundation/Foundation.h>

@protocol MyXPCProtocol
- (void)do_something:(NSString *)some_string withReply:(void (^)(uint))reply;
@end

int main(void) {

  NSXPCConnection *my_connection = [[NSXPCConnection alloc]
      initWithMachServiceName:@"tech.macoder.nsxpc"
                      options:NSXPCConnectionPrivileged];

  my_connection.remoteObjectInterface =
      [NSXPCInterface interfaceWithProtocol:@protocol(MyXPCProtocol)];

  [my_connection resume];

  [[my_connection remoteObjectProxy] do_something:@"hello"
                                        withReply:^(uint some_number) {
                                          NSLog(@"Result was: %d", some_number);
                                        }];

  sleep(10);
}