`timescale 1ns/1ps

module snake_tb;
    reg clk;                    
    reg vidon;                  
    reg clr;                    
    reg [9:0] hc;               
    reg [9:0] vc;                
    reg [2:0] key_out;          
    reg [2:0] kb_out;            
    reg [0:127] M;               
    reg [0:159] M1;              
    wire [0:7] led;              
    wire [3:0] red, green, blue; 
    wire [6:0] score;            
    wire [4:0] rom_addr;         

    snake U3(
            .clk(clk),   
            .vidon(vidon),
            .clr(clr),
            .hc(hc),
            .vc(vc),
            .M(M),
            .M1(M1),
            .rom_addr(rom_addr),
            .key_out(key_out),
            .kb_out(kb_out),
            .score(score),
            .led(led),
            .red(red),
            .green(green),
            .blue(blue)
    );


    initial begin
        clk = 0;
        forever #10 clk = ~clk; 
    end

    initial begin
        vidon = 0;
        clr = 0;
        hc = 0;
        vc = 0;
        key_out = 0;
        kb_out = 0;
        M = 128'b0;
        M1 = 160'b0;

        #50 clr = 1;        
        #50 vidon = 1;     

        #100 hc = 300; vc = 200; key_out = 3'd1; kb_out = 3'd2; 
        #1000 hc = 400; vc = 300; key_out = 3'd4; kb_out = 3'd3; 
        #500 key_out = 3'd0; kb_out = 3'd0; 

        #2000 clr = 0; 
        #100 clr = 1;  

        #10000 $finish;
    end

endmodule
