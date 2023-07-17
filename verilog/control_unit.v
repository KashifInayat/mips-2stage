module control_unit(
input clk,
input rst,
input [31:0]bt0,
input [4:0]opcode,
output jal,
output lui,
output lli,
output reg ctl1,
output reg ctl2,
output reg ctl3,
output reg ctl4,
output reg ctl5,
output reg ctl7,
output reg ctl8,
output reg ctl9
);
wire lw;
wire lwr;
wire brp;
wire brn;
wire brz;
wire j;
wire bt1;
wire sw;
wire swr;
reg not1;//ctl4
reg not2;//ctl4
reg and1;//ctl4
reg and2;//ctl4
reg and3;//ctl4
reg or1;//ctl4
reg and4;//ctl1
reg and5;//ctl1
reg and6;//ctl1
reg and7;//ctl1
reg and8;//ctl1
reg or4;//ctl1
//lw
assign lw = (opcode == 4);
//lui
assign lui = (opcode == 14);
//lli
assign lli = (opcode == 15);
//lwr
assign lwr = (opcode == 16);
//sw
assign sw = (opcode == 5);
//swr
assign swr = (opcode == 17);
//ctl1
always@(*)
and4 = ~opcode[4] & opcode[3];

always@(*)
and5 = opcode[1] & ~opcode[2];

always@(*)
and6 = ~opcode[1] & opcode[2];

always@(*)
and7 = and4 & and5;

always@(*)
and8 = and4 & and6;

always@(*)
or4 =and7  | and8;


always@(*)
ctl1 = lw | lui | lli | lwr | or4 | ctl8;
//ctl2
always@(*)
ctl2 = lw | lwr;
//ctl3
always@(*)
ctl3= sw | swr;
//ctl4
always@(*)
not1 = ~bt0[31];
assign brp = (opcode == 6);
assign brz = (opcode == 7);
assign brn = (opcode == 8);
assign bt1 = (bt0 == 0);
assign j = (opcode == 9);
assign jal = (opcode == 18);
always@(*)
not2 = ~bt1;
always@(*)
and1 = not1 & brp;
always@(*)
and2 = bt1 & brz;
always@(*)
and3 = not2 & brn;
always@(*)
ctl4 = and1 | and2 | and3 | j | jal;
//ctl5 and anbl for RA
always@(*)
ctl5 = opcode[4] & opcode[1] & opcode[0]; 
//ctl7
always@(*)
ctl7 = lui|lli;
always@(*)
ctl8=~opcode[4] & ~opcode[3] & ~opcode[2];
//ctl9
always@(*)
ctl9 = lwr | swr;

endmodule

