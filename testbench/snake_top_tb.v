`timescale 1ns/1ps

module snake_top_tb;
    // Testbench signals
    reg clk;                       // Input clock
    reg rst;                       // Reset signal
    reg [0:4] key;                 // Key input
    reg PS2C, PS2D;                // PS/2 keyboard signals
    reg [3:0] move;                // Move signal from keyboard
    wire [0:7] led;                // LED output
    wire hsync, vsync;             // VGA sync signals
    wire [3:0] red, green, blue;   // VGA color signals
    wire [0:7] seg_cs, seg_data0;  // 7-segment display signals

    // Instantiate the module under test
    snake_top uut (
        .clk(clk),
        .rst(rst),
        .key(key),
        .PS2C(PS2C),
        .PS2D(PS2D),
        .move(move),
        .led(led),
        .hsync(hsync),
        .vsync(vsync),
        .red(red),
        .green(green),
        .blue(blue),
        .seg_cs(seg_cs),
        .seg_data0(seg_data0)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // 50 MHz clock
    end

    // Test sequence
    initial begin
        // Initialize inputs
        rst = 1;                // Apply reset
        key = 5'b00000;
        PS2C = 0;
        PS2D = 0;
        move = 4'b0000;

        #50 rst = 0;            // Release reset

        // Simulate key presses
        #100 key = 5'b10000;    // Simulate key input
        #100 key = 5'b00010;    // Another key input
        #100 key = 5'b00000;    // Release key

        // Simulate keyboard PS/2 signals
        #100 PS2C = 1; PS2D = 1; move = 4'b0100;
        #100 PS2C = 0; PS2D = 0;

        // Simulate movement
        #200 move = 4'b0010;

        // Simulate a score update
        #500 key = 5'b01000;    // Trigger score update

        // Wait and finish simulation
        #1000 $finish;
    end
endmodule
