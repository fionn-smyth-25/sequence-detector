`timescale 1ns / 1ps

module top
(
    input CCLK, reset,
    output[6:0] led_out,
//    output[7:0] count, enable for test bench
    output[3:0] anode_sel
    
);
    
    wire g0, g1;
    wire[21:0] lfsr_reg;
    wire[7:0] count; //enable this for board target
    
  seven_segment_controller e4 (.clk(CCLK), .reset(reset), .temp(count), .anode_select(anode_sel), .LED_out(led_out));
    
  clock e0 (.CCLK(CCLK), .clkscale(50000), .clk(g0)); //enable this for target to board
//    assign g0 = CCLK; //enable this for testbench
    
    //not specified so enable always on
    //dont care about max tick
    LFSR e1 (.clk(g0), .sh_en(1'b1), .rst_n(reset),
              .Q_out(lfsr_reg), .max_tick_reg());
    
    //send LSB of the codeword to the FSM          
    FSM e2 (.clk(g0), .rst(reset), .x(lfsr_reg[0]), .y(g1));
    
    //count
    counter e3 (.clk(g0), .reset(reset), .enable(g1), .count(count));
     
endmodule
