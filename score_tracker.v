module score_tracker(VGA_clk, score_increment, score);
    input VGA_clk, score_increment;
    output reg [7:0] score;

    always @(posedge VGA_clk) begin
        if (score_increment) begin
            score <= score + 1;  // Increment the score when the apple is eaten
        end
    end
endmodule
