(aio-win32
  c-function-table
  *internal*
  (libname: aio-win32)
  (header: "aio_win32.h")
  #(ret name args)
  (void* win32_iocp_create)
  (int win32_iocp_assoc (void* void* void*))
  (int win32_iocp_pop (void* int void* void* void*))
  (void* win32_overlapped_alloc)
  (void win32_overlapped_free (void*))
  (void* win32_overlapped_getmydata (void*))
  (void win32_overlapped_setmydata (void* void*))
  (int win32_handle_read_async (void* int int int void* void*))
  (int win32_handle_write_async (void* int int int void* void*))
  (void* win32_process_redirected_child2 (void* void* void* void* void* int int int))
  (void* win32_create_named_pipe_async (void*))
  (int win32_wait_named_pipe_async (void* void*))
  (int win32_process_wait_async (void* void* void* void*))
  (int win32_sockaddr_storage_size)
  (void* win32_socket_create (int int void* void*))
  (int win32_getaddrinfo (void* void* void* int int))
  (void win32_addrinfoex_free (void*))
  (void win32_addrinfoex_read (void* void* void* void* void*))
  (int win32_socket_connect (void* void* void* int void*))
  (int win32_socket_accept (void* void* void* void* int void*))
  (int win32_socket_bind (void* void* int))
  (int win32_socket_listen (void* int))
  (void* win32_finalization_handler_get)
  (void* win32_finalization_handler_create (void* void* void*)))
