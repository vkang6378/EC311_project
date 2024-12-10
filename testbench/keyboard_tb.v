`timescale 1ns/1ps

module keyboard_tb;
    reg clk;                  
    reg [3:0] move;          
    wire [2:0] kb_out;       

    keyboard uut (
        .clk(clk),
        .move(move),
        .kb_out(kb_out)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk; 
    end

    initial begin
        move = 4'b0000;

        #50 move = 4'b0001; 
        #4000000 move = 4'b0000; 

        #50 move = 4'b0010; 
        #4000000 move = 4'b0000; 

        #50 move = 4'b0100; 
        #4000000 move = 4'b0000; 

        #50 move = 4'b1000; 
        #4000000 move = 4'b0000; 
        #100 $finish; 
    end

endmodule
