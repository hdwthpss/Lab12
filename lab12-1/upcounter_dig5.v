`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:16:00 08/29/2015 
// Design Name: 
// Module Name:    upcounter_dig5 
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



`define BCD_BIT_WIDTH 4
`define DISABLED 1
`define ENABLED 1
`define BCD_NINE 4
`define BCD_ZERO 4
`define BCD_FIVE 4
`define BCD_THREE 4
`define INCREMENT 4 
`define BCD_TWO 4
`define BCD_ONE 4

module upcounter_dig5(clk,rst_n,load_def,increase,def_value,value,carry
    );
	input clk;
	input rst_n;
	input load_def;
	input increase;
	input [`BCD_BIT_WIDTH-1:0] def_value;
	
	output [`BCD_BIT_WIDTH-1:0] value;
	output carry;
	
	reg [`BCD_BIT_WIDTH-1:0] value;
	reg [`BCD_BIT_WIDTH-1:0] value_tmp;
	reg carry;
	

	always@(*)
		if(increase==`DISABLED'b0 && load_def!=`ENABLED'b1)
			value_tmp=value;
		else if(load_def==`ENABLED'b1)
			value_tmp=def_value;
		else if((increase==`ENABLED'b1) && (value==`BCD_NINE'b1001))
			value_tmp=`BCD_ZERO'b0000;
		else
			value_tmp=value+`INCREMENT'b0001;
			
	always@(*)
		if((increase==`ENABLED'b1) && (value==`BCD_NINE'b1001))
			carry=`ENABLED'b1;
		else
			carry=`DISABLED'b0;
			
	always@(posedge clk or negedge rst_n)
		if(~rst_n)
			value<=def_value;
		else
			value<=value_tmp;
			
			
	

endmodule
