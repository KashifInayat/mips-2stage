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
input clr,
input [6:0]hc_addr,
input [6:0]vc_addr,
output  [12:0] blk_addr
    );
/////////counter////////

assign blk_addr =(clr) ? 0: ((80*vc_addr) + (hc_addr));
endmodule

