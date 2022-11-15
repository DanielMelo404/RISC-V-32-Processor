module Processor(
    // POR HACER
    input clk
);
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


    reg [31:0] pc = 0;

//-----------------------------LOAD INSTRUCTION FROM INSTRUCTIONMEMORY
    wire [31:0] inst; 

    MagicMemory #("memory.mif") instMem(
        //INPUT
        .addr(pc),
        //OUTPUT
        .read_data(inst)
        );

//--------------------------------------------------DECODE INSTRUCTION

    wire [3:0] iType_w;
    wire [3:0] aluFunc_w;
    wire [2:0] brFunc_w;
    wire [4:0] rdIndex_w;//maybe
    wire [4:0] R1Index_w;
    wire [4:0] R2Index_w;
    wire [31:0] immediate_w;
    wire werf_w;

    InstructionDecoder instDecoder(
        //INPUT
        .inst(inst), 
        //OUTPUTS
        .iType_out(iType_w),
        .aluFunc_out(aluFunc_w),
        .brFunc_out(brFunc_w),
        .rdIndex_out(rdIndex_w),//maybe
        .werf(werf_w),
        .R1Index_out(R1Index_w),
        .R2Index_out(R2Index_w),
        .immediate_out(immediate_w)
    );

//-----------------------------------LEER LOS VALORES DE LOS REGISTROS
    wire [31:0] RS1Val_w, RS2Val_w;
    wire [31:0] wdExec_w;
    wire [31:0] wd;

    RegisterFile rf(
        //INPUTS
        .clk(clk),
        .ra1(R1Index_w),
        .ra2(R2Index_w),
        .wa(rdIndex_w),
        .wd(wd),
        .werf(werf_w),
        //OUTPUTS
        .rd1(RS1Val_w),
        .rd2(RS2Val_w)
    );

//--------------------------------------------------EJECUTAR LA ACCION


    //wire [3:0] iType_w, esto tiene sentido?
    wire [4:0] rdIndex_ex_w;//maybe
    wire [31:0] addr_w;//para qe es esto?
    wire [31:0] nextPc_w;

    InstructionExecuter exec(
        //Decoded instruction
        //INPUTS
        .iType(iType_w),
        .aluFunc(aluFunc_w), 
        .brFunc(brFunc_w),
        .werf(werf_w),
        .rdIndex(rdIndex_w),
        .R1Index(R1Index_w),
        .R2Index(R2Index_w),
        .immediate(immediate_w),
        .RS1Val(RS1Val_w), .RS2Val(RS2Val_w), // Read values in RS1 and RS2 from register file
        .pc(pc),
    //ExecInst type in bsv doc
        .iType_out(),//tiene sentido si ya hay otro iType del decoder?
        //OUTPUTS
        .werf_out(),
        .rdIndex_out(rdIndex_ex_w),//maybe
        .data_out(wdExec_w),
        .addr_out(addr_w),
        .nextPc_out(nextPc_w)
    );

//------------------------------------------- LOAD AND STORE IF NEEDED
    
    wire [31:0] wdDMem_w;

    MagicMemory dMem(
        //INPUTS
        .clk(clk),
        .addr(addr_w),
        .write_data(wdExec_w),//revisar que aqui si valla wdExec_w
        .weMem(weDMem),
        //OUTPUTS
        .read_data(wdDMem_w)
    );

    assign wd = (iType_w == LOAD) ? wdDMem_w : wdExec_w;
    assign weDMem = (iType_w == STORE);


//--------------------------------UPDATE PROGRAM COUNTER
    always @(posedge clk) begin
        pc <= nextPc_w;
    end

//----------------------------------------DEBUGING CODE
    // always @ * begin
    //     if(iType_w == Unsupported) begin
    //         $display("Reached unsuported instruction");
    //         $strobe(inst);
    //         $strobe("At pc:", pc);
    //         $finish;
    //     end
    // end

endmodule