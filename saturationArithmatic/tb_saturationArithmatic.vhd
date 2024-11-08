ENTITY tb_saturationArithmatic IS
END tb_saturationArithmatic;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ARCHITECTURE behavior OF tb_saturationArithmatic IS

    COMPONENT saturationArithmatic
    GENERIC (
        BUS_SIZE : INTEGER := 11;
        MAX_VAL : INTEGER := 2047
    );
    PORT (
        A : IN STD_LOGIC_VECTOR(BUS_SIZE DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(BUS_SIZE DOWNTO 0);
        S : OUT STD_LOGIC_VECTOR(BUS_SIZE DOWNTO 0)
    );
    END COMPONENT;

    SIGNAL A : STD_LOGIC_VECTOR(11 DOWNTO 0) := (others => '0');
    SIGNAL B : STD_LOGIC_VECTOR(11 DOWNTO 0) := (others => '0');
    SIGNAL S : STD_LOGIC_VECTOR(11 DOWNTO 0);

BEGIN

    uut: saturationArithmatic
        GENERIC MAP (
            BUS_SIZE => 11,
            MAX_VAL => 2047
        )
        PORT MAP (
            A => A,
            B => B,
            S => S
        );

        stim_proc: PROCESS
        BEGIN
            -- Test case 1: A + B less than MAX_VAL (2047)
            A <= std_logic_vector(to_unsigned(1000, 12));
            B <= std_logic_vector(to_unsigned(1000, 12));
            WAIT FOR 10 ns;
        
            -- Test case 2: A + B equal to MAX_VAL (2047)
            A <= std_logic_vector(to_unsigned(1023, 12));
            B <= std_logic_vector(to_unsigned(1024, 12));
            WAIT FOR 10 ns;
        
            -- Test case 3: A + B slightly above MAX_VAL
            A <= std_logic_vector(to_unsigned(1024, 12));
            B <= std_logic_vector(to_unsigned(1024, 12));
            WAIT FOR 10 ns;
        
            -- Test case 4: A + B significantly above MAX_VAL
            A <= std_logic_vector(to_unsigned(1025, 12));
            B <= std_logic_vector(to_unsigned(1024, 12));
            WAIT FOR 10 ns;
        
            -- End simulation
            WAIT;
        END PROCESS;
        

END behavior;
