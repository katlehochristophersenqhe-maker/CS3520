 Ex1 — Larger of Two

What it does:Reads two integers a and b from the .data section and prints
whichever is larger.

Registers:
- t0 — scratch, used to hold the address of a then b
- t1 — holds a
- t2 — holds b
- s1 — holds the final result (larger value), preserved across the branch so it
  can still be read at print_result regardless of which path was taken
- a0, a7 — syscall argument / syscall number, per convention

What was harder than expected: The C++, if (a > b) reads naturally, but in
assembly it's cleaner to test the opposite condition (a < b) and branch to the
"else" case, falling through to the "then" case. This avoids needing a bgt
pseudo-instruction and matches how the assembler actually expands comparisons.