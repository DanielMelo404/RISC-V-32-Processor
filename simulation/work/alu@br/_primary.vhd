library verilog;
use verilog.vl_types.all;
entity aluBr is
    generic(
        Eq              : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi0);
        Neq             : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi1);
        Lt              : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi0);
        Ltu             : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi1);
        Ge              : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi0);
        Geu             : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi1);
        Dbr             : vl_logic_vector(0 to 2) := (Hi1, Hi1, Hi0)
    );
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        brFunc          : in     vl_logic_vector(2 downto 0);
        result          : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of Eq : constant is 1;
    attribute mti_svvh_generic_type of Neq : constant is 1;
    attribute mti_svvh_generic_type of Lt : constant is 1;
    attribute mti_svvh_generic_type of Ltu : constant is 1;
    attribute mti_svvh_generic_type of Ge : constant is 1;
    attribute mti_svvh_generic_type of Geu : constant is 1;
    attribute mti_svvh_generic_type of Dbr : constant is 1;
end aluBr;
