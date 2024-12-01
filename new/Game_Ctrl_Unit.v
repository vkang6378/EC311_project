//游戏控制模块 根据游戏状态产生相应控制信号	
module Game_Ctrl_Unit
(
	input clk,
	input rst,
	input key1_press,
	input key2_press,
	input key3_press,
	input key4_press,
	
	output reg [1:0]game_status,//游戏状态判断
	input hit_wall,//hit wall
	input hit_body,//hit body
	output reg die_flash,//die
	output reg restart//restart
);
	
	localparam RESTART = 2'b00;
	localparam START = 2'b01;
	localparam PLAY = 2'b10;
	localparam DIE = 2'b11;
	
	reg[31:0]clk_cnt;//used in waiting the game restrat 
	
	always@(posedge clk or negedge rst)
	begin
		if(!rst) begin
			game_status <= START;//start
			clk_cnt <= 0;
			die_flash <= 1;
			restart <= 0;
		end
		else begin
			case(game_status)			
				RESTART:begin           //waiting for start 
					if(clk_cnt <= 5) begin
						clk_cnt <= clk_cnt + 1;
						restart <= 1;						
					end
					else begin
						game_status <= START;
						clk_cnt <= 0;
						restart <= 0;
					end
				end
				//if push the button, the game start 
				START:begin
					if (key1_press | key2_press | key3_press | key4_press)
                        game_status <= PLAY;
					else 
					    game_status <= START;
				end
				//if hit body or hit wall, die
				PLAY:begin
					if(hit_wall | hit_body)
					   game_status <= DIE;
					else
					   game_status <= PLAY;
				end
				//if die, 2s flash 				
				DIE:begin
					if(clk_cnt <= 200_000_000) begin
						clk_cnt <= clk_cnt + 1'b1;
					   if(clk_cnt == 25_000_000)
					       die_flash <= 0;
					   else if(clk_cnt == 50_000_000)
					       die_flash <= 1'b1;
					   else if(clk_cnt == 75_000_000)
					       die_flash <= 1'b0;
					   else if(clk_cnt == 100_000_000)
					       die_flash <= 1'b1;
					   else if(clk_cnt == 125_000_000)
					       die_flash <= 1'b0;
					   else if(clk_cnt == 150_000_000)
					       die_flash <= 1'b1;
				    end                        //flash 
					else
						begin
							die_flash <= 1;
							clk_cnt <= 0;
							game_status <= RESTART;
						end
					end
			endcase
		end
	end
endmodule