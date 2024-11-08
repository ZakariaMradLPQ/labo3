LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY tb_signalProcessing IS
END tb_signalProcessing;

ARCHITECTURE behavior OF tb_signalProcessing IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT signalProcessing
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
    END COMPONENT;

    -- Signals for the UUT
    SIGNAL A : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
    SIGNAL B : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
    SIGNAL ACTIVATION : STD_LOGIC := '0';
    SIGNAL OP : STD_LOGIC := '0';
    SIGNAL S : STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: signalProcessing
        GENERIC MAP (
            IN_SIZE => 7,
            OUT_SIZE => 15
        )
        PORT MAP (
            A => A,
            B => B,
            ACTIVATION => ACTIVATION,
            OP => OP,
            S => S
        );

    -- Stimulus process
    stim_proc: PROCESS
    BEGIN
        -- Test case 1: A + B, OP = '0', ACTIVATION = '0'
        A <= std_logic_vector(to_unsigned(10, 8));
        B <= std_logic_vector(to_unsigned(20, 8));
        OP <= '0';
        ACTIVATION <= '0';
        WAIT FOR 10 ns;

        -- Test case 2: A * B, OP = '1', ACTIVATION = '0'
        OP <= '1';
        WAIT FOR 10 ns;

        -- Test case 3: A + B, OP = '0', ACTIVATION = '1'
        OP <= '0';
        ACTIVATION <= '1';
        WAIT FOR 10 ns;

        -- Test case 4: A * B, OP = '1', ACTIVATION = '1'
        OP <= '1';
        WAIT FOR 10 ns;

        -- End simulation
        WAIT;
    END PROCESS;

END behavior;