module clkdiv (
    input wire clk,
    output wire clk25
);
    
    reg [21:0] q;
    always@(posedge clk)   begin
    if(q == 22'd4194303)
        q <= 0;
    else
        q <= q + 1;
    end
    assign clk25 = q[1];
endmodule