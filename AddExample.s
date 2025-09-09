.text
.global _main
.align 4

_main:
    //add 4 + 6
    mov x0, #4
    mov x1, #6
    //add operation (add x0 and x1 into x0 (x0 = x0 + x1))
    add x0, x0, x1

    //exit the program with syscall 1 (exit status stored in x0, so what we just calculated)
    mov x16, #1
    //call kernel
    svc #0x80
