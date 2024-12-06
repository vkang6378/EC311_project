`timescale 1ns/1ps


module clkdiv_tb;
    // Testbench signals
    reg clk;          // Input clock
    wire clk25;       // Output divided clock

    // Instantiate the module under test
    clkdiv uut (
        .clk(clk),
        .clk25(clk25)
    );

    // Generate the clock signal
    initial begin
        clk = 0;
        forever #10 clk = ~clk;  // 50 MHz clock (20 ns period)
    end

    // Test duration
    initial begin
        #5000; // Simulate for 5000 ns
        $finish;
    end
endmodule
