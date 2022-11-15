library verilog;
use verilog.vl_types.all;
entity cmp is
    port(
        a               : in     vl_logic;
        b               : in     vl_logic;
        eq              : in     vl_logic;
        lt              : in     vl_logic;
        eq_i            : out    vl_logic;
        lt_i            : out    vl_logic
    );
end cmp;
