library verilog;
use verilog.vl_types.all;
entity alu is
    generic(
        Add             : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi0);
        Sub             : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi1);
        \And\           : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi0);
        \Or\            : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi1);
        \Xor\           : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi0);
        Slt             : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi1);
        Sltu            : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi0);
        \Sll\           : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi1);
        \Srl\           : vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi0, Hi0);
        \Sra\           : vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi0, Hi1);
        LogicalRightShift: vl_logic_vector(0 to 1) := (Hi0, Hi0);
        ArithmeticRightShift: vl_logic_vector(0 to 1) := (Hi0, Hi1);
        LeftShift       : vl_logic_vector(0 to 1) := (Hi1, Hi0)
    );
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        func            : in     vl_logic_vector(3 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of Add : constant is 1;
    attribute mti_svvh_generic_type of Sub : constant is 1;
    attribute mti_svvh_generic_type of \And\ : constant is 1;
    attribute mti_svvh_generic_type of \Or\ : constant is 1;
    attribute mti_svvh_generic_type of \Xor\ : constant is 1;
    attribute mti_svvh_generic_type of Slt : constant is 1;
    attribute mti_svvh_generic_type of Sltu : constant is 1;
    attribute mti_svvh_generic_type of \Sll\ : constant is 1;
    attribute mti_svvh_generic_type of \Srl\ : constant is 1;
    attribute mti_svvh_generic_type of \Sra\ : constant is 1;
    attribute mti_svvh_generic_type of LogicalRightShift : constant is 1;
    attribute mti_svvh_generic_type of ArithmeticRightShift : constant is 1;
    attribute mti_svvh_generic_type of LeftShift : constant is 1;
end alu;
