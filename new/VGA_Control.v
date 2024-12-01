module VGA_Control
(
	input clk,
	input rst,
	input [4:0]sw,
	input [1:0]snake,
	input [5:0]apple_x,
	input [4:0]apple_y,
	output reg[9:0]x_pos,
	output reg[9:0]y_pos,	
	output reg hsync,
	output reg vsync,
	output reg [11:0] color_out
);

	reg [19:0]clk_cnt;
	reg [9:0]line_cnt;
	reg clk_25M;
	
	localparam NONE = 2'b00;
	localparam HEAD = 2'b01;
	localparam BODY = 2'b10;
	localparam WALL = 2'b11;

	integer HEAD_COLOR = 12'b1111_1111_0000;
	integer BODY_COLOR = 12'b0000_1111_0000;
	
	reg [3:0]lox;
	reg [3:0]loy;


	always@(posedge clk or negedge rst) begin
		if(!rst) begin
			clk_cnt <= 0;
			line_cnt <= 0;
			x_pos <=0;
			y_pos <=0;
			hsync <= 1;
			vsync <= 1;
		end
		else begin
		    x_pos <= clk_cnt - 144;
			y_pos <= line_cnt - 33;	
			if(clk_cnt == 0) begin
			    hsync <= 0;
				clk_cnt <= clk_cnt + 1;
            end
			else if(clk_cnt == 96) begin
				hsync <= 1;
				clk_cnt <= clk_cnt + 1;
            end
			else if(clk_cnt == 799) begin
				clk_cnt <= 0;
				line_cnt <= line_cnt + 1;
			end
			else clk_cnt <= clk_cnt + 1;
			if(line_cnt == 0) begin
				vsync <= 0;
            end
			else if(line_cnt == 2) begin
				vsync <= 1;
			end
			else if(line_cnt == 521) begin
				line_cnt <= 0;
				vsync <= 0;
			end
			
			if(x_pos >= 0 && x_pos < 640 && y_pos >= 0 && y_pos < 480) begin
			    lox = x_pos[3:0];
				loy = y_pos[3:0];						
				if(x_pos[9:4] == apple_x && y_pos[9:4] == apple_y)//640/16=40(0~40) 480/16=30(0~30)
					case({loy,lox})
						8'b0000_0000:color_out = 12'b0000_0000_0000;//使得边界处为黑，苹果显得圆润一点
						default:color_out = 12'b0000_0000_1111;
					endcase						
				else if(snake == NONE)
					color_out = 12'b0000_0000_0000;
				else if(snake == WALL)
					color_out = 12'b1011_0101_0101;
				else if(snake == HEAD|snake == BODY) begin   //根据当前扫描到的点是哪一部分输出相应颜色
					case({lox,loy})
						8'b0000_0000:color_out = 12'b0000_0000_0000;
						default:
//												         
						        if(sw[0]==0)begin
						          color_out = (snake == HEAD) ? 12'b1111_1111_0000 : 12'b1111_0000_0000;
						        end
						        else  if(sw[1]==0)begin
						          color_out = (snake == HEAD) ?  12'b1111_0000_0000 : 12'b0000_1111_1111;
						        end
						        else  if(sw[2]==0)begin
						          color_out = (snake == HEAD) ?  12'b0111_1001_0000 : 12'b0000_1001_1111;
						        end
						        else  if(sw[3]==0)begin
						          color_out = (snake == HEAD) ? 12'b0111_0000_1001 : 12'b1011_0000_1111;
						        end
						        else  if(sw[4]==0)begin
						          color_out = (snake == HEAD) ? 12'b1000_1110_1001 : 12'b1000_0100_0111;
						        end
						       else
						         color_out = (snake == HEAD) ?  HEAD_COLOR : BODY_COLOR;
					endcase
				end
			end
		    else
			    color_out = 12'b0000_0000_0000;
		end
    end
endmodule