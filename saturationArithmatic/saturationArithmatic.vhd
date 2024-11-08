LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY saturationArithmatic IS
    GENERIC (
        BUS_SIZE : INTEGER := 11;
        MAX_VAL : INTEGER := 2047
    );
    PORT (
        A : IN STD_LOGIC_VECTOR(BUS_SIZE DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(BUS_SIZE DOWNTO 0);
        S : OUT STD_LOGIC_VECTOR(BUS_SIZE DOWNTO 0)
    );
END saturationArithmatic;

ARCHITECTURE Behavioral OF saturationArithmatic IS
    SIGNAL sum : unsigned(BUS_SIZE DOWNTO 0);
    SIGNAL isHigherThanMax : STD_LOGIC;
    SIGNAL max_val_vector : STD_LOGIC_VECTOR(BUS_SIZE DOWNTO 0);

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

BEGIN
    PROCESS (A, B)
    BEGIN
        sum <= unsigned(A) + unsigned(B);
        IF sum >= MAX_VAL THEN
            isHigherThanMax <= '1';
        ELSE
            isHigherThanMax <= '0';
        END IF;
        max_val_vector <= std_logic_vector(to_unsigned(MAX_VAL, BUS_SIZE + 1));
    END PROCESS;

    U1: mux2to1
        GENERIC MAP (
            WIDTH => BUS_SIZE
        )
        PORT MAP (
            A => std_logic_vector(sum),
            B => max_val_vector,
            Sel => isHigherThanMax,
            Y => S
        );

END Behavioral;
