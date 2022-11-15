module InstructionExecuter(
    //Decoded instruction
    input [3:0] iType,
    input [3:0] aluFunc,
    input [2:0] brFunc,
    input werf,
    input [4:0] rdIndex,
    input [4:0] R1Index,
    input [4:0] R2Index,
    input [31:0] immediate,


    input [31:0] RS1Val, RS2Val, // Read values in RS1 and RS2 from register file
    input [31:0] pc,

//ExecInst type in bsv doc
    output [3:0] iType_out,
    output werf_out,
    output [4:0] rdIndex_out,
    output reg [31:0] data_out,
    output [31:0] addr_out,
    output reg [31:0] nextPc_out
);


    reg addr = 0;


//opcode
    parameter   [6:0]
        opOpImm = 7'b0010011,
        opOp = 7'b0110011,
        opLui = 7'b0110111,
        opJal = 7'b1101111,
        opJalr = 7'b1100111,
        opBranch = 7'b1100011,
        opLoad = 7'b0000011,
        opStore = 7'b0100011,
        opAuipc = 7'b0010111;
// funct3 - ALU
    parameter [2:0]
        fnADD = 3'b000,
        fnSLL = 3'b001,
        fnSLT = 3'b010,
        fnSLTU = 3'b011,
        fnXOR = 3'b100,
        fnSR = 3'b101,
        fnOR = 3'b110,
        fnAND = 3'b111;

    // funct3 - Branch
    parameter [2:0]
        fnBEQ = 3'b000,
        fnBNE = 3'b001,
        fnBLT = 3'b100,
        fnBGE = 3'b101,
        fnBLTU = 3'b110,
        fnBGEU = 3'b111;
        
// funct3 - Load
    parameter [2:0]
        fnLW = 3'b010,
        fnLB = 3'b000,
        fnLH = 3'b001,
        fnLBU = 3'b100,
        fnLHU = 3'b101;

// funct3 - Store
    parameter [2:0]
        fnSW = 3'b010,
        fnSB = 3'b000,
        fnSH = 3'b001;

// funct3 - JALR
    parameter [2:0]
        fnJALR = 3'b000;

// instruciton types (IType)
    parameter [3:0] 
        OP = 4'd0,
        OPIMM = 4'd1,
        BRANCH = 4'd2,
        LUI = 4'd3,
        JAL = 4'd4,
        JALR = 4'd5,
        LOAD = 4'd6,
        STORE = 4'd7,
        AUIPC = 4'd8,
        Unsupported = 4'd9;

// aluFunc
    parameter   
        Add = 4'b0000,
        Sub = 4'b0001 ,
        And = 4'b0010,
        Or = 4'b0011,
        Xor = 4'b0100,
        Slt = 4'b0101,
        Sltu = 4'b0110,
        Sll = 4'b0111,
        Srl = 4'b1000,
        Sra = 4'b1001;

    //Default values



    wire aluVal2 = (iType == OPIMM) ? immediate : RS2Val;
    reg [31:0] a_w, b_w;
    wire [31:0] alu_out;


    alu aluMod(
        //INPUTS
        .a(a_w),
        .b(b_w), 
        .func(aluFunc),
        //OTUPUT
        .out(alu_out)
    );


    aluBr aludBrMod(
        //INPUTS
        .a(RS1Val),
        .b(RS2Val),
        .brFunc(brFunc),
        //OUTPUTS
        .result(aluBr_out)
    );
    
    always @(*) begin
        case (iType)
            AUIPC: data_out = pc + immediate;
            LUI: data_out = immediate; 
            OP, OPIMM: data_out = alu_out;  
            JAL, JALR: data_out = pc + 4; 
            STORE: data_out = RS2Val; 
            default: data_out = 0;
        endcase 

        case (iType)
            BRANCH: nextPc_out = aluBr_out ? alu_out : pc + 4 ; //  Replace 0 with the correct expression
            JAL: nextPc_out = immediate; // O Replace 0 with the correct expression
            JALR: nextPc_out =  (RS1Val + immediate) & ~1; // "& ~1" clears the bottom bit.
            default: nextPc_out = pc + 4;
        endcase

        case (iType)
            OP: begin
                a_w = RS1Val;
                b_w = RS2Val;
            end

            BRANCH: begin
                a_w = pc;
                b_w = immediate;
            end

            OPIMM, LOAD, STORE, JALR, JAL: begin //Para JAL, en este caso address es absoulta, pero se utiliza esto porque RS!Val es 0
                a_w = RS1Val;
                b_w = immediate; 
            end
            default: begin
                a_w = RS1Val;
                b_w = RS2Val;
            end

        endcase
    end     
       
        assign addr_out = alu_out; //FOR LOAD AND STORE

        assign rdIndex_out = rdIndex;
        assign werf_out = werf;

endmodule