`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:32:57 08/21/2015 
// Design Name: 
// Module Name:    bcd_seg 
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
module bcd_seg(bcd,display
    );
	 input [3:0] bcd;
	 output [14:0] display;
	 reg [14:0] display;
	 
	 always@(bcd)
		case(bcd)
			4'b0000: display = 15'b0000_0011_1111_111; //0
			4'b0001: display = 15'b1111_1111_1011_011; //1
			4'b0010: display = 15'b0010_0100_1111_111; //2
			4'b0011: display = 15'b0000_1100_1111_111; //3
			4'b0100: display = 15'b1001_1000_1111_111; //4
			4'b0101: display = 15'b0100_1000_1111_111; //5
			4'b0110: display = 15'b0100_0000_1111_111; //6
			4'b0111: display = 15'b0001_1111_1111_111; //7
			4'b1000: display = 15'b0000_0000_1111_111; //8
			4'b1001: display = 15'b0000_1000_1111_111; //9
			4'b1111: display = 15'b0001_0000_1111_111; //A
			4'b1110: display = 15'b1001_0011_0101_111; //M
			4'b1101: display = 15'b0011_0000_1111_111; //P
			
			
			default: display = 15'b1111_1111_1111_111; //DEF
		endcase



endmodule
