`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:            Iqra 
// Engineer:           Waqar Hussain
// 
// Create Date:        11:55:22 12/14/2010 
// Design Name:    
// Module Name:        ps2_rx 
// Project Name:    
// Target Devices:      Xilinx Nexsys 2 board 
// Tool versions: 
// Description:       This module receives the ps2 data and after removing 
//                     the start, stop and parity bits, it makes available
//                     the 8 bit data in parallel on "key_code" signal. 
//                     Valid data on "key_code" is indicated by a 1 (clk) cycle
//                     high signal on "interrupt"
//                     
//                     INPUTS
//                     --clk      50 MHz clock from Nexsys board. LOC = "B8" in "toplevel.ucf" file
//                     --reset    Resets ps2_rx module on low to high edge. Normally low. LOC= "B18" in "toplevel.ucf" file; 
//                     --ps2d     Serial data pin of ps2 port. LOC= "P11" in "toplevel.ucf" file
//                     --ps2c      Serial clk pin of ps2 port. LOC= "R12" in "toplevel.ucf" file
//
//                     OUTPUTS
//                     --interrupt   Indicates that valid data signal is present on "key_code"
//                     --key_code      Contains the 8 bit data received serially through ps2d pin
//
//                     NOTE   This module or ps2 module dosesnot perform any parity check.
//
// Dependencies:      ps2.v (This module is the main receiving core or ps2 signals 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
/////////////////////////////////////////////////////////////////////////////////

module ps2_rx 
(
   input  wire  clk, reset, 
   input  wire  ps2d,  ps2c, 
   output  wire  interrupt, 
   output wire  [7:0]  key_code 
);


wire [7:0] dout1;
wire rx_done_tick;
reg [7:0] dout;
reg inter;

wire [7:0] dout_nxt;
wire inter_nxt; 





   ps2 ps2_inst1 
								( 
			.clk(clk), 
			.reset(reset), 
			.ps2d(ps2d),
			.ps2c(ps2c),
			.rx_en(1'b1), 
			.rx_done_tick(rx_done_tick), 
			.dout(dout1) 
								);
								
								
								
always @ (posedge clk or posedge reset)
   begin
       if (reset)
       begin
           inter <= 1'b0;
           dout <= 8'b0;
       end
       
       else
       
       begin
           inter <= inter_nxt;
           dout <= dout_nxt;
       end
          
   end   

   
   
   assign dout_nxt = (rx_done_tick==1'b1) ? dout1 : dout;
   assign inter_nxt = rx_done_tick;
   
   
   assign key_code = dout;
   assign interrupt = inter;  

endmodule







