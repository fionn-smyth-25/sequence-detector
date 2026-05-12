`timescale 1ns / 1ps

module FSM(
    input clk,
    input rst,
    input x,
    output reg y
);

    //state encoding
    parameter A = 3'b000, //no match
              B = 3'b001, //0
              C = 3'b010, //01
              D = 3'b011, //010
              E = 3'b100, //0101
              F = 3'b101, //01011
              G = 3'b110; //010110 
              
    reg [2:0] s, ns;

    //on each clk edge state is update
    always @(posedge clk) begin
        if (rst)
            s <= A; //rset to a
        else
            s <= ns; //otherwise load next state
    end

    //next state
    always @(*) begin
        case (s)
            A: ns = (x == 0) ? B : A; 
            B: ns = (x == 0) ? B : C; 
            C: ns = (x == 0) ? D : A; 
            D: ns = (x == 0) ? B : E; 
            E: ns = (x == 0) ? D : F; 
            F: ns = (x == 0) ? G : A; 
            G: ns = (x == 0) ? B : C; 
            default: ns = A;
        endcase
    end

    //output logic
    always @(*) begin
        case (s)
            G: y = 1'b1;  //detection state (g)
            default: y = 1'b0;
        endcase
    end

endmodule
