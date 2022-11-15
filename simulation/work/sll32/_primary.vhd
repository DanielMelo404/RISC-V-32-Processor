library verilog;
use verilog.vl_types.all;
entity sll32 is
    port(
        \in\            : in     vl_logic_vector(31 downto 0);
        sftSz           : in     vl_logic_vector(4 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end sll32;
