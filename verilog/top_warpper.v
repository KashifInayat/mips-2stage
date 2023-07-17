`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:15:46 12/31/2012 
// Design Name: 
// Module Name:    top_warpper 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top_warpper(
input wire clk,
input wire clr,
output  hsync,
output  vsync,
input  wire  ps2d,  ps2c,
output [7:0] vga_clr,
output [6:0] seven_segment,
output dp,
output  [3:0] an

    );
	 
	 wire [9:0]count;
wire [9:0] hc;
wire [9:0] vc;
wire vidon ;
wire [9:0] hc_ad;
wire [9:0] vc_ad;
wire [12:0] blk_addr;
wire [7:0] key_code1;
wire interrupt1;
wire [31:0]for_display1;
wire [31:0]for_display;
////////////////////// Processor ///////////////	 
main inst_processor(
.clk(clk),
.rst (clr),
.interrupt1(interrupt1),
.key_code1(key_code1),
.count_out(count),
.for_display(for_display),
.for_display1(for_display1)
);
//////seven segment////////
seven_segments inst_7
(
	.clk(clk),
	.word2display({7'd0,key_code1}),
	.seven_segment(seven_segment),
	.dp(dp),
	.an(an)
    );
ps2_rx inst_keyboard 
(
   .clk (clk),
   .reset (clr), 
   .ps2d (ps2d),
   .ps2c (ps2c), 
   .interrupt(interrupt1), 
   .key_code (key_code1) 
);
	 
vga_640x480 inst_vga(
.clk (clk),
.clr (clr),
.hsync (hsync),
.vsync (vsync),
.hc_ad (hc_ad),
.vc_ad (vc_ad),
.hc (hc),
.vc (vc),
.vidon (vidon)
);
	 
	counter inst_counter(
.clr (clr),
.hc_addr (hc_ad[9:3]),
.vc_addr (vc_ad[9:3]),
.blk_addr (blk_addr)
    );

logic_game inst_logic_game(
. clk (clk),
. reset (clr),
.vidon(vidon),
.b_add2(for_display[12:0]),
. b_add (blk_addr),
. vga_clr (vga_clr)
    );

endmodule
