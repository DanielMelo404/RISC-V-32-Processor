module InstructionDecoder(
    input [31:0] inst,
    
    output reg [3:0] iType_out,
    output reg [3:0] aluFunc_out,
    output reg [2:0] brFunc_out,
    output reg [4:0] rdIndex_out,
    output reg werf,
    output reg [4:0] R1Index_out,
    output reg [4:0] R2Index_out,
    output reg [31:0] immediate_out
);

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
    parameter  [3:0]
        Add = 4'd0,
        Sub = 4'd1,
        And = 4'd2,
        Or = 4'd3,
        Xor = 4'd4,
        Slt = 4'd5,
        Sltu = 4'd6,
        Sll = 4'd7,
        Srl = 4'd8,
        Sra = 4'd9,
        aluD = 4'd0;
//BrFunc
    parameter 
        Eq = 3'd0,
        Neq = 3'd1,
        Lt = 3'd2,
        Ltu = 3'd3,
        Ge = 3'd4,
        Geu = 3'd5,
        Dbr = 3'd6;



    //cables que se conectan directamente desde la instruccion de 
    //la entrada

    wire [6:0] opcode = inst[6:0];
    wire [14:12] funct3 = inst[14:12];
    wire [6:0] funct7 = inst[31:25];
    wire [6:0] rd = inst[11:7];
    wire [6:0] rs1 = inst[19:15];
    wire [6:0] rs2 = inst[24:20];



    wire [31:0] immD32 = 32'b0; //D means default value
    //La inmediata para BRANCH tiene que ser un multiplo de 4
    wire [11:0] immB = {inst[31], inst[7], inst[30:25], inst[11:8]};
    wire [31:0] immB32 = {{19{immB[11]}}, immB, 1'b0};
    wire [19:0] immU = {inst[31:12]};
    wire [31:0] immU32 = {inst[31:12], {12{1'b0}}};
    wire [11:0] immI = {inst[31:20]};
    wire [31:0] immI32 = {{20{immI[11]}}, immI};
    wire [19:0] immJ = {inst[31], inst[19:12], inst[20],  inst[30:21]};
    wire [31:0] immJ32 = {{11{immJ[19]}}, immJ, 1'b0};
    wire [19:0] immS = {inst[31:25], inst[11:7]};
    wire [31:0] immS32 = {{12{immS[19]}}, immS}; 

    wire [4:0] dSrc = 0;
    wire werfD = 0;
    wire [4:0] rdIndexD  = 0;
   

    always @(*) begin
        case (opcode)

            opOp: begin
                iType_out = OP;

                case (funct3)
                    fnADD: aluFunc_out = (funct7 == 0) ? Add : Sub;
                    fnSLL: aluFunc_out = Sll;
                    fnSLT: aluFunc_out = Slt;
                    fnSLTU: aluFunc_out = Sltu;
                    fnXOR: aluFunc_out = Xor;
                    fnSR: aluFunc_out = (funct7 == 0) ? Srl : Sra;
                    fnOR: aluFunc_out = Or;
                    fnAND: aluFunc_out = And;
                endcase
                
                brFunc_out = Dbr;// not used
                rdIndex_out = rd;
                werf = 1;
                R1Index_out = rs1;
                R2Index_out = rs2;
                immediate_out = aluD; //not used
            end

            opAuipc: begin
                iType_out = AUIPC;
                aluFunc_out = aluD; //not used
                brFunc_out = Dbr; //not used
                rdIndex_out = rd; 
                werf = 1;
                R1Index_out = dSrc; //not used
                R2Index_out = dSrc;
                immediate_out = immU32;
            end

            opLui: begin 
                iType_out = LUI;
                aluFunc_out = aluD; //not used
                brFunc_out = Dbr;
                rdIndex_out = rd;
                werf = 1;
                R1Index_out = dSrc;
                R2Index_out = dSrc;
                immediate_out = immU32;
            
            end

            opOpImm: begin
                iType_out = OPIMM;
                case (funct3)
                    fnAND : aluFunc_out = And;
                    fnOR : aluFunc_out = Or;
                    fnXOR : aluFunc_out = Xor;
                    fnADD : aluFunc_out = Add;
                    fnSLT : aluFunc_out = Slt;
                    fnSLTU : aluFunc_out = Sltu;
                    fnSLL : begin
                        aluFunc_out = Sll;
                        case(funct7)
                            7'b0000000: aluFunc_out = Sll;
                            default : begin
                                aluFunc_out = aluD;
                                iType_out = Unsupported;//sino, la funcion es invalida
                            end
                        endcase
                    end
                    fnSR : case (funct7) 
                        7'b0000000: aluFunc_out = Srl;
                        7'b0100000: aluFunc_out = Sra;
                        default : begin
                            aluFunc_out = aluD;
                            iType_out = Unsupported;//sino, la funcion es invalida
                        end
                    endcase
                    default : aluFunc_out = aluD;
                endcase
                brFunc_out = Dbr;
                rdIndex_out = rd; 
                werf = 1;
                R1Index_out = rs1;
                R2Index_out = dSrc;
                immediate_out = immI32;

            end

            opBranch:begin
                iType_out = BRANCH;
                aluFunc_out = Add; //not used
                case (funct3)
                    fnBEQ: brFunc_out = Eq;
                    fnBNE: brFunc_out = Neq;
                    fnBLT: brFunc_out = Lt;
                    fnBGE: brFunc_out = Ge;
                    fnBLTU: brFunc_out = Ltu;
                    fnBGEU: brFunc_out = Geu;
                    default: begin
                        brFunc_out = Dbr;
                        iType_out = Unsupported;
                    end
                endcase
                rdIndex_out = rdIndexD;
                werf = werfD;
                R1Index_out = rs1;
                R2Index_out = rs2;
                immediate_out = immB32;
            
            end 

            opJal: begin
                iType_out = JAL;
                aluFunc_out = aluD; //not used
                brFunc_out = Dbr; //not used
                rdIndex_out = rd; 
                werf = 1;
                R1Index_out = dSrc;
                R2Index_out = dSrc;
                immediate_out = immJ32;
            
            end

            opLoad: begin
                iType_out = LOAD;
                aluFunc_out = Add; //not used
                brFunc_out = Dbr; //not used
                rdIndex_out = rd;
                werf = 1;
                R1Index_out = rs1;
                R2Index_out = dSrc; //not used
                immediate_out = immI32;
            end

            opStore: begin
                iType_out = STORE;
                aluFunc_out = Add; //not used
                brFunc_out = Dbr; //not used
                rdIndex_out = rdIndexD; 
                werf = werfD;
                R1Index_out = rs1;
                R2Index_out = rs2;
                immediate_out = immS32;
            
            end

            opJalr: begin 
                iType_out = JALR;
                aluFunc_out = aluD; //not used
                brFunc_out = Dbr;
                rdIndex_out = rd;
                werf = 1;
                R1Index_out = rs1;
                R2Index_out = dSrc;
                immediate_out = immI32;
            end
            default begin
                iType_out = Unsupported;
                aluFunc_out = aluD; //not used
                brFunc_out = Dbr;
                rdIndex_out = dSrc;
                werf = werfD;
                R1Index_out = dSrc;
                R2Index_out = dSrc;
                immediate_out = immD32;

            end
        endcase
    end
    
endmodule

