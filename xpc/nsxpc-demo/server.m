#import <Foundation/Foundation.h>

@protocol MyXPCProtocol
- (void)do_something:(NSString *)some_string withReply:(void (^)(uint))reply;
@end

@interface MyXPCObject : NSObject <MyXPCProtocol>
@end

@implementation MyXPCObject

- (void)do_something:(NSString *)some_string withReply:(void (^)(uint))reply {
  // do domething here
  uint response = 5;
  reply(response);
}
@end

@interface MyDelegate : NSObject <NSXPCListenerDelegate>
@end

@implementation MyDelegate

- (BOOL)listener:(NSXPCListener *)listener
    shouldAcceptNewConnection:(NSXPCConnection *)newConnection {
  newConnection.exportedInterface =
      [NSXPCInterface interfaceWithProtocol:@protocol(MyXPCProtocol)];

  MyXPCObject *my_object = [MyXPCObject new];

  newConnection.exportedObject = my_object;

  [newConnection resume];
  return YES;
}

@end

int main(void) {
  NSXPCListener *listener =
      [[NSXPCListener alloc] initWithMachServiceName:@"tech.macoder.nsxpc"];

  id<NSXPCListenerDelegate> delegate = [MyDelegate new];
  listener.delegate = delegate;
  [listener resume];
  sleep(10);
}