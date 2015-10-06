`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:34:38 08/21/2015 
// Design Name: 
// Module Name:    scan 
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
module scan(freq_ctl,in0,in1,in2,in3,wh_light,light_num
    );
	input [1:0] freq_ctl;
	
	input [4:0] in0,in1,in2,in3;
	output [3:0] wh_light;
	output [4:0] light_num;
	

	reg [3:0] wh_light;
	reg [4:0] light_num;

	always@(freq_ctl)
		case(freq_ctl)
			2'b00 :
				begin
					wh_light=4'b1110;
					light_num=in0;
				end
			2'b01 :
				begin
					wh_light=4'b1101;
					light_num=in1;
				end
			2'b10 :
				begin
					wh_light=4'b1011;
					light_num=in2;
				end
			2'b11 :
				begin
					wh_light=4'b0111;
					light_num=in3;
				end
		endcase
	
endmodule


