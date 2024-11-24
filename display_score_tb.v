module display_score_tb();

    // Declare inputs as regs and outputs as wires
    reg VGA_clk;
    reg [7:0] score; // 8-bit score input
    reg [9:0] xCount;
    reg [8:0] yCount;
    wire [2:0] color; // Color output from displayScore

    // Instantiate the displayScore module
    displayScore uut (
        .VGA_clk(VGA_clk),
        .score(score),
        .xCount(xCount),
        .yCount(yCount),
        .color(color)
    );

    // Clock generation
    always begin
        #5 VGA_clk = ~VGA_clk;  // Toggle VGA_clk every 5 ns
    end

    // Stimulus process
    initial begin
        // Initialize inputs
        VGA_clk = 0;
        score = 0;
        xCount = 0;
        yCount = 0;

        // Apply test vectors (simulate different score values and coordinates)
        #10 score = 5; xCount = 50; yCount = 20; // Display score 5 at (50, 20)
        #10 score = 12; xCount = 60; yCount = 20; // Display score 12 at (60, 20)
        #10 score = 99; xCount = 70; yCount = 20; // Display score 99 at (70, 20)
        #10 score = 50; xCount = 80; yCount = 20; // Display score 50 at (80, 20)
        #10 score = 10; xCount = 90; yCount = 20; // Display score 10 at (90, 20)

        // Finish the simulation
        #50 $finish;
    end

    // Monitor output signals
    initial begin
        $monitor("At time %t, score = %d, xCount = %d, yCount = %d, color = %b", 
                 $time, score, xCount, yCount, color);
    end

endmodule
