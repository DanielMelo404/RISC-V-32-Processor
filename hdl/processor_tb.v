module processor_tb;

    reg clk;

    Processor uut(.clk(clk));

    always #10 clk = ~clk;

    initial begin

        clk <= 0;
        
        #1000 $stop;

    
    end

endmodule