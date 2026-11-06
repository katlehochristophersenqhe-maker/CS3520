# Lab 3 — Datapath Notes

## Step 4 — Answers to the four questions

1. **lui vs auipc**  
   Both use the U-type format and the same immediate. The difference is the ALU operand-1 multiplexer: `lui` forces a zero, while `auipc` selects the current PC. That single select bit produces the two different results.

2. **sw never writes a register**  
   The single control signal is MemWrite (`data_mem.wr_en = 1`). The write-back multiplexer is unused / don’t-care for stores; RegWrite is de-asserted.

3. **beq vs bne**  
   Both compare the same two registers in the Branch unit. The equality (or inverted equality) result travels through the control-flow OR gate to the PC-source multiplexer select. Only the select value differs.

4. **jal / jalr return address**  
   Supplied by the third input of the write-back multiplexer (PC+4). Neither the ALU result nor the data-memory output can produce the sequential next-PC value required for the link register.

## Step 6 — Implementation vs Textbook Diagram

Three substantive differences and the engineering gain of each:

| # | What the Week 6 figure shows                                      | What the implementation does & the gain                                                                 |
|---|-------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------|
| A | Dedicated branch adder, separate from the ALU, computing PC + offset | No second adder. Branch target is computed by the main ALU; a multiplexer selects the result. Hardware saving (one fewer adder) at the cost of a slightly longer critical path when a branch is taken. |
| B | beq tested by the ALU’s Zero flag after a subtraction             | Separate comparison / Branch unit. It can test equality, inequality and the signed/unsigned relations that a simple Zero flag cannot express, and it frees the ALU for other work on the same cycle. |
| C | Two-input MemtoReg multiplexer                                    | Three-input write-back multiplexer (ALU result / memory data / PC+4). The third input is required by `jal` and `jalr` so that the return address can be written without an extra adder in the write-back path. |

**Trade-off note (fetch datapath)**  
Week 6 asked why a dedicated adder is used for PC+4 / branch target instead of the ALU. This implementation answers the opposite question—it re-uses the ALU. Both designs work. Prefer a dedicated adder when clock frequency is the primary goal (shorter critical path); prefer ALU reuse when silicon area or power is the constraint.