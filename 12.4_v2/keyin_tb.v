`timescale 1ns/1ps

module keyin_tb;
    // Testbench signals
    reg clk;                     // Input clock
    reg [4:0] key;               // Key input
    wire [2:0] key_out;          // Key output

    // Instantiate the module under test
    keyin uut (
        .clk(clk),
        .key(key),
        .key_out(key_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk;  // 50 MHz clock (20 ns period)
    end

    // Test sequence
    initial begin
        // Initialize signals
        key = 5'b00000;

        // Apply test cases
        #50 key = 5'b10000; // Simulate key press for key_out = 1
        #4000000 key = 5'b00000; // Release key

        #50 key = 5'b01000; // Simulate key press for key_out = 2
        #4000000 key = 5'b00000; // Release key

        #50 key = 5'b00010; // Simulate key press for key_out = 3
        #4000000 key = 5'b00000; // Release key

        #50 key = 5'b00001; // Simulate key press for key_out = 4
        #4000000 key = 5'b00000; // Release key

        #50 key = 5'b00100; // Simulate key press for key_out = 5
        #4000000 key = 5'b00000; // Release key

        #100 $finish; // End the simulation
    end

endmodule
