module ALU(
  input clk,
  input rst,
  input [1:0]sel_m1,
  input [31:0] data_1,
  input [31:0] data_2,
  output reg[31:0] data_out
  );
  reg [31:0]Add;
  reg [31:0]Sub;
  reg [31:0]Mult;
  reg [31:0]And;
  reg [31:0]Nand;
  //ADDER
  always@(*)
  begin
    Add=data_1+data_2;
  end
  //SUBTRACTER
  always@(*)
  begin
      Sub=data_1-data_2;
  end
  //MULTIPLIER    
  always@(*)
  begin
    Mult=data_1*data_2;
  end
  //NAND GATE    
  always@(*)
  begin
    And=data_1&data_2;
  end
  always@(*)
  begin
    Nand=~And;
  end
  //MUX
  always@(*)
  begin
  case(sel_m1)
    2'd0: data_out=Add;
    2'd1: data_out=Sub;
    2'd2: data_out=Mult;
    2'd3: data_out=Nand;
  endcase
end
endmodule
