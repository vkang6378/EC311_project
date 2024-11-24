module apple_tb();

    // Declare inputs as regs and outputs as wires
    reg VGA_clk;
    reg [9:0] xCount;
    reg [8:0] yCount;
    reg start;
    wire apple;
    wire score_increment;

    // Instantiate the apple module
    apple uut (
        .VGA_clk(VGA_clk),
        .xCount(xCount),
        .yCount(yCount),
        .start(start),
        .apple(apple),
        .score_increment(score_increment)
    );

    // Clock generation
    always begin
        #5 VGA_clk = ~VGA_clk;  // Toggle VGA_clk every 5 ns
    end

    // Stimulus process
    initial begin
        // Initialize inputs
        VGA_clk = 0;
        xCount = 0;
        yCount = 0;
        start = 0;
        
        // Apply test vectors
        #10 xCount = 50; yCount = 50; start = 1; // Simulate snake near apple
        #10 xCount = 60; yCount = 60; start = 0; // Simulate snake eating apple
        #10 xCount = 100; yCount = 100; start = 1; // Simulate snake moving away from apple
        #10 xCount = 50; yCount = 50; start = 1; // Simulate snake near apple again

        // Finish the simulation
        #50 $finish;
    end

    // Monitor output signals
    initial begin
        $monitor("At time %t, xCount = %d, yCount = %d, apple = %b, score_increment = %b", 
                 $time, xCount, yCount, apple, score_increment);
    end

endmodule
