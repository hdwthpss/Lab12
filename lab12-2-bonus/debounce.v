`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:04:46 09/02/2015 
// Design Name: 
// Module Name:    debounce 
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
module debounce(debounce_start_in,clk,rst_n,debounce_start_out,debounce_lap_in,debounce_lap_out
    );
	input debounce_start_in,debounce_lap_in;
	input clk,rst_n;
	output debounce_start_out,debounce_lap_out;
	reg debounce_start_out,debounce_lap_out;
	
	reg [3:0] debouce_window;
	reg [3:0] temp;
	reg temp_value;
	
	reg [3:0] debouce_window_lap;
	reg [3:0] temp_lap;
	reg temp_value_lap;
	
	
	always@(*)
		begin
			debouce_window[0]=~debounce_start_in;
			debouce_window[1]=temp[0];
			debouce_window[2]=temp[1];
			debouce_window[3]=temp[2];
			temp_value=debouce_window[0] & debouce_window[1] & debouce_window[2] & debouce_window[3];
			
			debouce_window_lap[0]=~debounce_lap_in;
			debouce_window_lap[1]=temp_lap[0];
			debouce_window_lap[2]=temp_lap[1];
			debouce_window_lap[3]=temp_lap[2];
			temp_value_lap=debouce_window_lap[0] & debouce_window_lap[1] & debouce_window_lap[2] & debouce_window_lap[3];
		end
	
	always@(posedge clk or negedge rst_n)
		if(~rst_n)
			begin
				temp<=4'b0000;
				temp_lap<=4'b0000;
			end

		else
			begin
				temp[0]<=debouce_window[0];
				temp[1]<=debouce_window[1];
				temp[2]<=debouce_window[2];
				temp[3]<=debouce_window[3];
				debounce_start_out<=temp_value;
				
				temp_lap[0]<=debouce_window_lap[0];
				temp_lap[1]<=debouce_window_lap[1];
				temp_lap[2]<=debouce_window_lap[2];
				temp_lap[3]<=debouce_window_lap[3];
				debounce_lap_out<=temp_value_lap;
			end
endmodule
