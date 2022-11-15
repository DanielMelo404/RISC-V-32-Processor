library verilog;
use verilog.vl_types.all;
entity carrySelectAdder is
    generic(
        n               : integer := 8
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        cin             : in     vl_logic;
        sum             : out    vl_logic_vector;
        cout            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 1;
end carrySelectAdder;
