# Ex3 — Count Evens

**What it does:** Walks an 8-element integer array and counts how many elements
are even, then prints the count.

**Registers:**
- `t0` — base address of `arr` (constant for the whole loop)
- `t1` — `arr_len`, the loop bound
- `t2` — loop counter `i`
- `t3` — scratch, computed address `&arr[i]`
- `t5` — the loaded element `arr[i]`
- `t6` — result of the bit test (`arr[i] & 1`)
- `s1` — running count, printed at the end

**What was harder than expected:** Remembering that array indexing needs an
explicit shift (`slli t3, t2, 2`) to convert an element index into a byte offset,
since each `.word` is 4 bytes — there's no automatic scaling like in C++.
