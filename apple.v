module apple(VGA_clk, xCount, yCount, start, apple, score_increment);
    input VGA_clk, xCount, yCount, start;
    wire [9:0] appleX;
    wire [8:0] appleY;
    reg apple_inX, apple_inY;
    output apple;
    output reg score_increment;
    wire [9:0] rand_X;
    wire [8:0] rand_Y;
    random_grid rand1(VGA_clk, rand_X, rand_Y);

    assign appleX = rand_X;
    assign appleY = rand_Y;

    always @(negedge VGA_clk) begin
        apple_inX <= (xCount > appleX && xCount < (appleX + 10));
        apple_inY <= (yCount > appleY && yCount < (appleY + 10));
    end

    assign apple = apple_inX && apple_inY;

    // Score increment logic
    always @(posedge VGA_clk) begin
        if (apple_inX && apple_inY) begin
            score_increment <= 1;  // Apple eaten, increment score
        end else begin
            score_increment <= 0;  // No apple eaten
        end
    end
endmodule
