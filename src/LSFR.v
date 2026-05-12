`timescale 1ns / 1ps

module LFSR
//tap length: 22
//feedback logic: xor
//25, hex (37 -> board number)
//2D, hex (45 -> last two digits of student number)
#(parameter seed = 22'h25 ^ 22'h2D)
//#(parameter seed = 2'h00) //forbidden seed
(
    input clk, sh_en, rst_n,
    output max_tick_reg,
    output[21:0] Q_out
);

reg[21:0] Q_state;
reg mtr;
wire[21:0] Q_ns;
wire Q_fb;

always @ (posedge clk or posedge rst_n) begin //for asynchronous active-high reset
    mtr <= 1'b0;
    if(rst_n) begin
        Q_state <= seed;
    end
    else begin
        if (sh_en)
            Q_state <= Q_ns;
        if (Q_out == seed) //when Q_out equals the seed we know all combinations have been used
            mtr <= 1'b1; 
    end
end

//optimal taps for a 22-bit number
assign Q_fb = Q_state[21] ^ Q_state[20];
assign Q_ns = {Q_state[20:0], Q_fb};

assign Q_out = Q_state;
assign max_tick_reg = mtr;

endmodule
