#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <xpc/xpc.h>

int main(void) {
  // we create our variables
  xpc_object_t my_bool, my_message;

  // we create our empty dictionary, this will be our message
  my_message = xpc_dictionary_create(NULL, NULL, 0);

  // we create a bool
  my_bool = xpc_bool_create(1);

  // we put our bool into the dictionary, giving it a name
  xpc_dictionary_set_value(my_message, "bool_name", my_bool);

  xpc_connection_t conn =
      xpc_connection_create_mach_service("tech.macoder.xpcdemo", NULL, 0);

  xpc_connection_set_event_handler(conn, ^(xpc_object_t event) {
    printf("Received message in generic event handler: %p\n", event);
    printf("%s\n", xpc_copy_description(event));
  });

  xpc_connection_resume(conn);

  xpc_connection_send_message_with_reply(
      conn, my_message, NULL, ^(xpc_object_t resp) {
        printf("Received message: %p\n", resp);
        printf("%s\n", xpc_copy_description(resp));
        const char *rep = xpc_dictionary_get_string(resp, "reply");
        printf("reply: %s\n", rep);
      });

  sleep(10);
}
