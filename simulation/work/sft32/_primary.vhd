library verilog;
use verilog.vl_types.all;
entity sft32 is
    generic(
        LogicalRightShift: vl_logic_vector(0 to 1) := (Hi0, Hi0);
        ArithmeticRightShift: vl_logic_vector(0 to 1) := (Hi0, Hi1);
        LeftShift       : vl_logic_vector(0 to 1) := (Hi1, Hi0)
    );
    port(
        \in\            : in     vl_logic_vector(31 downto 0);
        sftSz           : in     vl_logic_vector(4 downto 0);
        shiftType       : in     vl_logic_vector(1 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of LogicalRightShift : constant is 1;
    attribute mti_svvh_generic_type of ArithmeticRightShift : constant is 1;
    attribute mti_svvh_generic_type of LeftShift : constant is 1;
end sft32;
