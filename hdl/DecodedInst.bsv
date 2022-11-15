function DecodedInst decode(Bit#(32) inst);
 let opcode = inst[6:0];
 let funct3 = inst[14:12];
 let funct7 = inst[31:25];
 let dst = inst[11:7];
 let src1 = inst[19:15];
 let src2 = inst[24:20];
 Maybe#(RIndx) validDst = Valid(dst);
 Maybe#(RIndx) dDst = Invalid; // default value
 RIndx dSrc = 5'b0;
 // DEFAULT VALUES - Use the following for your default values:
 // dst: dDst, src1: dSrc, src2: dSrc, imm: immD, BrFunc: Dbr, AluFunc: ?
 // We have provided a default value and done immB for you.
 Word immD32 = signExtend(1'b0); // default value
 Bit#(12) immB = { inst[31], inst[7], inst[30:25], inst[11:8] };
 Word immB32 = signExtend({immB, 1’b0});
 Bit#(20) immU = 0; // TODO
 Word immU32 = 0; // TODO
 Bit#(12) immI = 0; // TODO
 Word immI32 = 0; // TODO
 Bit#(20) immJ = 0; // TODO
 Word immJ32 = 0; // TODO
 Bit#(12) immS = 0; // TODO
 Word immS32 = 0; // TODO
 DecodedInst dInst = unpack(0);
 dInst.iType = Unsupported; // unsupported by default
 case (opcode)
 opAuipc: begin
 dInst = DecodedInst {
 iType: AUIPC,
 dst: validDst,
 src1: dSrc,
 src2: dSrc,
 imm: immU32,
 brFunc: Dbr,
 aluFunc: ?
 };
 end
 opLui: // TODO
 
6.004 Worksheet - 6 of 16 - L13 – RISC-V Processor
Decode (continued)
 opOpImm: begin
 dInst.iType = OPIMM;
 dInst.src1 = src1;
 dInst.imm = immI32;
 dInst.dst = validDst;
 case (funct3)
 fnAND : dInst.aluFunc = And; // Decode ANDI instructions
 fnOR : dInst.iType = Unsupported; // TODO
 fnXOR : dInst.iType = Unsupported; // TODO
 fnADD : dInst.iType = Unsupported; // TODO
 fnSLT : dInst.iType = Unsupported; // TODO
 fnSLTU: dInst.iType = Unsupported; // TODO
 fnSLL : case (funct7)
 7'b0000000: dInst.aluFunc = Sll;
// Otherwise we must say the instruction is invalid:
default: dInst.iType = Unsupported;
 endcase
 fnSR : // TODO
 dInst.iType = Unsupported;
default: dInst.iType = Unsupported;
 endcase
 end
 opOp: // TODO
 opBranch: // TODO
 opJal: // TODO
 opLoad: // TODO
 opStore: // TODO
 opJalr: // TODO
 endcase
 return dInst;
endfunction