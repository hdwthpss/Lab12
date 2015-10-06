`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:35:22 09/02/2015 
// Design Name: 
// Module Name:    state_start_pause 
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
module state_start_pause(button,button_out,clk,rst_n
    );
	input button;
	input clk,rst_n;
	output button_out;
	reg button_out;
	reg temp;
	
	always@(*)
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
