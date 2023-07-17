module pc(
  input clk,
  input rst,
  input sel_m1,
  input sel_m2,
  input [9:0] inst_pm,
  input [9:0] reg_out,
  output reg [9:0] count
  );
  reg [9:0] mux_out1;
  reg [9:0] mux_out2;
  //mux1
  always@(*)
  begin
    case(sel_m1)
      1'b0: mux_out1=count+1;
      1'b1: mux_out1=count+inst_pm[9:0];
    endcase
  end
  //mux2
  always@(*)
  begin
    case(sel_m2)
      1'b0: mux_out2=mux_out1;
      1'b1: mux_out2=reg_out[9:0];
    endcase
  end
//counter
always@(posedge clk)
begin
  if(rst)
    count <=#1 0;
  else
   count <=#1 mux_out2;
end
endmodule