library verilog;
use verilog.vl_types.all;
entity barrelRShift is
    port(
        \in\            : in     vl_logic_vector(31 downto 0);
        sftSz           : in     vl_logic_vector(4 downto 0);
        sft_in          : in     vl_logic;
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end barrelRShift;
