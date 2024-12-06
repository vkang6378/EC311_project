module keyboard(
    input wire clk,
    input wire clr,
    input wire PS2C,
    input wire PS2D,
    input wire [3:0] move,
    output reg [2:0] kb_out
);

    reg PS2Cf; 
    reg PS2Df;
    reg [0:20] cnt_xd = 0;   
    reg [7:0] key_pass;
    reg [1:0] clk_25MHz;
    reg [7:0] ps2c_filter,ps2d_filter;
    reg [10:0] shift1,shift2;  
    reg DIR1 = 1'b0;   
    wire [15:0] xkey;

    parameter xd = 21'd2000000;    


    always @(posedge clk) begin  //25MHZ
    if(clk_25MHz >= 3)
    begin
        DIR1 <= 1'b1;
        clk_25MHz <= 0;
    end
    else
    begin
        clk_25MHz <= clk_25MHz + 1;
        DIR1 <= 1'b0;
    end
    end

    //filter for PS2 clock and data
    always @(posedge DIR1)
    begin
        if(!clr)
            begin
            ps2c_filter <= 0;
            ps2d_filter <= 0;
            PS2Cf <= 1;
            PS2Df <= 1;
            end
         else
            begin
            ps2c_filter[7]<=PS2C;
            ps2c_filter[6:0]<=ps2c_filter[7:1];
            ps2d_filter[7]<=PS2D;
            ps2d_filter[6:0]<=ps2d_filter[7:1];
            if(ps2c_filter==8'b11111111)
                PS2Cf <= 1;
            else
                if(ps2c_filter == 8'b00000000)
                PS2Cf <= 0;
            if(ps2d_filter == 8'b11111111)
                PS2Df <= 1;
            else
                if(ps2d_filter == 8'b00000000)
                PS2Df <= 0;
            end
     end

    always @(negedge PS2Cf) begin   
    if(!clr)
    begin
        shift1 <= 0;
        shift2 <= 0;
    end
    else
    begin
        shift1 <= {PS2Df,shift1[10:1]};
        shift2 <= {shift1[0],shift2[10:1]};
    end 
    end
    
    assign xkey = {shift2[8:1],shift1[8:1]};
    
   
    always@(posedge clk) begin   
    key_pass = xkey[7:0];
    if(key_pass != 8'h63 & key_pass != 8'h60 & key_pass != 8'h61 & key_pass != 8'h6a)    
        cnt_xd = 0;
    else if(cnt_xd == xd)
        cnt_xd <= xd;
    else
        cnt_xd <= cnt_xd + 1;
    end

    always@(posedge clk) begin
 //    if(cnt_xd == (xd - 21'b1))    
        case(move)     
        5'b00001: kb_out <= 1;    //↑
        5'b00010: kb_out <= 2;    //↓
        5'b00100: kb_out <= 3;    //←
        5'b01000: kb_out <= 4;    //→
        default : kb_out <= 0;
        endcase
 //   else
  //      kb_out <= 0;   
    end

endmodule
