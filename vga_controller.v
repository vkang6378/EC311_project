`timescale 1ns / 1ps

module vga_controller(
    input clk,
    input reset,
    input [3:0] move_dir, 
    output reg h_sync,
    output reg v_sync,
    output reg [2:0] color 
);

    // VGA Parameters
    localparam TOTAL_WIDTH = 800;
    localparam TOTAL_HEIGHT = 525;
    localparam ACTIVE_WIDTH = 640;
    localparam ACTIVE_HEIGHT = 480;
    localparam H_SYNC_COLUMN = 704;
    localparam V_SYNC_LINE = 523;
    localparam x_offset = 50;
    localparam y_offset = 33;
    localparam cell_size = 10;

    reg [11:0] widthPos = 0;
    reg [11:0] heightPos = 0;

    // enable display
    wire enable = ((widthPos >= x_offset && widthPos < (ACTIVE_WIDTH + x_offset)) &&
                   (heightPos >= y_offset && heightPos < (y_offset + ACTIVE_HEIGHT))) ? 1'b1 : 1'b0;

    // check for snake 
    wire snake_head, snake_body;
    reg [7:0] snake_length = 5; // Initial snake length
    snake_controller snake(
        snake_head,
        snake_body,
        clk,
        clk,
        ~reset,
        widthPos,
        heightPos,
        move_dir,
        reset,
        snake_length,
        cell_size
    );

    // check for apple 
    wire apple;
    reg score_increment;
    apple apple_inst(
        clk,
        widthPos,
        heightPos,
        ~reset,
        apple,
        score_increment
    );

    // check for score
    reg [7:0] score = 0;
    score_tracker score_uut(
        clk,
        score_increment,
        score
    );

    // check display score 
    wire [2:0] score_color;
    displayScore display_score(
        clk,
        score,
        widthPos,
        heightPos,
        score_color
    );

    // Collision module connections
    wire [1:0] collision_state;
    snake_collision collision_uut(
        collision_state,
        clk,
        ~reset,
        reset,
        ~enable,
        snake_head,
        snake_body,
        apple,
        1'b1 
    );

   
    always @(posedge clk) begin
        if (reset) begin
            color <= 3'b000; 
        end else if (enable) begin
            if (snake_head) begin
                color <= 3'b010; 
            end else if (snake_body) begin
                color <= 3'b011; 
            end else if (apple) begin
                color <= 3'b100; 
            end else begin
                color <= score_color; 
            end
        end else begin
            color <= 3'b000; 
        end
    end

    always @(posedge clk) begin
        if (widthPos < TOTAL_WIDTH - 1) begin
            widthPos <= widthPos + 1;
        end else begin
            widthPos <= 0;
            if (heightPos < TOTAL_HEIGHT - 1) begin
                heightPos <= heightPos + 1;
            end else begin
                heightPos <= 0;
            end
        end
    end

    always @(posedge clk) begin
        h_sync <= (widthPos < H_SYNC_COLUMN) ? 1'b1 : 1'b0;
    end

    always @(posedge clk) begin
        v_sync <= (heightPos < V_SYNC_LINE) ? 1'b1 : 1'b0;
    end

endmodule
