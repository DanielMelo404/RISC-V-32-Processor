library verilog;
use verilog.vl_types.all;
entity Processor is
    generic(
        OP              : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi0, Hi0);
        OPIMM           : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi0, Hi1);
        BRANCH          : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi1, Hi0);
        LUI             : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi1, Hi1);
        JAL             : vl_logic_vector(3 downto 0) := (Hi0, Hi1, Hi0, Hi0);
        JALR            : vl_logic_vector(3 downto 0) := (Hi0, Hi1, Hi0, Hi1);
        LOAD            : vl_logic_vector(3 downto 0) := (Hi0, Hi1, Hi1, Hi0);
        STORE           : vl_logic_vector(3 downto 0) := (Hi0, Hi1, Hi1, Hi1);
        AUIPC           : vl_logic_vector(3 downto 0) := (Hi1, Hi0, Hi0, Hi0);
        Unsupported     : vl_logic_vector(3 downto 0) := (Hi1, Hi0, Hi0, Hi1)
    );
    port(
        clk             : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of OP : constant is 2;
    attribute mti_svvh_generic_type of OPIMM : constant is 2;
    attribute mti_svvh_generic_type of BRANCH : constant is 2;
    attribute mti_svvh_generic_type of LUI : constant is 2;
    attribute mti_svvh_generic_type of JAL : constant is 2;
    attribute mti_svvh_generic_type of JALR : constant is 2;
    attribute mti_svvh_generic_type of LOAD : constant is 2;
    attribute mti_svvh_generic_type of STORE : constant is 2;
    attribute mti_svvh_generic_type of AUIPC : constant is 2;
    attribute mti_svvh_generic_type of Unsupported : constant is 2;
end Processor;
