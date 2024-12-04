//640*480
module vga (
    input wire clk25,
    output reg hsync,
    output reg vsync,
    output reg [9:0] hc,
    output reg [9:0] vc,
    output reg vidon
);

    parameter hpixels = 10'b1100100000;    //行像素点，800
    parameter vlines = 10'b1000001001;    //行数，521
    parameter hbp = 10'b0010010000;       //行显示后沿，144（128+16）
    parameter hfp = 10'b1100010000;       //行显示前沿784（128+16+640）
    parameter vbp = 10'b0000011111;       //场显示后延，31（2+29）
    parameter vfp = 10'b0111111111;       //场显示前沿，511（2+29+480）
    
    reg vsenable;

    always @(posedge clk25) begin
    if(hc == hpixels - 1)
    begin
        hc <= 0;
        vsenable <= 1;
    end
    else
    begin
        hc <= hc +1;
        vsenable <= 0;
    end 
    end

    always @(*) begin
    if(hc < 96)  //同步为96
        hsync = 0;
    else
        hsync = 1;
    end

    always @(posedge clk25) begin
    if(vsenable == 1)
    begin
        if(vc == vlines - 1)
            vc <= 0;
        else
            vc <= vc + 1;
    end
    else
        vc <= vc;   
    end

    always @(*) begin
    if(vc < 2)   //同步为2
        vsync = 0;
    else
        vsync = 1;
    end

    always @(*) begin
    if((hc < hfp)&&(hc >= hbp)&&(vc < vfp)&&(vc >= vbp))
        vidon = 1;
    else
        vidon = 0;
    end
endmodule