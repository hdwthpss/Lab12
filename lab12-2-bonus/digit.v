`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:49:19 09/02/2015 
// Design Name: 
// Module Name:    digit 
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
module digit(clk,rst_n,value_0,value_1,value_2,value_3,value_4,value_5,start_set_hour,lap_set_min,switch,switch_count
    );
	input clk,rst_n;
	input start_set_hour,lap_set_min;
	input switch;
	input switch_count;
	
	output [3:0] value_0,value_1,value_2,value_3,value_4,value_5;
	
	reg load_def_hour;
	reg load_def_min;
	reg switch_up_down;
	reg switch_count_down;
	
	reg temp;////
	
	
	reg count_hour,count_min;
	
	wire cout_0,cout_1,cout_2,cout_3,cout_4,cout_5;
	wire de_cout_4,de_cout_5,de_cout_0,de_cout_1,de_cout_2;
	
	always@(*)
		if(start_set_hour==1'b1)
			count_hour=1'b1;
		else
			count_hour=1'b0;
	
	always@(*)
		if(lap_set_min==1'b1)
			count_min=1'b1;
		else
			count_min=1'b0;
	
	
	always@(*)
	if(start_set_hour==1'b1)//////////////////////////////////////////////
		if(value_3==4'b0010 && value_2==4'b0011)
			load_def_hour=1'b1;
		else
			load_def_hour=1'b0;
		
	always@(*)
		if(switch==1'b0)
			switch_up_down=1'b0;
		else
			switch_up_down=1'b1;
			
	always@(*)
		if(switch_count==1'b0)
			switch_count_down=1'b0;
		else
			switch_count_down=1'b1;
	
	
	always@(*)
		if(switch_count==1'b0)
			temp=count_min;
		else
			temp=cout_5;
	
	
	upcounter_dig0 d0(
	.value(value_0),
	.increase(temp),
	.clk(clk),
	.rst_n(rst_n),
	.carry(cout_0),
	.switch_up_down(switch_up_down),
	.decrease(de_cout_5),
	.de_carry(de_cout_0),
	.def_value(4'b0000),
	.load_def(load_def_min)
	);
	
	upcounter_dig1 d1(
	.value(value_1),
	.increase(cout_0),
	.clk(clk),
	.rst_n(rst_n),
	.carry(cout_1),
	.switch_up_down(switch_up_down),
	.decrease(de_cout_0),
	.de_carry(de_cout_1),
	.def_value(4'b0000),
	.load_def(load_def_min)
	);
	
	upcounter_dig2 d2(
	.value(value_2),
	.increase(count_hour),
	.clk(clk),
	.rst_n(rst_n),
	.carry(cout_2),
	.switch_up_down(switch_up_down),
	.decrease(de_cout_1),
	.de_carry(de_cout_2),
	.def_value(4'b0000),
	.load_def(load_def_hour),
	.switch_count(switch_count_down)
	);
	
	upcounter_dig3 d3(
	.value(value_3),
	.increase(cout_2),
	.clk(clk),
	.rst_n(rst_n),
	.carry(cout_3),
	.switch_up_down(switch_up_down),
	.decrease(de_cout_2),
	.de_carry(de_cout_3),
	.def_value(4'b0000),
	.load_def(load_def_hour),
	.switch_count(switch_count_down)
	);
	
	
	upcounter_dig4 d4(
	.value(value_4),
	.decrease(count_hour),
	.clk(clk),
	.rst_n(rst_n),
	.switch_up_down(switch_up_down),
	.de_carry(de_cout_4),
	.def_value(4'b0000),
	.load_def(load_def),
	.switch_count(switch_count_down),
	.increase(count_hour),
	.carry(cout_4)
	);
	
	upcounter_dig5 d5(
	.value(value_5),
	.decrease(de_cout_4),
	.clk(clk),
	.rst_n(rst_n),
	.switch_up_down(switch_up_down),
	.de_carry(de_cout_5),
	.def_value(4'b0000),
	.load_def(load_def),
	.switch_count(switch_count_down),
	.increase(cout_4),
	.carry(cout_5)
	);

endmodule
