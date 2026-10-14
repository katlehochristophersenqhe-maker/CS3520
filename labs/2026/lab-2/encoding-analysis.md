# Step 5 — Analysing the New Instruction Formats

Two instructions chosen from the exercises above: the branch `blt t1, t2,
end_loop` from **Ex2 (sum-to-n)**, and the jump `jal ra, factorial` from
**Ex4 (factorial)**.

Addresses are computed assuming `.text` starts at address `0x00000000`, with
each instruction occupying 4 bytes (`la` expands to two real instructions:
`auipc` + `addi`; `li` with a small immediate expands to a single `addi`).
The exact base address will differ once actually assembled in Ripes, but since
both branch and jump offsets are PC-relative, the encoded immediate is the same
regardless of where `.text` is actually loaded.

## 1. The branch — `blt t1, t2, end_loop`

Ex2's `bgt t2, t1, end_loop` is a pseudo-instruction that the assembler expands
to the real instruction `blt t1, t2, end_loop` (operands swapped, using the one
real "less-than" branch RISC-V actually provides).

- Address of the branch instruction: `0x14`
- Address of `end_loop`: `0x24`
- Offset = `0x24 - 0x14` = `0x10` = **16**

**32-bit encoding: `0x00734863`**

```
0000000 00111 00110 100 1000 0 1100011
imm[12] imm[10:5] rs2   rs1   f3  imm[4:1] imm[11] opcode
```

| Field | Bits | Value | Meaning |
|---|---|---|---|
| opcode | [6:0] | `1100011` (0x63) | BRANCH major opcode |
| funct3 | [14:12] | `100` | selects `blt` |
| rs1 | [19:15] | `00110` (6) | `t1` |
| rs2 | [24:20] | `00111` (7) | `t2` |
| imm[11] | [7] | `0` | |
| imm[4:1] | [11:8] | `1000` | |
| imm[10:5] | [30:25] | `000000` | |
| imm[12] | [31] | `0` | |

Reassembling the immediate bits (`imm[12] imm[11] imm[10:5] imm[4:1] 0`) gives
`0 0 000000 1000 0` = **16**, matching the offset above. This is **B-type**.

## 2. The jump — `jal ra, factorial`

- Address of the `jal` instruction: `0x0C`
- Address of `factorial`: `0x28`
- Offset = `0x28 - 0x0C` = `0x1C` = **28**

**32-bit encoding: `0x01C000EF`**

```
0 0000000 0 0000001110 00001 1101111
imm[20] imm[19:12] imm[11] imm[10:1] rd  opcode
```

| Field | Bits | Value | Meaning |
|---|---|---|---|
| opcode | [6:0] | `1101111` (0x6F) | JAL |
| rd | [11:7] | `00001` (1) | `ra` — where the return address is stored |
| imm[19:12] | [19:12] | `00000000` | |
| imm[11] | [20] | `0` | |
| imm[10:1] | [30:21] | `0000001110` | |
| imm[20] | [31] | `0` | |

Reassembling (`imm[20] imm[19:12] imm[11] imm[10:1] 0`) gives **28**, matching
the offset above. This is **J-type**.

## Why is the immediate stored in scattered pieces rather than one contiguous field?

Every RISC-V instruction format keeps the fields that the *decoder* needs first
— `opcode`, then (where present) `rd`, `funct3`, `rs1`, `rs2` — at the exact
same bit positions across R-, I-, S-, B- and J-type instructions. The decode
logic can therefore always read bits `[19:15]` as `rs1` and bits `[11:7]` as
`rd`/part of the immediate without first knowing which format it's looking at.

Once those fixed positions are reserved, whatever bit positions are left over
are handed to the immediate — and they aren't contiguous, because the
register/opcode fields sit in the middle of the word. The assembler (and the
decoder) simply has to reassemble the scattered immediate bits into the right
order. B-type and J-type additionally reorder the immediate bits *within* the
leftover space (LSB-of-immediate is never stored in bit 0, since branch/jump
targets are always even, so that low bit is reused, and the bits are arranged
so the sign bit is always in bit 31 for cheap sign-extension). The trade-off is
exactly this: cheap, uniform, format-independent field extraction in hardware,
at the cost of the immediate being awkward for a human (or assembler) to read
directly out of the binary.
