LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY syncRegister IS
    GENERIC (
        WIDTH : INTEGER := 7
    );
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        d : IN STD_LOGIC_VECTOR(WIDTH DOWNTO 0);
        q : OUT STD_LOGIC_VECTOR(WIDTH DOWNTO 0)
    );
END syncRegister;

ARCHITECTURE Behavioral OF syncRegister IS
    SIGNAL reg : STD_LOGIC_VECTOR(WIDTH DOWNTO 0);
BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            reg <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            reg <= d;
        END IF;
    END PROCESS;

    q <= reg;
END Behavioral;