----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2024 15:16:06
-- Design Name: 
-- Module Name: DFT_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;
use work.fft_pkg.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DFT_tb is
--  Port ( );
end DFT_tb;

architecture Behavioral of DFT_tb is

component DFT is
  Port (
 
  muestra_re: in x;
  y_re,y_im: out x
   );

end component;


--entradas
signal muestra_re: x;


--salidas

signal y_re,y_im: x;


begin


uut: DFT port map(muestra_re=>muestra_re, y_re=>y_re,y_im=>y_im);




estimulos:process
begin

muestra_re<=((137.0),(131.0),(137.0),(131.0),(137.0),(131.0),(137.0),(131.0));

wait;

end process;


end Behavioral;
