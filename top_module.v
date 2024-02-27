`timescale 1ns / 1ps
`include "hockey.v"
`include "ssd.v"
`include "clk_divider.v"
// Include any other necessary modules or libraries

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 01/05/2023 05:35:09 PM
// Design Name:
// Module Name: top_module
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module top_module(
    input clk,
    input rst,
    
    input BTNA,
    input BTNB,
    
    input [1:0] DIRA,
    input [1:0] DIRB,
    
    input [2:0] YA,
    input [2:0] YB,
   
    output LEDA,
    output LEDB,
    output [4:0] LEDX,
    
    output a_out, b_out, c_out, d_out, e_out, f_out, g_out, p_out,
    output [7:0] an
);
wire [6:0] SSD7_top;
wire [6:0] SSD6_top;
wire [6:0] SSD5_top;
wire [6:0] SSD4_top;
wire [6:0] SSD3_top;
wire [6:0] SSD2_top;
wire [6:0] SSD1_top;
wire [6:0] SSD0_top;
wire [2:0] X_COORD_top;
wire [2:0] Y_COORD_top;
wire LD0_top;
wire LD5_top;
wire LD6_top;
wire LD7_top;
wire LD8_top;
wire LD9_top;
wire LD15_top;
wire divided_clk;

wire clean_A;
wire clean_B;


// Instantiate the hockey module
hockey hockey_instance (
    .clk(divided_clk),
    .rst(rst),
    .BTN_A(clean_A),
    .BTN_B(clean_B),
    .DIR_A(DIRA),
    .DIR_B(DIRB),
    .Y_in_A(YA),
    .Y_in_B(YB),
    .SSD7(SSD7_top),
    .SSD6(SSD6_top),
    .SSD5(SSD5_top),
    .SSD4(SSD4_top),
    .SSD3(SSD3_top),
    .SSD2(SSD2_top),
    .SSD1(SSD1_top),
    .SSD0(SSD0_top),
    .X_COORD(X_COORD_top),
    .Y_COORD(Y_COORD_top),
    .LD0(LD0_top),
    .LD5(LD5_top),
    .LD6(LD6_top),
    .LD7(LD7_top),
    .LD8(LD8_top),
    .LD9(LD9_top),
    .LD15(LD15_top)
);

// Instantiate clock divider
clk_divider cdiv0(
    .clk_in(clk),
    .rst(rst),
    .divided_clk(divided_clk)
);

// Instantiate debouncers
debouncer db1(
    .clk(clk),
    .rst(rst),
    .noisy_in(BTNA), // Corrected the port names
    .clean_out(clean_A) // Corrected the port names
);

debouncer db2(
    .clk(clk),
    .rst(rst),
    .noisy_in(BTNB), // Corrected the port names
    .clean_out(clean_B) // Corrected the port names
);

// Instantiate SSD module
ssd ssd1(
    .clk(clk),
    .rst(rst),
    .SSD7(SSD7_top),
    .SSD6(SSD6_top),
    .SSD5(SSD5_top),
    .SSD4(SSD4_top),
    .SSD3(SSD3_top),
    .SSD2(SSD2_top),
    .SSD1(SSD1_top),
    .SSD0(SSD0_top),
    .a_out(a_out),
    .b_out(b_out),
    .c_out(c_out),
    .d_out(d_out),
    .e_out(e_out),
    .f_out(f_out),
    .g_out(g_out),
    .p_out(p_out),
    .an(an)
);

endmodule
