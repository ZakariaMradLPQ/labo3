library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2to1 is
    generic (
        WIDTH : integer := 1
    );
    port (
        A : in  STD_LOGIC_VECTOR(WIDTH downto 0);  -- Input A
        B : in  STD_LOGIC_VECTOR(WIDTH downto 0);  -- Input B
        Sel : in  STD_LOGIC;  -- Select input
        Y : out  STD_LOGIC_VECTOR(WIDTH downto 0)  -- Output
    );
end mux2to1;

architecture Behavioral of mux2to1 is
begin
    process(A, B, Sel)
    begin
        if Sel = '0' then
            Y <= A;
        else
            Y <= B;
        end if;
    end process;
end Behavioral;