# Lab 3 — Trace Tables

## Step 3 — Trace One Instruction Completely

**Instruction:** `add t2, t0, t1` (PC = 0x00000008, t0 = 12, t1 = 5)

| Element          | Port                  | Value                          |
|------------------|-----------------------|--------------------------------|
| pc_reg           | out                   | 0x00000008                     |
| pc_4             | out                   | 0x0000000C                     |
| instr_mem        | data_out              | 0x006283B3                     |
| decode           | r1_reg_idx / r2_reg_idx | 5 / 6                        |
| decode           | wr_reg_idx            | 7                              |
| control          | reg_do_write_ctrl     | 1                              |
| control          | alu_op2_ctrl          | 0 (register, not immediate)    |
| registerFile     | r1_out / r2_out       | 12 / 5                         |
| alu_op1_src      | out                   | 12                             |
| alu_op2_src      | out                   | 5                              |
| alu              | res                   | 17                             |
| data_mem         | wr_en                 | 0                              |
| reg_wr_src       | select / out          | 0 / 17 (ALU result)            |
| pc_src           | select / out          | 0 / 0x0000000C (PC+4)          |

## Step 4 — Trace Every Instruction Class

| Instruction          | Format | Imm     | op1 mux     | op2 mux | alu.res       | wb mux / pc mux          |
|----------------------|--------|---------|-------------|---------|---------------|--------------------------|
| addi t0, zero, 12    | I      | 12      | reg (0)     | imm (1) | 12            | ALU / PC+4               |
| add t2, t0, t1       | R      | —       | reg (0)     | reg (0) | 17            | ALU / PC+4               |
| lui t4, 0x2B         | U      | 0x2B000 | 0 (lui)     | imm     | 0x2B000       | ALU / PC+4               |
| auipc t5, 0x0        | U      | 0       | PC          | imm     | 0x14 (20)     | ALU / PC+4               |
| lw a1, 0(a0)         | I      | 0       | reg         | imm     | addr          | Mem / PC+4               |
| sw t2, 4(a0)         | S      | 4       | reg         | imm     | 0x10000004    | — (no WB) / PC+4         |
| beq t0, t1, skip     | B      | offset  | reg         | reg     | cmp           | — / PC+4 (not taken)     |
| bne t0, t1, target   | B      | offset  | reg         | reg     | cmp           | — / target (taken)       |
| jal ra, report       | J      | offset  | —           | —       | —             | PC+4 / target            |
| jalr zero, ra, 0     | I      | 0       | reg (ra)    | imm     | target        | PC+4 / ALU               |