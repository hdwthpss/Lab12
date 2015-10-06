`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:29:38 09/03/2015 
// Design Name: 
// Module Name:    stopwatch_control 
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
module stopwatch_control(clk,rst_n,start_set_hour,lap_set_min,display,wh_light,switch,switch_view,switch_count,real_0,real_1,real_2,real_3
    );
	input clk,rst_n;
	
	input start_set_hour;
	input lap_set_min;
	
	input switch;
	input switch_view;
	input switch_count;
	
	output [14:0] display;
	output [3:0] wh_light;
	
	wire [3:0] value_0,value_1,value_2,value_3,value_4,value_5;
	output [3:0] real_0,real_1,real_2,real_3;
	wire [3:0] lap_0,lap_1,lap_2,lap_3,lap_4,lap_5;
	wire [4:0] in0,in1,in2,in3;
	wire [3:0] bcd;
	wire clk_out;
	wire [1:0] clk_ctl;
	wire [6:0] cnt_h;
	
	wire debounce_start_out;
	wire debounce_lap_out;
	
	wire one_pulse_start_out;
	wire one_pulse_lap_out;
	
	wire state_lap_out;
	wire state_start_out;
	
	/*wire rst_q;
	
	rst r(
	.d(debounce_lap_out),
	.clk(clk_out),
	.rst_n(rst_n),
	.rst_q(rst_q)
	);*/
	
	lap_function l(
	.value_0(value_0),
	.value_1(value_1),
	.value_2(value_2),
	.value_3(value_3),
	.value_4(value_4),
	.value_5(value_5),
	.lap_0(lap_0),
	.lap_1(lap_1),
	.lap_2(lap_2),
	.lap_3(lap_3),
	.lap_4(lap_4),
	.lap_5(lap_5),
	.switch_set(switch),
	.clk(clk),
	.rst_n(rst_n),
	.one_pulse_state_lap(one_pulse_lap_out),
	.state_start(state_start_out)
	);
	
	state_value stv(
	.value_0(value_0),
	.value_1(value_1),
	.value_2(value_2),
	.value_3(value_3),
	.value_4(value_4),
	.value_5(value_5),
	.real_0(real_0),
	.real_1(real_1),
	.real_2(real_2),
	.real_3(real_3),
	.lap_0(lap_0),
	.lap_1(lap_1),
	.lap_2(lap_2),
	.lap_3(lap_3),
	.lap_4(lap_4),
	.lap_5(lap_5),
	.clk(clk),
	.rst_n(rst_n),
	.switch(switch_view),
	.state_start(state_start_out),
	.state_lap(state_lap_out),
	.switch_set(switch),
	.switch_count(switch_count)
	);
	
	
	state_lap stl(
	.button(one_pulse_lap_out),
	.button_out(state_lap_out),
	.state_start(state_start_out),
	.clk(clk),
	.rst_n(rst_n),
	.switch_set(switch)
	);
	
	state_start_pause st(
	.button(one_pulse_start_out),
	.button_out(state_start_out),
	.clk(clk),
	.rst_n(rst_n)
	);
	
	
	one_pulse o(
	.clk(clk),
	.rst_n(rst_n),
	.debounce_in(debounce_start_out),
	.one_pulse_out(one_pulse_start_out),
	.debounce_lap_in(debounce_lap_out),
	.one_pulse_lap_out(one_pulse_lap_out)
	);
	
	debounce de(
	.clk(cnt_h[0]),
	.rst_n(rst_n),
	.debounce_start_in(start_set_hour),
	.debounce_start_out(debounce_start_out),
	.debounce_lap_in(lap_set_min),
	.debounce_lap_out(debounce_lap_out)
	);
	
	digit d(
	.start_set_hour(state_start_out),
	.lap_set_min(state_lap_out),
	.value_0(value_0),
	.value_1(value_1),
	.value_2(value_2),
	.value_3(value_3),
	.value_4(value_4),
	.value_5(value_5),
	.clk(clk_out),
	.rst_n(rst_n),
	.switch(switch),
	.switch_count(switch_count)
	);
	
	
	bcd_seg b(
	.bcd(bcd),
	.display(display)
	);
	
	freq_div f(
	.clk(clk),
	.rst_n(rst_n),
	.clk_ctl(clk_ctl),
	.clk_out(clk_out),
	.cnt_h(cnt_h)
	);
	
	scan s(
	.freq_ctl(clk_ctl),
	.in0(real_0),
	.in1(real_1),
	.in2(real_2),
	.in3(real_3),
	.wh_light(wh_light),
	.light_num(bcd)
	);
endmodule
