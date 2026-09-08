# Array Maximum - C++ Model and RISC-V Assembly

Worked example for CS3520 Lab 2. It shows the same algorithm expressed twice:
once as a tested C++ model, and once as a hand-written RISC-V translation.

## Files

- `model.cpp` - the C++ model, written and tested first
- `array-max.s` - the RISC-V assembly translation

## Run

Compile and run the C++ model:

```bash
g++ -Wall -std=c++17 model.cpp -o model
./model
```

Then open `array-max.s` in Ripes or RARS, assemble it, and run it. Both should
print:

```text
Maximum: 93
```

## What the example demonstrates

- storing an array and a string in the `.data` section
- indexing an array with `slli` and `add` to form a byte offset
- a counted loop built from `bge` and an unconditional `beq x0, x0`
- a conditional branch (`ble`) guarding an update
- a procedure called with `jal` and returned from with `jalr`
- correct use of the stack to preserve a callee-saved register (`s1`)

## Discussion points

- `find_max` is a **leaf** procedure - it calls nothing - so it does not need to
  save `ra`. It does save `s1`, because `s1` is callee-saved.
- `li`, `mv`, `la` and `ble` are **pseudo-instructions**. Assemble the file and
  compare the source with the machine code the simulator generates: each one
  expands into a real instruction. Which real instructions are they?
- The loop exit test is inverted relative to the C++ (`bge` where the source
  says `i < n`). Why must it be?
