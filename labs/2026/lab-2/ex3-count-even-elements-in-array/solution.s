.data
arr:        .word 3, 8, 15, 42, 7, 16, 23, 4
arr_len:    .word 8

.text
main:
    la      t0, arr         # t0 = base address of arr
    la      t4, arr_len
    lw      t1, 0(t4)       # t1 = arr_len (loop bound)
    li      t2, 0           # t2 = i
    li      s1, 0           # s1 = count

loop:
    bge     t2, t1, end_loop        # if i >= arr_len, exit
    slli    t3, t2, 2                # t3 = i * 4 (word offset)
    add     t3, t3, t0                # t3 = &arr[i]
    lw      t5, 0(t3)                 # t5 = arr[i]
    andi    t6, t5, 1                 # t6 = arr[i] & 1 (bit test)
    bnez    t6, skip                  # if odd (bit set), skip
    addi    s1, s1, 1                 # else it's even, count it

skip:
    addi    t2, t2, 1
    j       loop

end_loop:
    li      a7, 1
    mv      a0, s1
    ecall

    li      a7, 10
    ecall
