module displayScore(VGA_clk, score, xCount, yCount, color);
    input VGA_clk;
    input [7:0] score;  // 8-bit score
    input [9:0] xCount;
    input [8:0] yCount;
    output reg [2:0] color;

    reg [3:0] digit1, digit2;  // Two digits to display the score
    wire [3:0] digit1 = score / 10;  // Tens place
    wire [3:0] digit2 = score % 10;  // Ones place

    // Assume a basic font encoding or simple digit patterns
    always @(posedge VGA_clk) begin
        // Example: Render the tens place and ones place at fixed positions
        if (xCount > 50 && xCount < 60 && yCount > 20 && yCount < 30) begin
            // Render the first digit (tens)
            color <= (digit1 == 0) ? 3'b000 : 3'b111;  // Change this to your digit encoding logic
        end else if (xCount > 60 && xCount < 70 && yCount > 20 && yCount < 30) begin
            // Render the second digit (ones)
            color <= (digit2 == 0) ? 3'b000 : 3'b111;  // Change this to your digit encoding logic
        end else begin
            color <= 3'b000;  // Background
        end
    end
endmodule
