`timescale 1ns / 1ps

module LFSR_TB;
    reg clk, enable_test, reset_test;
    wire mtr;
    wire[7:0] test_out;
    
    parameter T = 2; //clock period of 1ns
    
    LFSR uut (.clk(clk), .sh_en(enable_test), .rst_n(reset_test),
              .Q_out(test_out), .max_tick_reg(mtr));
              
    always 
    begin 
        clk = 1'b1;
        #(T/2);
        clk = 1'b0;
        #(T/2);
    end
    
    //reset high for 20 clock cycles
    //enable always high
    initial
    begin
        reset_test = 1'b1;
        enable_test = 1'b1;
        #(20*T);
        reset_test = 1'b0;;
    end     
    
endmodule