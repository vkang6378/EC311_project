module keyboard(
    input wire clk,
    input wire [3:0] move,
    output reg [2:0] kb_out
);


    always@(posedge clk) begin
        case(move)     
        5'b00001: kb_out <= 1;    //↑
        5'b00010: kb_out <= 2;    //↓
        5'b00100: kb_out <= 3;    //←
        5'b01000: kb_out <= 4;    //→
        default : kb_out <= 0;
        endcase

    end

endmodule
