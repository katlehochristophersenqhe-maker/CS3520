# Ex2 — Sum to N

**What it does:** Sums the integers 1 through N (N read from `.data`) and prints
the total.

**Registers:**
- `t0` — scratch, address of `n`
- `t1` — holds `n`, the fixed loop bound
- `t2` — loop counter `i`
- `s1` — running sum, preserved across the whole loop, printed at the end

**What was harder than expected:** Getting the branch condition inverted correctly
— the C++ loop continues `while (i <= n)`, so the assembly test at the top of the
loop has to branch to the *exit* label when `i > n`, i.e. the opposite condition,
using `bgt` (a pseudo-instruction built from `blt` with swapped operands).
