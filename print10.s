// Assemble: clang -arch arm64 print10_write.s -o print10
// Run: ./print10
// This calls the libc write(fd=1, buf, count) function to print "10\n".

        .global _main
        .extern _write

        .text
        .align 2
_main:
        stp     x29, x30, [sp, #-16]!   // prologue
        mov     x29, sp

        mov     x0, #1                  // fd = 1 (stdout)

        adrp    x1, msg@PAGE            // x1 = pointer to msg
        add     x1, x1, msg@PAGEOFF

        mov     x2, #3                  // length = 3 ("10\n")

        bl      _write                  // call write(1, msg, 3)

        mov     w0, #0                  // return 0
        ldp     x29, x30, [sp], #16
        ret

        .section __TEXT,__cstring
        .align 2
msg:    .asciz  "10\n"
