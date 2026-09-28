.data
num1:   .word 48
num2:   .word 18

.text
.globl main
main:
    la      t0, num1
    lw      a0, 0(t0)
    la      t0, num2
    lw      a1, 0(t0)

    jal     ra, gcd
    mv      t1, a0

    li      a7, 1
    mv      a0, t1
    ecall

    li      a7, 10
    ecall

gcd:
gcd_loop:
    beqz    a1, gcd_done
    mv      t0, a1
    rem     a1, a0, a1
    mv      a0, t0
    j       gcd_loop

gcd_done:
    ret