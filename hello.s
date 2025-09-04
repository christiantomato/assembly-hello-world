/*
Hello World Program for arm64 assembly on macOS

Learning assembly for my compiler
 */



//specify the section where machine instructions are going
.text
//specify the starting function (main)
.global _main
//makes sure things land on a 4 byte boundary (not too understanding of technical details but keep it)
.align 2

//the entry point for the program
_main: 
    b _print
    b _exit

//function for writing to terminal
_print:
    //system call number for write is 4 (3 arguments: writing to where, address of message, length of message)
    mov x16, #4
    //1 means standard output to the terminal
    mov x0, #1
    //address of string
    adr x1, message
    //length of string
    mov x2, #12
    //invoke kernel
    svc 0

//function for exiting the program with exit code 0
_exit:
    //move system call number for exit into x8 (syscall number is 1)
    mov x16, #1
    //x0 register takes argument for exit number (0 for success)
    mov x0, #0
    //invoke kernel
    svc 0

//store the hello world message in ram (12 characters)
message: 
    .ascii "hello world\n"