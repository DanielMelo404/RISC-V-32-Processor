module RegisterFile(
    input clk,
    input [4:0] ra1, ra2, wa,//maybe
    input [31:0] wd,// maybe 
    input werf,//write enable
    output [31:0] rd1, rd2
);

   reg [31:0] registers [31:0];
   integer i;
//   initial begin
//       registers[0] = 0;
//       for (i = 1 ; i < 32; i = i+1) begin COMENTADO PARA PODER HACER SINTESIS, SACA EERROR
//            registers[i] = {$random}%10;
//       end
//
//   end

//-------------------------------------------READ CONTENT OF REGISTERS
   
    assign  rd1 = (ra1 == 5'd0) ? 32'd0 : registers[ra1];
    assign  rd2 = (ra2 == 5'd0) ? 32'd0 : registers[ra2];

    
//--------------------------------------------WRITE TO CHOSEN REGISTER

   always @ (posedge clk) 
       if (werf) registers[wa] <= wd;

endmodule