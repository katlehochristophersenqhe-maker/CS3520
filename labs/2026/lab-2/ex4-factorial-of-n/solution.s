.data
n:      .word 5

.text
.globl main

main:
    la      t0, n
    lw      a0, 0(t0)
    jal     ra, factorial

    li      a7, 1
    ecall

    li      a7, 10
    ecall

factorial:
    addi    sp, sp, -16
    sw      ra, 12(sp)
    sw      a0, 8(sp)

    li      t0, 1
    ble     a0, t0, base_case

    addi    a0, a0, -1
    jal     ra, factorial

    lw      t0, 8(sp)
    mul     a0, a0, t0
    j       return_factorial

base_case:
    li      a0, 1

return_factorial:
    lw      ra, 12(sp)
    addi    sp, sp, 16
    ret