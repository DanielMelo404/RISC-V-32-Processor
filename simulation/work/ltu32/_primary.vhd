library verilog;
use verilog.vl_types.all;
entity ltu32 is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        ltout           : out    vl_logic
    );
end ltu32;
