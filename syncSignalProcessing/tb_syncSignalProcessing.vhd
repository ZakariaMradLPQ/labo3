LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY tb_syncSignalProcessing IS
END tb_syncSignalProcessing;

ARCHITECTURE behavior OF tb_syncSignalProcessing IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT syncSignalProcessing
        GENERIC (
            IN_SIZE : INTEGER := 7;
            OUT_SIZE : INTEGER := 15
        );
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            A : IN STD_LOGIC_VECTOR(IN_SIZE DOWNTO 0);
            B : IN STD_LOGIC_VECTOR(IN_SIZE DOWNTO 0);
            ACTIVATION : IN STD_LOGIC;
            OP : IN STD_LOGIC;
            S : OUT STD_LOGIC_VECTOR(OUT_SIZE DOWNTO 0)
        );
    END COMPONENT;

    -- Signals for the UUT
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '0';
    SIGNAL A : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL B : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL ACTIVATION : STD_LOGIC := '0';
    SIGNAL OP : STD_LOGIC := '0';
    SIGNAL S : STD_LOGIC_VECTOR(15 DOWNTO 0);

    -- Clock period definition
    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut : syncSignalProcessing
    GENERIC MAP(
        IN_SIZE => 7,
        OUT_SIZE => 15
    )
    PORT MAP(
        clk => clk,
        reset => reset,
        A => A,
        B => B,
        ACTIVATION => ACTIVATION,
        OP => OP,
        S => S
    );

    -- Clock process definitions
    clk_process : PROCESS
        VARIABLE counter : INTEGER := 0;
    BEGIN
        WHILE counter < 30 LOOP
            clk <= '0';
            WAIT FOR clk_period/2;
            clk <= '1';
            WAIT FOR clk_period/2;
            counter := counter + 1;
        END LOOP;
        WAIT; -- Wait indefinitely after the loop
    END PROCESS;

    -- Stimulus process
    stim_proc : PROCESS
    BEGIN
        -- Reset the system
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        WAIT FOR 20 ns;

        -- Test case 1: A + B, OP = '0', ACTIVATION = '0'
        A <= STD_LOGIC_VECTOR(to_unsigned(10, 8));
        B <= STD_LOGIC_VECTOR(to_unsigned(20, 8));
        OP <= '0';
        ACTIVATION <= '0';
        WAIT FOR 20 ns;
        -- Reset the system
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        WAIT FOR 20 ns;

        -- Test case 2: A * B, OP = '1', ACTIVATION = '0'
        OP <= '1';
        WAIT FOR 20 ns;
        -- Reset the system
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        WAIT FOR 20 ns;

        -- Test case 3: A + B, OP = '0', ACTIVATION = '1'
        OP <= '0';
        ACTIVATION <= '1';
        WAIT FOR 20 ns;
        -- Reset the system
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        WAIT FOR 20 ns;

        -- Test case 4: A * B, OP = '1', ACTIVATION = '1'
        OP <= '1';
        WAIT FOR 20 ns;
        -- Reset the system
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        WAIT FOR 20 ns;

        -- End simulation
        WAIT FOR 100 ns;
        WAIT;
    END PROCESS;

END behavior;