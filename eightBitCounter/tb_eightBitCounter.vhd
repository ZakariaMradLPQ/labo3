LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY tb_eightBitCounter IS
END tb_eightBitCounter;

ARCHITECTURE behavior OF tb_eightBitCounter IS
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT eightBitCounter
        GENERIC (
            WIDTH : INTEGER := 4
        );
        PORT (
            clk : IN STD_LOGIC;
            clear : IN STD_LOGIC;
            count : OUT STD_LOGIC_VECTOR(WIDTH DOWNTO 0)
        );
    END COMPONENT;

    -- Signals for the UUT
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL clear : STD_LOGIC := '0';
    SIGNAL count : STD_LOGIC_VECTOR(4 DOWNTO 0);

    -- Clock period definition
    CONSTANT clk_period : TIME := 10 ns;

BEGIN
    -- Instantiate the Unit Under Test (UUT)
    uut: eightBitCounter
        GENERIC MAP (
            WIDTH => 4
        )
        PORT MAP (
            clk => clk,
            clear => clear,
            count => count
        );

    -- Clock process definitions
    clk_process : PROCESS
        VARIABLE counter : INTEGER := 0;
    BEGIN
        WHILE counter < 42 LOOP
            clear <= '0';
            if(counter = 4 or counter = 8) then
                clear <= '1';
            end if;
            
            clk <= '0';
            WAIT FOR clk_period/2;
            clk <= '1';
            WAIT FOR clk_period/2;
            counter := counter + 1;
        END LOOP;
        WAIT; -- Wait indefinitely after the loop
    END PROCESS;

END behavior;