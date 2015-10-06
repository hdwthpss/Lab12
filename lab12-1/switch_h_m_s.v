`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:25:42 08/29/2015 
// Design Name: 
// Module Name:    switch_h_m_s 
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
module switch_h_m_s(switch,sec0,sec1,sec2,sec3,sec4,sec5,in0,in1,in2,in3,switch_mode
    );
	input switch;
	input switch_mode;
	input [3:0] sec0,sec1,sec2,sec3,sec4,sec5;
	//input [3:0] sec0_mode,sec1_mode,sec2_mode,sec3_mode,sec4_mode,sec5_mode;
	output reg [3:0] in0,in1,in2,in3;
	
	always@(*)
		case(switch)
			1'b0 :
				begin
					in0=sec0;
					in1=sec1;
					in2=sec2;
					in3=sec3;
				end
			1'b1 :
				if(switch_mode==1'b0)
					begin
						in0=sec4;
						in1=sec5;
						in2=4'b0000;
						in3=4'b0000;
					end
				else
					if(sec4<=4'b1001 && sec4>=4'b0011 && sec5==4'b0001)
						begin
							in0=sec4-4'b0010;
							in1=4'b0000;
							in2=4'b1110;
							in3=4'b1101;
						end
					else if(sec5==4'b0010 && sec4<=4'b0001)
						begin
							in0=sec4+4'b1000;
							in1=4'b0000;
							in2=4'b1110;
							in3=4'b1101;
						end
					else if(sec5==4'b0010 && sec4>=4'b0010)
						begin
							in0=sec4-4'b0010;
							in1=4'b0001;
							in2=4'b1110;
							in3=4'b1101;
						end
					else
						begin
							in0=sec4;
							in1=sec5;
							in2=4'b1110;
							in3=4'b1111;
						end
					
		endcase

endmodule
