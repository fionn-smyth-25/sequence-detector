`timescale 1ns / 1ps

module fsm_tb();
    reg clk, reset_test, test_in;
    wire test_out;
    
    parameter T = 2; //clock period of 1ns
    
    FSM uut (.clk(clk), .rst(reset_test), .x(test_in), .y(test_out));
              
    always 
    begin 
        clk = 1'b1;
        #(T/2);
        clk = 1'b0;
        #(T/2);
    end
    
    //reset high for 1 clock cycles
    //then test 010110
    initial
    begin
        reset_test = 1'b1;
        test_in = 1'b0;
        #(T);

        reset_test = 1'b0;

        //sequence 010110
        test_in = 1'b0; #(T);
        test_in = 1'b1; #(T);
        test_in = 1'b0; #(T);
        test_in = 1'b1; #(T);
        test_in = 1'b1; #(T);
        test_in = 1'b0; #(T);

        #(2*T);
        $finish;
    end    
endmodule
