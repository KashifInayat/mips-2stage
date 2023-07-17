`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:46:51 05/14/2012 
// Design Name: 
// Module Name:    vga_640x480 
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
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:52:49 12/22/2010 
// Design Name: 
// Module Name:    vga_640x480 
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
module vga_640x480(
input wire clk,
input wire clr,
output reg hsync,
output reg vsync,
output reg [9:0] hc_ad,
output reg [9:0] vc_ad,
output reg [9:0] hc,
output reg [9:0] vc,
output reg vidon
);
parameter hpixels = 10'b1100100000;
//Value of Pixels in Horizontal Line=800
parameter vlines  = 10'b1000001001;
//Number of Horizontal lines in the display =512
parameter hbp     = 10'b0010010000;
//Horizontal Back Porch=144(128+16)
parameter hfp     = 10'b1100010000;
//Horizontal Front Porch=784(128+16+640)
parameter vbp     = 10'b0000011111;
//Vertical Back Porch=31(2+29)
parameter vfp     = 10'b0111111111;
//Vertical Front Porch=511(2+29+480)
reg vsenable;//Enable for the Vertical counter


always @ (posedge clk or posedge clr)
   begin 
   if(clr==1)
   hc<=0;
   else
     begin
       if(hc==hpixels-1)
         begin
           //The counter has reached the end of pixel count
            hc <= 0;                  //reset the counter
            
            vsenable <= 1;
            //Enable the Vertical counter to increment
         end
       else 
         begin
            hc <= hc+1;//Increment the Horizontal counter
            vsenable <= 0;// Leave the Vsenable off
         end
     end
  end
// Generate hsync pulse
// Horizontal sync pulse is low when hc is  0 - 27
always @ (*)
   begin
    if(hc < 128)
         hsync =0;
    else
         hsync=1;
   end
 //Counter for the Vertical Sync Signal  
always @ (posedge clk or posedge clr)
   begin
    if(clr == 1)
         vc<=0;
    else
        if(vsenable == 1)
           begin
              if(vc==vlines-1)
                // Reset when number of lines is reached
                   vc <=0;
              else
                   vc <= vc+1;//Increment the Vertical counter
           end
   end
// Generate vsync pulse
// Verticall sync pulse is low when hc is  0 or 1
always @ (*)
   begin
      if( vc < 2)
            vsync=0;
      else
            vsync=1;
   end
   		////////////// Horizontal counter///////////////
	always@(posedge clk or posedge clr)
	  begin 
	     if(clr==1)
	        hc_ad <= 0;
		  else if  (hc_ad==639)
		     hc_ad <= 0;
	     else if(((hc>143)&&(vc>30))&&((hc<784)&&(vc<511)))
	        hc_ad <= hc_ad + 1 ;
	     else
	        hc_ad <= hc_ad;
	  end
	  //////////////vertical counter////////////
	always@(posedge clk or posedge clr)
	  begin 
	     if(clr==1)
	        vc_ad <= 0;
		  else if(vc_ad==479)
           vc_ad <= 0;			
	     else if (vsenable == 1)
	       begin
	          if((vc > 30)&&(vc < 510))
	             vc_ad <= vc_ad + 1 ;
	          else 
	             vc_ad <= vc_ad;
	       end
	  end

   
//Enable Vide Out when within the Porches   
always@(*)
   begin
      if((hc<hfp)&&(hc>hbp)&&(vc<vfp)&&(vc>vbp))
          vidon=1;
      else
          vidon=0;
   end
endmodule
