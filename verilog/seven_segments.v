`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:07:06 04/13/2010 
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
module seven_segments(
	input clk,
	input [15:0] word2display,
	output reg [6:0] seven_segment,
	output dp,
	output reg [3:0] an
    );

reg [63:0] count;
wire [6:0] seven_segment0;
wire [6:0] seven_segment1;
wire [6:0] seven_segment2;
wire [6:0] seven_segment3;
	
assign dp = 1;

always@(posedge clk)
	count <= #1 count+1;

segments seg_inst0(word2display[3:0]  ,seven_segment0);
segments seg_inst1(word2display[7:4]  ,seven_segment1);
segments seg_inst2(word2display[11:8] ,seven_segment2);
segments seg_inst3(word2display[15:12],seven_segment3);

always@(posedge clk)
begin
	case(count[12:11])
	2'd0: begin seven_segment = ~seven_segment0; an = 4'b1110;end
	2'd1: begin seven_segment = ~seven_segment1; an = 4'b1101;end
	2'd2: begin seven_segment = ~seven_segment2; an = 4'b1011;end
	2'd3: begin seven_segment = ~seven_segment3; an = 4'b0111;end
	endcase
end
	
endmodule
