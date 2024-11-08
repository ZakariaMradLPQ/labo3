LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY eightBitCounter IS
    GENERIC (
        WIDTH : INTEGER := 7
    );
    PORT (
        clk : IN STD_LOGIC;
        clear : IN STD_LOGIC;
        count : OUT STD_LOGIC_VECTOR (WIDTH DOWNTO 0)
    );
END eightBitCounter;

ARCHITECTURE Behavioral OF eightBitCounter IS
    SIGNAL counter : unsigned(WIDTH DOWNTO 0) := (OTHERS => '0');
BEGIN
    PROCESS (clk, clear)
    BEGIN
        IF clear = '1' THEN
            counter <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            counter <= counter + 1;
        END IF;
    END PROCESS;

    count <= STD_LOGIC_VECTOR(counter);
END Behavioral;