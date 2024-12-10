`timescale 1ns/1ps

module vga_tb;
    reg clk25;                
    wire hsync;                
    wire vsync;                
    wire [9:0] hc;             
    wire [9:0] vc;             
    wire vidon;               

    vga uut (
        .clk25(clk25),
        .hsync(hsync),
        .vsync(vsync),
        .hc(hc),
        .vc(vc),
        .vidon(vidon)
    );

    initial begin
        clk25 = 0;
        forever #20 clk25 = ~clk25; 
    end

    initial begin
        #100000;

        $finish;
    end

endmodule
