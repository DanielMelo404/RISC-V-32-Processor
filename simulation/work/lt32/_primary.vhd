library verilog;
use verilog.vl_types.all;
entity lt32 is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        isSigned        : in     vl_logic;
        \out\           : out    vl_logic
    );
end lt32;
