`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:57:20 09/02/2015 
// Design Name: 
// Module Name:    state_lap 
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
module state_lap(button,button_out,clk,rst_n,state_start,switch_set
    );
	input button;
	input state_start;
	input clk,rst_n;
	input switch_set;
	output button_out;
	reg button_out;
	reg temp;
	
	always@(*)
	if(switch_set==1'b1)
		if(button==1'b1 && state_start==1'b1)
			case(button_out)
				1'b0 :
						temp=1'b1;
				1'b1 :
						temp=1'b0;

			endcase
		else
			temp=button_out;
	else
		if(button==1'b1)
			case(button_out)
				1'b0 :
						temp=1'b1;
				1'b1 :
						temp=1'b0;

			endcase
		else
			temp=button_out;
	
	always@(posedge clk or negedge rst_n)
		if(~rst_n)
			button_out<=1'b0;
		else
			button_out<=temp;

endmodule
