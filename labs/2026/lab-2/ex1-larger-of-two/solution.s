.data

a:    .word 10
b:    .word 20

.text
.global main
.main:
     la   t0, a 
     lw   t1, 0(t0)
     lb   t0, b
     lw   t2, 0(t0)
     print_result:
         bgt   t1, t2, print_a
         mv    a0, t2
         j     print_end

     print_a:
     mv  a0, t1 # a0 = t1
     j   print_end

     print_end:
     li   a7, 1
     ecall

     li   a7, 10
     ecall    
     