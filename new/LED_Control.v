module LED_Control(
	input clk,
	input rst,
	
	input [6:0] cube_num,
	output reg [15:0]led
);
    reg [23:0]counter;
	always@(posedge clk or negedge rst)begin
		if(!rst)
			counter<=24'd0;
	    else if(cube_num>=16)begin
			if(counter<24'd1000_0000)
			counter<=counter+1'b1;
			else
			counter<=24'd0;
			end
	end
	
	always@(posedge clk or negedge rst)begin
		if(!rst)
			led<=16'b0000_0000_0000_0001;
		else if(counter==24'd1000_0000)
			led[15:0]<={led[14:0],led[15]};
		else
			led<=led;
	end
endmodule	
