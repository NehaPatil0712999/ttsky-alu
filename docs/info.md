<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

# 4-Bit ALU using Tiny Tapeout

## How it works

This project implements a simple 4-bit Arithmetic Logic Unit (ALU) using Verilog HDL.

The ALU performs four basic operations based on the select lines `ui_in[7:6]`.

### Inputs

- `ui_in[3:0]`  → Operand A
- `uio_in[3:0]` → Operand B
- `ui_in[7:6]`  → Operation Select

### Operations

| Select (`ui_in[7:6]`) | Operation |
|-----------------------|-----------|
| 00 | Addition (`A + B`) |
| 01 | Subtraction (`A - B`) |
| 10 | Bitwise AND (`A & B`) |
| 11 | Bitwise OR (`A | B`) |

The result is available on:

- `uo_out[7:0]`

The ALU is purely combinational and produces output immediately based on the inputs.

---

## How to test

### Test 1: Addition

- Set:
  - `ui_in[7:6] = 00`
  - `ui_in[3:0] = 0101` (5)
  - `uio_in[3:0] = 0011` (3)

- Expected Output:
  - `uo_out = 00001000` (8)

---

### Test 2: Subtraction

- Set:
  - `ui_in[7:6] = 01`
  - `ui_in[3:0] = 1001` (9)
  - `uio_in[3:0] = 0100` (4)

- Expected Output:
  - `uo_out = 00000101` (5)

---

### Test 3: AND Operation

- Set:
  - `ui_in[7:6] = 10`
  - `ui_in[3:0] = 1100`
  - `uio_in[3:0] = 1010`

- Expected Output:
  - `uo_out = 00001000`

---

### Test 4: OR Operation

- Set:
  - `ui_in[7:6] = 11`
  - `ui_in[3:0] = 1100`
  - `uio_in[3:0] = 1010`

- Expected Output:
  - `uo_out = 00001110`

---

## External hardware

No external hardware is required.

The project only uses the Tiny Tapeout standard input/output pins.
