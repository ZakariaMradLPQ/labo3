LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY signalProcessing IS
    GENERIC (
        IN_SIZE : INTEGER := 7;
        OUT_SIZE : INTEGER := 15
    );
    PORT (
        A : IN STD_LOGIC_VECTOR(IN_SIZE DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(IN_SIZE DOWNTO 0);
        ACTIVATION : IN STD_LOGIC;
        OP : IN STD_LOGIC;
        S : OUT STD_LOGIC_VECTOR(OUT_SIZE DOWNTO 0)
    );
END signalProcessing;
ARCHITECTURE Behavioral OF signalProcessing IS
    -- Define the sum and mul signals with appropriate widths
    SIGNAL sum : unsigned(IN_SIZE DOWNTO 0);  -- 8 bits for the sum
    SIGNAL mul : unsigned(2 * (IN_SIZE + 1) - 1 DOWNTO 0);  -- 16 bits for the product (enough for 2 * (IN_SIZE + 1))

    SIGNAL OPOut : STD_LOGIC_VECTOR(OUT_SIZE DOWNTO 0);
    SIGNAL zero_vector : STD_LOGIC_VECTOR(OUT_SIZE DOWNTO 0) := (OTHERS => '0');

    COMPONENT mux2to1 IS
        GENERIC (
            WIDTH : INTEGER := 1
        );
        PORT (
            A : IN STD_LOGIC_VECTOR(WIDTH DOWNTO 0);
            B : IN STD_LOGIC_VECTOR(WIDTH DOWNTO 0);
            Sel : IN STD_LOGIC;
            Y : OUT STD_LOGIC_VECTOR(WIDTH DOWNTO 0)
        );
    END COMPONENT;

    -- Signals for resized sum and mul
    SIGNAL sum_resized : STD_LOGIC_VECTOR(OUT_SIZE DOWNTO 0);  -- resized sum
    SIGNAL mul_resized : STD_LOGIC_VECTOR(OUT_SIZE DOWNTO 0);  -- resized mul

BEGIN

    -- Process to compute sum and mul
    PROCESS (A, B, ACTIVATION, OP)
    BEGIN
        sum <= unsigned(A) + unsigned(B);  -- sum of A and B
        mul <= unsigned(A) * unsigned(B);  -- product of A and B
    END PROCESS;

    -- Resize sum and mul to match OUT_SIZE, ensuring correct bit width
    sum_resized <= std_logic_vector(resize(sum, OUT_SIZE + 1));  -- Convert to std_logic_vector and resize
    mul_resized <= std_logic_vector(resize(mul, OUT_SIZE + 1));  -- Convert to std_logic_vector and resize

    -- U1: First Mux, sum and mul are passed in and selected by OP
    U1 : mux2to1
    GENERIC MAP(
        WIDTH => OUT_SIZE
    )
    PORT MAP(
        A => sum_resized,  -- Use resized sum
        B => mul_resized,  -- Use resized mul
        Sel => OP,
        Y => OPOut
    );

    -- U2: Second Mux, passing zero_vector or OPOut to S
    U2 : mux2to1
    GENERIC MAP(
        WIDTH => OUT_SIZE
    )
    PORT MAP(
        A => zero_vector,
        B => OPOut,
        Sel => ACTIVATION,
        Y => S  -- S now has the width of OUT_SIZE
    );

END Behavioral;
