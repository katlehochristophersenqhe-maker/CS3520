.data

a:    .word 10

.text
.globl main 
main:
        la   t0, a
        lw   t1, 0(t0)
        li   t2, 1 
        li   s1, 0

loop:
        bgt  t2, t1, end_loop        
        add  s1, s1, t2 
        addi t2, t2, 1
        j    loop

end_loop:
        li   a7, 1
        mv   a0, s1
        ecall

        li   a7, 10
        ecall