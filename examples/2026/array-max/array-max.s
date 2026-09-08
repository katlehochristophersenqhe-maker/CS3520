# CS3520 - Worked example: maximum value in an array
# RISC-V assembly translation of model.cpp
#
# Demonstrates: .data storage, load/store, a counted loop, conditional
# branches, a procedure call, and correct use of the stack.

        .data
array:  .word   12, 45, 7, 93, 28, 61, 4
n:      .word   7
msg:    .asciz  "Maximum: "

        .text
main:
        la      a0, array           # a0 = base address of the array
        lw      a1, n               # a1 = number of elements
        jal     ra, find_max        # call find_max(a0, a1); result in a0

        mv      s0, a0              # keep the result safe across the print

        la      a0, msg             # print "Maximum: "
        li      a7, 4
        ecall

        mv      a0, s0              # print the value
        li      a7, 1
        ecall

        li      a7, 10              # exit cleanly
        ecall

# ---------------------------------------------------------------
# find_max(base in a0, count in a1) -> largest element in a0
#
# Uses s1 for the running maximum. s1 is a callee-saved register,
# so the procedure must preserve it on the stack and restore it
# before returning. This is a leaf procedure - it calls nothing -
# so it does not need to save ra.
# ---------------------------------------------------------------
find_max:
        addi    sp, sp, -4          # make room on the stack
        sw      s1, 0(sp)           # preserve the caller's s1

        lw      s1, 0(a0)           # max = array[0]
        li      t1, 1               # i = 1

loop:
        bge     t1, a1, done        # leave the loop once i >= n
        slli    t2, t1, 2           # t2 = i * 4  (word offset)
        add     t3, a0, t2          # t3 = &array[i]
        lw      t4, 0(t3)           # t4 = array[i]
        ble     t4, s1, skip        # skip unless array[i] > max
        mv      s1, t4              # max = array[i]
skip:
        addi    t1, t1, 1           # i++
        beq     x0, x0, loop        # repeat

done:
        mv      a0, s1              # place the result where the caller looks

        lw      s1, 0(sp)           # restore the caller's s1
        addi    sp, sp, 4           # release the stack space
        jalr    x0, ra, 0           # return
