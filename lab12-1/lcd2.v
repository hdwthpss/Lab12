////////////////////////////////////////////////////////////////////////
// Department of Computer Science
// National Tsing Hua University
// Project   : Design Gadgets for Hardware Lab
// Module    : lcd2 (top module)
// Author    : Chih-Tsun Huang
// E-mail    : cthuang@cs.nthu.edu.tw
// Revision  : 2
// Date      : 2011/04/13
`define BCD_BIT_WIDTH 4
module lcd2 (
  input              clk,
  input              rst_n,
  input  wire [3:0]  col,
  output wire [3:0]  row,
  output             LCD_rst,
  output wire [1:0]  LCD_cs,
  output             LCD_rw,
  output             LCD_di,
  output wire [7:0]  LCD_data,
  output             LCD_en,
  output wire [15:0] key,
  input switch,
  input switch_mode,
	
	
	
	output wire [3:0] wh_light,
	output [14:0] display
);

  wire change,en,out_valid;
  wire [7:0] data_out;
  wire clk_div;
	
	
	
	wire [`BCD_BIT_WIDTH-1:0] in0,in1,in2,in3; 
	
	

	
	test t(
	.rst_n(rst_n),
   .clk(clk),
	.wh_light(wh_light),
	.display(display),
	.in0(in0),
	.in1(in1),
	.in2(in2),
	.in3(in3),
	.switch(switch),
	.switch_mode(switch_mode)
	);
	
  keypad_scan K1 (
    .rst_n(rst_n),
    .clk(clk_div),
    .col(col),
    .row(row),
    .change(change),          // push and release
    .key(key)                 // mask {F,E,D,C,B,3,6,9,A,2,5,8,0,1,4,7}
  );


  RAM_ctrl R2 (
    .clk(clk_div),
    .rst_n(rst_n),
    //.change(change),
    .key(16'b0000_0000_0000_1111),
    .en(en),
    .data_out(data_out),
    .data_valid(out_valid),
	 .in0(in0),
	 .in1(in1),
	 .in2(in2),
	 .in3(in3)
	 );

  lcd_ctrl d1 (
    .clk(clk_div),
    .rst_n(rst_n),
    .data(data_out),           // memory value  
    .data_valid(out_valid),    // if data_valid = 1 the data is valid
    .LCD_di(LCD_di),
    .LCD_rw(LCD_rw),
    .LCD_en(LCD_en),
    .LCD_rst(LCD_rst),
    .LCD_cs(LCD_cs),
    .LCD_data(LCD_data),
    .en_tran(en)
  );

  clock_divider #(
    .half_cycle(200),         // half cycle = 200 (divided by 400)
    .counter_width(8)         // counter width = 8 bits
  ) clk100K (
    .rst_n(rst_n),
    .clk(clk),
    .clk_div(clk_div)
  );
  
  
 

endmodule
