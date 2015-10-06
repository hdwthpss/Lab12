`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:05:01 09/02/2015 
// Design Name: 
// Module Name:    one_pulse 
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
module one_pulse(debounce_in,one_pulse_out,clk,rst_n,debounce_lap_in,one_pulse_lap_out
    );
	input debounce_in,debounce_lap_in;
	input clk,rst_n;
	output one_pulse_out,one_pulse_lap_out;
	
	reg one_pulse_out;
	reg debounce_in_delay;
	reg temp;
	
	reg one_pulse_lap_out;
	reg debounce_lap_in_delay;
	reg temp_lap;
	
	always@(posedge clk or negedge rst_n)
		if(~rst_n)
			begin
				debounce_in_delay<=1'b0;
				debounce_lap_in_delay<=1'b0;
			end
		else
			begin
				debounce_in_delay<=debounce_in;
				debounce_lap_in_delay<=debounce_lap_in;
			end
	
	always@(*)
		begin
			temp=debounce_in & (~debounce_in_delay);
			temp_lap=debounce_lap_in & (~debounce_lap_in_delay);
		end
		
	always@(posedge clk or negedge rst_n)
		if(~rst_n)
			begin
				one_pulse_out<=1'b0;
				one_pulse_lap_out<=1'b0;
			end
		else
			begin
				one_pulse_out<=temp;
				one_pulse_lap_out<=temp_lap;
			end
		

endmodule
