`timescale 1ns / 1ps

module counter(
    input clk, reset, enable,
    output[7:0] count
);
    
    wire[7:0] Q;
    reg[7:0] Q_next;
       
    assign count = Q;
    
    always @ (*)
    begin
        case (enable)
            1'b1: Q_next = Q + 1;
            default:  Q_next = Q; 
        endcase
    end
    
    d_ff_reset DFF0 (.clk(clk), .reset(reset), .d(Q_next[0]), .q(Q[0]));
    d_ff_reset DFF1 (.clk(clk), .reset(reset), .d(Q_next[1]), .q(Q[1]));
    d_ff_reset DFF2 (.clk(clk), .reset(reset), .d(Q_next[2]), .q(Q[2]));
    d_ff_reset DFF3 (.clk(clk), .reset(reset), .d(Q_next[3]), .q(Q[3]));
    d_ff_reset DFF4 (.clk(clk), .reset(reset), .d(Q_next[4]), .q(Q[4]));
    d_ff_reset DFF5 (.clk(clk), .reset(reset), .d(Q_next[5]), .q(Q[5]));
    d_ff_reset DFF6 (.clk(clk), .reset(reset), .d(Q_next[6]), .q(Q[6]));
    d_ff_reset DFF7 (.clk(clk), .reset(reset), .d(Q_next[7]), .q(Q[7]));   

endmodule
