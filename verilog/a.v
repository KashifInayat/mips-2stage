`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:50:03 12/28/2012 
// Design Name: 
// Module Name:    counter 
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
module counter(
input clk,clr,
input [9:0]hc_addr,
input [9:0]vc_addr,
output [10:0] blk_addr
    );
	 
vga_640x480 inst_vga(

input wire clk,
input wire clr,
output reg hsync,
output reg vsync,
output reg [9:0] hc,
//output reg [9:0] hc_ad,
//output reg [9:0] vc_ad,
output reg[18:0] b_add,
output reg [9:0] vc,
output reg vidon
    );
	 
	 
/////////counter////////
assign blk_addr =(clr) ? 0: (80*vc_addr[9:3]) + (hc_addr[9:3]);
/*
always @( posedge clk or clr)
    begin
       if (clr == 1)
          blk_addr = 0;
       else
          blk_addr = (80g*vc_addr[9:3]) + hc_addr[9:3];
    end
endmodule
*/