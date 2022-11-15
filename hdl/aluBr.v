module aluBr (
    input [31:0] a, b,
    input [2:0] brFunc,
    output reg result
);
    parameter 
        Eq = 3'd0,
        Neq = 3'd1,
        Lt = 3'd2,
        Ltu = 3'd3,
        Ge = 3'd4,
        Geu = 3'd5,
        Dbr = 3'd6;
    

        
    always @(*) begin
        case(brFunc)
            Eq: result = (a == b);
            Neq: result = (a != b);
            Lt: result = $signed(a) < $signed(b);
            Ltu: result = (a < b);
            Ge: result = $signed(a) >= $signed(b);
            Geu: result = (a >= b);
            default: result = 0;
        endcase
    end

endmodule