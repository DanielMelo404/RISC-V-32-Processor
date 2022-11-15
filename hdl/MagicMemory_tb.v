module MagicMemory_tb;
    reg clk;
    reg [31:0] addr, write_data;
    reg weMem;
    wire [31:0] read_data;

    MagicMemory memory(
        //INPUTS
        .clk(clk),
        .addr(addr),
        .write_data(write_data),
        .weMem(weMem),
        //OUTPUT
        .read_data(read_data)
    );

    always #10 clk = ~clk;

    initial begin

        {clk, write_data, weMem} <= 0;

        #10

        //Testing read

        #10
        @ (posedge clk) addr <= 32'd0;
        @ (posedge clk) addr <= 32'd4;
        @ (posedge clk) addr <= 32'd8;
        @ (posedge clk) addr <= 32'd12;

        // //Testing writes

        #10 @ (posedge clk) weMem <= 1;
        
        @ (posedge clk) begin 
            addr <= 32'd0;
            write_data <= 32'hf1f1f1f1;
        end
        
        @ (posedge clk) begin 
            addr <= 32'd4;
            write_data <= 32'hf2f2f2f2;
        end

        @ (posedge clk) addr <= 32'd8;
        @ (posedge clk) addr <= 32'd12;

        #1000 $stop;
        #10 $finish;
    end



endmodule