////////////////////////////////////////////////////////////////////////
// Department of Computer Science
// National Tsing Hua University
// Project   : Design Gadgets for Hardware Lab
// Module    : RAM_ctrl
// Author    : Chih-Tsun Huang
// E-mail    : cthuang@cs.nthu.edu.tw
// Revision  : 2
// Date      : 2011/04/13
module RAM_ctrl (
  input clk,
  input rst_n,
  //input change,
  input [15:0] key,
  input en,
  output reg [7:0] data_out,
  output reg data_valid,
  input [3:0] real_0,real_1,real_2,real_3,
  input [3:0] in0,in1,in2,in3,
  input ctl_7_8
);

  //parameter mark  = 256'hc003_e007_700e_381c_1c38_0e70_07e0_03c0_03c0_07e0_0e70_1c38_381c_700e_e007_c003;
   parameter mark9  = 256'hFFFF_F00F_F00F_F00F_F00F_F00F_F00F_FFFF_000F_000F_000F_000F_000F_000F_000F_000F;
  parameter mark8  = 256'hFFFF_F00F_F00F_F00F_F00F_F00F_F00F_FFFF_F00F_F00F_F00F_F00F_F00F_F00F_F00F_FFFF;
  parameter mark7  = 256'hFFFF_F00F_F00F_F00F_F00F_F00F_F00F_F00F_000F_000F_000F_000F_000F_000F_000F_000F;
  parameter mark6  = 256'hFFFF_F000_F000_F000_F000_F000_F000_FFFF_F00F_F00F_F00F_F00F_F00F_F00F_F00F_FFFF;
  parameter mark5  = 256'hFFFF_F000_F000_F000_F000_F000_F000_FFFF_000F_000F_000F_000F_000F_000F_000F_FFFF;
  parameter mark4  = 256'hF00F_F00F_F00F_F00F_F00F_F00F_F00F_FFFF_000F_000F_000F_000F_000F_000F_000F_000F;
  parameter mark3  = 256'hFFFF_000F_000F_000F_000F_000F_000F_FFFF_000F_000F_000F_000F_000F_000F_000F_FFFF;
  parameter mark2  = 256'hFFFF_000F_000F_000F_000F_000F_000F_FFFF_F000_F000_F000_F000_F000_F000_F000_FFFF;
  parameter mark1  = 256'h0FF0_0FF0_0FF0_0FF0_0FF0_0FF0_0FF0_0FF0_0FF0_0FF0_0FF0_0FF0_0FF0_0FF0_0FF0_0FF0;
  parameter mark0  = 256'hFFFF_F00F_F00F_F00F_F00F_F00F_F00F_F00F_F00F_F00F_F00F_F00F_F00F_F00F_F00F_FFFF;
  parameter markA  = 256'hFFFF_F00F_F00F_F00F_F00F_F00F_F00F_FFFF_F00F_F00F_F00F_F00F_F00F_F00F_F00F_F00F;
  parameter markP  = 256'hFFFF_F00F_F00F_F00F_F00F_F00F_F00F_FFFF_F000_F000_F000_F000_F000_F000_F000_F000;
  parameter markM  = 256'hFFFF_F3CF_F3CF_F3CF_F3CF_F3CF_F3CF_F3CF_F3CF_F3CF_F3CF_F3CF_F3CF_F3CF_F3CF_F3CF;
  
  parameter IDLE  = 2'd0;
  parameter WRITE = 2'd1;
  parameter GETDATA = 2'd2;
  parameter TRANSDATA = 2'd3;
	
  wire change;	
  reg [5:0] addr, addr_next;
  reg [5:0] counter_word, counter_word_next;
  wire [63:0] data_out_64;
  reg [63:0] data_in;
  reg [15:0] in_temp0, in_temp1, in_temp2, in_temp3;
  reg [1:0] cnt, cnt_next;  //count mark row
  reg [511:0] mem, mem_next;
  reg [1:0] state, state_next;
  reg flag, flag_next;
  reg [7:0] data_out_next;
  reg data_valid_next;
  reg wen, wen_next;
  reg temp_change, temp_change_next;
 
 /* assign in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark[(240-((addr%16)*16))+:16];
  assign in_temp1 = key[14-(cnt*4)] == 1'b0 ? 16'd0 : mark[(240-((addr%16)*16))+:16];
  assign in_temp2 = key[13-(cnt*4)] == 1'b0 ? 16'd0 : mark[(240-((addr%16)*16))+:16];
  assign in_temp3 = key[12-(cnt*4)] == 1'b0 ? 16'd0 : mark[(240-((addr%16)*16))+:16];*/

   assign change=1'b1;
  
  always@(*)
 
  if(ctl_7_8==1'b1)
   begin
	case(real_3)
		4'd0 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark0[(240-((addr%16)*16))+:16];
		4'd1 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark1[(240-((addr%16)*16))+:16];
		4'd2 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark2[(240-((addr%16)*16))+:16];
		4'd3 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark3[(240-((addr%16)*16))+:16];
		4'd4 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark4[(240-((addr%16)*16))+:16];
		4'd5 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark5[(240-((addr%16)*16))+:16];
		4'd6 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark6[(240-((addr%16)*16))+:16];
		4'd7 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark7[(240-((addr%16)*16))+:16];
		4'd8 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark8[(240-((addr%16)*16))+:16];
		4'd9 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark9[(240-((addr%16)*16))+:16];
		4'd15 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : markA[(240-((addr%16)*16))+:16];
		4'd13 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : markP[(240-((addr%16)*16))+:16];
	endcase
  
	case(real_2)
		4'd0 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark0[(240-((addr%16)*16))+:16];
		4'd1 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark1[(240-((addr%16)*16))+:16];
		4'd2 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark2[(240-((addr%16)*16))+:16];
		4'd3 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark3[(240-((addr%16)*16))+:16];
		4'd4 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark4[(240-((addr%16)*16))+:16];
		4'd5 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark5[(240-((addr%16)*16))+:16];
		4'd6 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark6[(240-((addr%16)*16))+:16];
		4'd7 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark7[(240-((addr%16)*16))+:16];
		4'd8 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark8[(240-((addr%16)*16))+:16];
		4'd9 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark9[(240-((addr%16)*16))+:16];
		4'd14 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : markM[(240-((addr%16)*16))+:16];
	endcase
	case(real_1)
		4'd0 :
			in_temp2 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark0[(240-((addr%16)*16))+:16];
		4'd1 :
			in_temp2 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark1[(240-((addr%16)*16))+:16];
		4'd2 :
			in_temp2 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark2[(240-((addr%16)*16))+:16];
		4'd3 :
			in_temp2 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark3[(240-((addr%16)*16))+:16];
		4'd4 :
			in_temp2 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark4[(240-((addr%16)*16))+:16];
		4'd5 :
			in_temp2 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark5[(240-((addr%16)*16))+:16];
		4'd6 :
			in_temp2 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark6[(240-((addr%16)*16))+:16];
		4'd7 :
			in_temp2 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark7[(240-((addr%16)*16))+:16];
		4'd8 :
			in_temp2 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark8[(240-((addr%16)*16))+:16];
		4'd9 :
			in_temp2 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark9[(240-((addr%16)*16))+:16];
	endcase
	
	case(real_0)
		4'd0 :
			in_temp3 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark0[(240-((addr%16)*16))+:16];
		4'd1 :
			in_temp3 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark1[(240-((addr%16)*16))+:16];
		4'd2 :
			in_temp3 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark2[(240-((addr%16)*16))+:16];
		4'd3 :
			in_temp3 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark3[(240-((addr%16)*16))+:16];
		4'd4 :
			in_temp3 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark4[(240-((addr%16)*16))+:16];
		4'd5 :
			in_temp3 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark5[(240-((addr%16)*16))+:16];
		4'd6 :
			in_temp3 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark6[(240-((addr%16)*16))+:16];
		4'd7 :
			in_temp3 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark7[(240-((addr%16)*16))+:16];
		4'd8 :
			in_temp3 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark8[(240-((addr%16)*16))+:16];
		4'd9 :
			in_temp3 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark9[(240-((addr%16)*16))+:16];
	endcase
   end
  
  else
	begin
		case(in3)
		4'd0 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark0[(240-((addr%16)*16))+:16];
		4'd1 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark1[(240-((addr%16)*16))+:16];
		4'd2 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark2[(240-((addr%16)*16))+:16];
		4'd3 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark3[(240-((addr%16)*16))+:16];
		4'd4 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark4[(240-((addr%16)*16))+:16];
		4'd5 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark5[(240-((addr%16)*16))+:16];
		4'd6 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark6[(240-((addr%16)*16))+:16];
		4'd7 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark7[(240-((addr%16)*16))+:16];
		4'd8 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark8[(240-((addr%16)*16))+:16];
		4'd9 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark9[(240-((addr%16)*16))+:16];
		4'd15 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : markA[(240-((addr%16)*16))+:16];
		4'd13 :
			in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : markP[(240-((addr%16)*16))+:16];
	endcase
  
	case(in2)
		4'd0 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark0[(240-((addr%16)*16))+:16];
		4'd1 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark1[(240-((addr%16)*16))+:16];
		4'd2 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark2[(240-((addr%16)*16))+:16];
		4'd3 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark3[(240-((addr%16)*16))+:16];
		4'd4 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark4[(240-((addr%16)*16))+:16];
		4'd5 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark5[(240-((addr%16)*16))+:16];
		4'd6 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark6[(240-((addr%16)*16))+:16];
		4'd7 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark7[(240-((addr%16)*16))+:16];
		4'd8 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark8[(240-((addr%16)*16))+:16];
		4'd9 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark9[(240-((addr%16)*16))+:16];
		4'd14 :
			in_temp1 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : markM[(240-((addr%16)*16))+:16];
	endcase
	case(in1)
		4'd0 :
			in_temp2 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark0[(240-((addr%16)*16))+:16];
		4'd1 :
			in_temp2 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark1[(240-((addr%16)*16))+:16];
		4'd2 :
			in_temp2 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark2[(240-((addr%16)*16))+:16];
		4'd3 :
			in_temp2 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark3[(240-((addr%16)*16))+:16];
		4'd4 :
			in_temp2 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark4[(240-((addr%16)*16))+:16];
		4'd5 :
			in_temp2 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark5[(240-((addr%16)*16))+:16];
		4'd6 :
			in_temp2 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark6[(240-((addr%16)*16))+:16];
		4'd7 :
			in_temp2 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark7[(240-((addr%16)*16))+:16];
		4'd8 :
			in_temp2 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark8[(240-((addr%16)*16))+:16];
		4'd9 :
			in_temp2 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark9[(240-((addr%16)*16))+:16];
	endcase
	
	case(in0)
		4'd0 :
			in_temp3 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark0[(240-((addr%16)*16))+:16];
		4'd1 :
			in_temp3 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark1[(240-((addr%16)*16))+:16];
		4'd2 :
			in_temp3 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark2[(240-((addr%16)*16))+:16];
		4'd3 :
			in_temp3 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark3[(240-((addr%16)*16))+:16];
		4'd4 :
			in_temp3 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark4[(240-((addr%16)*16))+:16];
		4'd5 :
			in_temp3 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark5[(240-((addr%16)*16))+:16];
		4'd6 :
			in_temp3 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark6[(240-((addr%16)*16))+:16];
		4'd7 :
			in_temp3 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark7[(240-((addr%16)*16))+:16];
		4'd8 :
			in_temp3 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark8[(240-((addr%16)*16))+:16];
		4'd9 :
			in_temp3 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark9[(240-((addr%16)*16))+:16];
	endcase
	end
  

  
  
  RAM R1(
    .clka(clk),
    .wea(wen),
    .addra(addr),
    .dina(data_in),
    .douta(data_out_64)
  );

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      addr = 6'd0;
      cnt = 2'd0;
      mem = 512'd0;
      state = IDLE;
      flag = 1'b0;
      counter_word = 6'd0;
      data_out = 8'd0;
      data_valid = 1'd0;
      wen = 1'b1;
      temp_change = 1'b0;
    end else begin
      addr = addr_next;
      cnt = cnt_next;
      mem = mem_next;
      state = state_next;
      flag = flag_next;
      counter_word = counter_word_next;
      data_out = data_out_next;
      data_valid = data_valid_next;
      wen = wen_next;
      temp_change = temp_change_next;
    end
  end

  always @(*) begin
    state_next = state;
    case(state)
      IDLE: begin
        if (wen) begin
          state_next = WRITE;
        end else begin
          state_next = GETDATA;
        end
      end
      WRITE: begin
        if (addr == 6'd63) begin
          state_next = GETDATA;
        end
      end
      GETDATA: begin
        if (flag == 1'b1) begin
          state_next = TRANSDATA;
        end
      end
      TRANSDATA: begin
        if (addr == 6'd0 && counter_word == 6'd63 && en) begin
          state_next = IDLE;
        end else if (counter_word == 6'd63 && en) begin
          state_next = GETDATA;
        end
      end
    endcase
  end

  always @(*) begin
    addr_next = addr;
    data_in = 64'd0;
    cnt_next = cnt;
    mem_next = mem;
    flag_next = 1'b0;
    counter_word_next = counter_word;
    data_valid_next = 1'd0;
    data_out_next = 8'd0;
    case(state)
      WRITE: begin
        addr_next = addr + 1'b1;
        data_in = {in_temp0, in_temp1, in_temp2, in_temp3};
        if (addr == 6'd15 || addr == 6'd31 || addr == 6'd47 || addr == 6'd63) begin
          cnt_next = cnt + 1'd1;
        end
      end
      GETDATA: begin
        if (!flag) begin
          addr_next = addr + 1'b1;
        end
        if ((addr%8) == 6'd7) begin
          flag_next = 1'b1;
        end
        if ((addr%8) >= 6'd1 || flag) begin
          mem_next[(((addr-1)%8)*64)+:64] = data_out_64;
        end
      end
      TRANSDATA: begin
        if (en) begin
          counter_word_next = counter_word + 1'b1;
          data_valid_next = 1'b1;
          data_out_next = {mem[511 - counter_word],
            mem[447 - counter_word],
            mem[383 - counter_word],
            mem[319 - counter_word],
            mem[255 - counter_word],
            mem[191 - counter_word],
            mem[127 - counter_word],
            mem[63 - counter_word]};
        end
      end
    endcase
  end
 
  //wen control
  always @(*) begin
    wen_next = wen;
    temp_change_next = temp_change;
    if (change) begin
      temp_change_next = 1'b1;
    end
    if (state == WRITE && addr == 6'd63) begin
      wen_next = 1'b0;
    end
    if (state == TRANSDATA && addr == 6'd0 && counter_word == 6'd63 && temp_change == 1'b1) begin
      temp_change_next = 1'b0;
      wen_next = 1'b1;
    end
  end
endmodule
