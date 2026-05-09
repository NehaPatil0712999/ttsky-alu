/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output reg  [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path
    input  wire       ena,      // always 1 when powered
    input  wire       clk,      // clock
    input  wire       rst_n     // active low reset
);

    // ALU Operation Select
    // ui_in[7:6] = select operation
    //
    // 00 -> Addition
    // 01 -> Subtraction
    // 10 -> AND
    // 11 -> OR
    //
    // ui_in[3:0]  = Operand A
    // uio_in[3:0] = Operand B

    wire [3:0] A;
    wire [3:0] B;
    wire [1:0] sel;

    assign A   = ui_in[3:0];
    assign B   = uio_in[3:0];
    assign sel = ui_in[7:6];

    always @(*) begin
        case (sel)
            2'b00: uo_out = A + B;   // Addition
            2'b01: uo_out = A - B;   // Subtraction
            2'b10: uo_out = A & B;   // AND
            2'b11: uo_out = A | B;   // OR
            default: uo_out = 8'b0;
        endcase
    end

    // Unused IOs
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    // Prevent unused signal warnings
    wire _unused = &{ena, clk, rst_n, ui_in[5:4], uio_in[7:4], 1'b0};

endmodule

`default_nettype wire
