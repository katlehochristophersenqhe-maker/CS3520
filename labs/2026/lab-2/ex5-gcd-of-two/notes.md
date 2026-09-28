# Ex5 — GCD (Euclid's Algorithm)

**What it does:** Computes the greatest common divisor of `num1` and `num2` using
the remainder form of Euclid's algorithm, as a procedure called from `main`.

**Registers:**
- `a0` — argument `a` in, result out
- `a1` — argument `b` in
- `t0` — scratch, holds `temp = b` before it's overwritten
- `s1` — holds the result in `main` after the call returns

**What was harder than expected:** In `solution.s`, `gcd` is a leaf procedure (it
never calls anything else), so it does **not** save `ra` — the same reasoning as
`find_max` from the Step 2 worked example. It also never touches the stack.

## Stretch — recursive version

`stretch-recursive.s` rewrites `gcd` to call itself instead of looping. This
changes two things:

1. **`ra` must now be saved.** Since `gcd` is no longer a leaf procedure — it
   calls itself — the recursive call would overwrite `ra` with the address to
   return to *inside* `gcd`, destroying the address needed to return to `main`.
   So each invocation pushes its own `ra` onto the stack before recursing, and
   pops it back before returning.
2. **Stack usage is no longer constant.** The looping version uses a fixed,
   tiny amount of stack (in fact none). The recursive version grows the stack by
   4 bytes per call, one frame per recursive step, until the base case is hit —
   so its space usage depends on how many steps Euclid's algorithm takes, not a
   fixed amount.
