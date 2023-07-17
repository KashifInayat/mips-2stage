
module reg_file(
		input 			clk,
		input 	[4:0]	rd_addr1,
		input	[4:0]	rd_addr2,
		input wr_en,
		input	[4:0]	wr_addr,
		input			wr_en_upr,
		input wr_en_lwr,
		input	[15:0]	wr_data1,
    input	[15:0]	wr_data2,
  		input [9:0]count_out,
  		input jal,
  		output [31:0]bt,
		output	 [31:0]	rd_data1,
		output	 [31:0]	rd_data2,
		output  [31:0]for_display,
		output  [31:0]for_display1

);


reg [15:0] regs1[0:31];
reg [15:0] regs2[0:31];
reg and1;//for upr
reg and2;//for lwr
//upr write enbl
always@(*)
and1= wr_en & ~wr_en_lwr;
//lwr write enbl
always@(*)
and2= wr_en & ~wr_en_upr;
//lower 16 bits
always@(posedge clk)
begin
	
	if(and2)	regs1[wr_addr] <= #1 wr_data1;
  if (jal)
    regs1[1] <=#1 {6'd0,count_out};
end
//	upper 16 bits
always@(posedge clk)
begin
	if(and1)	regs2[wr_addr] <= #1 wr_data2;
	  if (jal)
    regs2[1] <= #1 0;
end	
//data read
assign	rd_data1 = {regs2[rd_addr1],regs1[rd_addr1]};
assign 	rd_data2 ={regs2[rd_addr2],regs1[rd_addr2]};
assign bt={regs2[0],regs1[0]};
assign for_display={regs2[7],regs1[7]};
assign for_display1={regs2[9],regs1[9]};
endmodule
