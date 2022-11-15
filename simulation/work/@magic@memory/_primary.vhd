library verilog;
use verilog.vl_types.all;
entity MagicMemory is
    generic(
        memFile         : string  := "memory.mif"
    );
    port(
        clk             : in     vl_logic;
        addr            : in     vl_logic_vector(31 downto 0);
        write_data      : in     vl_logic_vector(31 downto 0);
        weMem           : in     vl_logic;
        read_data       : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of memFile : constant is 1;
end MagicMemory;
