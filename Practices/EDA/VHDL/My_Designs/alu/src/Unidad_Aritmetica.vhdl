library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- Reemplazo por numeric_std

entity Unidad_Aritmetica is
    port (
        A, B: in std_logic_vector(7 downto 0);
        cod_ope: in std_logic_vector(3 downto 0);
        CarryIn: in std_logic;
        salidaUA: out std_logic_vector(7 downto 0);
        CarryOut: out std_logic
    );
end Unidad_Aritmetica;

architecture Comp_Aritm of Unidad_Aritmetica is
begin
    process(A, B, cod_ope, CarryIn)
        variable acarreo : std_logic_vector(8 downto 0); -- Usamos std_logic_vector
    begin
        acarreo(0) := CarryIn;
        
        case to_integer(unsigned(cod_ope)) is -- Convertimos cod_ope a entero
            when 0 => salidaUA <= A;
                             CarryOut <= '0';
            when 1 => salidaUA <= std_logic_vector(unsigned(A) + 1);
                             CarryOut <= '0';
            when 2 => salidaUA <= std_logic_vector(unsigned(A) - 1);
                             CarryOut <= '0';
            when 3 => salidaUA <= B;
                             CarryOut <= '0';
            when 4 => salidaUA <= std_logic_vector(unsigned(B) + 1);
                             CarryOut <= '0';
            when 5 => salidaUA <= std_logic_vector(unsigned(B) - 1);
                             CarryOut <= '0';
            when 6 => 
                if (unsigned(A) < unsigned(B)) then
                    CarryOut <= '1';
                else
                    CarryOut <= '0';
                end if;
                salidaUA <= std_logic_vector(unsigned(A) - unsigned(B));
            when others => 
                for i in 0 to 7 loop
                    acarreo(i+1) := (A(i) and B(i)) or
                                    (A(i) and acarreo(i)) or
                                    (B(i) and acarreo(i)); -- operaciones logicas sobre std_logic
                end loop;
                CarryOut <= acarreo(8);
                salidaUA <= std_logic_vector(unsigned(A) + unsigned(B) + unsigned(CarryIn & "0000000")); -- bug here
        end case;
    end process;
end Comp_Aritm;