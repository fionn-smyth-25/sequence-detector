`timescale 1ns / 1ps

module sqnce_detctr_tb();
    reg clk, reset_test;
    wire[7:0] test_out;
    
    parameter T = 2; //clock period of 1ns
    
    top uut (.CCLK(clk), .reset(reset_test), .count(test_out));
              
    always 
    begin 
        clk = 1'b1;
        #(T/2);
        clk = 1'b0;
        #(T/2);
    end
    
    //reset high for 1 clock cycles
    initial
    begin
        reset_test = 1'b1;
        #(T);
        reset_test = 1'b0;;
    end    
    
    always @(posedge clk) begin
    if (uut.e2.y) begin
        $display("Time=%0t DETECTED sequence = %b", 
                  $time, uut.lfsr_reg);
    end
    end
endmodule
