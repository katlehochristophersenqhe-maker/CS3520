# Ex4 — Factorial

**What it does:** Computes N! by calling a `factorial` procedure recursively, and
prints the result.

**Registers:**
- `a0` — argument in (the value `x`) and return value out (the result), per the
  RISC-V calling convention
- `ra` — return address; saved to the stack on entry because `factorial` calls
  itself, so `ra` gets overwritten by the nested call
- `t0` — scratch, used for the base-case comparison and to reload `x` after the
  recursive call returns
- `sp` — stack pointer, moved down 8 bytes per call to make room for the saved
  `ra` and the saved `x`

**What was harder than expected:** Realising that `x` itself has to be saved on
the stack, not just `ra`. `a0` is a caller-saved (temporary) register by
convention, so once the recursive call to `factorial` is made, the value it held
before the call cannot be trusted to survive — it must be saved before the call
and reloaded after it returns, before the multiplication.
