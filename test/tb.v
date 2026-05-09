`default_nettype none
`timescale 1ns / 1ps

module tb ();

  // Dump waveform
  initial begin
    $dumpfile("tb.fst");
    $dumpvars(0, tb);
    #1;
  end

  // Inputs
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;

  // Outputs
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // Instantiate DUT
  tt_um_example user_project (

`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif

      .ui_in   (ui_in),
      .uo_out  (uo_out),
      .uio_in  (uio_in),
      .uio_out (uio_out),
      .uio_oe  (uio_oe),
      .ena     (ena),
      .clk     (clk),
      .rst_n   (rst_n)
  );

  // Clock Generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Test Procedure
  initial begin

    // Initialize Inputs
    ena    = 1'b1;
    rst_n  = 1'b0;
    ui_in  = 8'b0;
    uio_in = 8'b0;

    // Apply Reset
    #10;
    rst_n = 1'b1;

    // -----------------------------------
    // Test 1 : Addition
    // sel = 00
    // A = 5, B = 3
    // Result = 8
    // -----------------------------------
    ui_in  = 8'b00000101; // sel=00, A=0101
    uio_in = 8'b00000011; // B=0011
    #10;

    // -----------------------------------
    // Test 2 : Subtraction
    // sel = 01
    // A = 9, B = 4
    // Result = 5
    // -----------------------------------
    ui_in  = 8'b01001001; // sel=01, A=1001
    uio_in = 8'b00000100; // B=0100
    #10;

    // -----------------------------------
    // Test 3 : AND
    // sel = 10
    // A = 12, B = 10
    // Result = 8
    // -----------------------------------
    ui_in  = 8'b10001100; // sel=10, A=1100
    uio_in = 8'b00001010; // B=1010
    #10;

    // -----------------------------------
    // Test 4 : OR
    // sel = 11
    // A = 12, B = 10
    // Result = 14
    // -----------------------------------
    ui_in  = 8'b11001100; // sel=11, A=1100
    uio_in = 8'b00001010; // B=1010
    #10;

    // Finish Simulation
    #20;
    $finish;
  end

endmodule

`default_nettype wire
