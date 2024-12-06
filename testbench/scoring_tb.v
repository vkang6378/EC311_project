`timescale 1ns/1ps

module scoring_tb;
    // Testbench signals
    reg clk;                   // Input clock
    reg clr;                   // Clear signal
    reg [6:0] score;           // Score input
    wire [0:7] seg_cs;         // 7-segment control signals
    wire [0:7] seg_data0;      // 7-segment data signals

    // Instantiate the module under test
    scoring uut (
        .clk(clk),
        .clr(clr),
        .score(score),
        .seg_cs(seg_cs),
        .seg_data0(seg_data0)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // 50 MHz clock (20 ns period)
    end

    // Test sequence
    initial begin
        // Initialize signals
        clr = 0;
        score = 0;

        // Test case 1: Display score = 0
        #1000000; // Wait 1 ms
        score = 7'd123; // Test case 2: Set score to 123

        #1000000; // Wait 1 ms
        score = 7'd45;  // Test case 3: Set score to 45

        #1000000; // Wait 1 ms
        score = 7'd9;   // Test case 4: Set score to 9

        #1000000; // Wait 1 ms
        clr = 1; // Test case 5: Clear signal active
        #100000;
        clr = 0;

        #1000000; // End simulation
        $finish;
    end

endmodule
