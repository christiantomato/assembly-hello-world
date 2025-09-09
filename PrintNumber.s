/*
Trying to make my ARM64 Program to print out a number using C's printf
*/

//signifies the code section
.text
//define the entry point
.global _main
//ensure main is 4-byte aligned (2^2 = 4)
//function are usually aligned to 4 bytes or 16 for performance, so .align 4 is often seen too
.align 2

_main:
	// -- set up stack frame --
	//allocate 32 bytes from the stack by subtracting 32 off the top
    sub sp, sp, #32
	//save old frame pointer (x29) and link register (x30) into the top half of the 32 byte block
	//also make sure the stack pointer is 16-byte aligned
    stp x29, x30, [sp, #16]
	//set up the new frame pointer for this function
    mov x29, sp

	// -- set up arguments -- 
	//set the address of the format string in x0
    adr x0, formatstr    
	//put integer argument in x1
    mov x1, #69         

	/* Variadic functions (like printf) require all register arguments
	to also be spilled into a "register save area" on the stack
    so printf can reload them uniformly */
	//store 69 into the bottom of the stack
    str x1, [sp]         

	//call printf
    bl _printf

	// -- return exit code and clean --
	//set up exit code 0
    mov x0, #0
	//restore caller's frame pointer and return address
    ldp x29, x30, [sp, #16]
	//deallocate the 32 bytes on the stack
    add sp, sp, #32
	//return from main function
    ret
   
//the format string
formatstr:
	.asciz "%d\n"
	
//PrintNumber.c
/* 
#include <stdio.h>

int main() {

    printf("%d\n", 69);

    return 0;
}
*/
//cc -S PrintNumber.c 	
/*
	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 15, 0	sdk_version 15, 5
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w8, #0                          ; =0x0
	str	w8, [sp, #8]                    ; 4-byte Folded Spill
	stur	wzr, [x29, #-4]
	mov	x9, sp
	mov	x8, #69                         ; =0x45
	str	x8, [x9]
	adrp	x0, l_.str@PAGE
	add	x0, x0, l_.str@PAGEOFF
	bl	_printf
	ldr	w0, [sp, #8]                    ; 4-byte Folded Reload
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"%d\n"

.subsections_via_symbols
*/
