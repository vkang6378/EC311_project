module snake_top (
    input wire clk,   
    input wire rst,   
    input wire [0:4] key,   
    input wire PS2C,PS2D, 
    input wire [3:0] move,  
    output wire [0:7] led,   
    output wire hsync,vsync,  
    output wire [3:0] red,green,blue,  
    output wire [0:7] seg_cs,seg_data0  
);

    wire clk25,clr,vidon;
    wire [9:0] hc,vc;   
    wire [2:0] key_out,kb_out;  
    wire [6:0] score;  
    wire [0:127] M;   
    wire [0:159] M1; 
    wire [4:0] rom_addr;  
    assign clr = rst;   

    clkdiv U1(.clk(clk),    
              .clk25(clk25));
    
    vga U2(.clk25(clk25),  
           .hsync(hsync),
           .vsync(vsync),
           .hc(hc),
           .vc(vc),
           .vidon(vidon));
           
    snake U3(.clk(clk),   
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
            .blue(blue));

    keyin U4(.clk(clk),   
            .key(key),
            .key_out(key_out));

    keyboard U5(.clk(clk),    
            .clr(clr),
            .PS2C(PS2C),
            .PS2D(PS2D),
            .move(move),
            .kb_out(kb_out));

    scoring U6(.clk(clk),   
            .score(score),
            .seg_cs(seg_cs),
            .seg_data0(seg_data0));


endmodule
