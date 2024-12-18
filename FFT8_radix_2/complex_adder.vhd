----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2024 22:50:26
-- Design Name: 
-- Module Name: complex_adder - Behavioral
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

Library IEEE;
use IEEE.Std_Logic_1164.all;

entity COMPLEX_ADDER is
  port (
    CLK        : in std_logic;
    Z1_IM      : in std_logic_vector(31 downto 0);
    Z1_RE      : in std_logic_vector(31 downto 0);
    Z2_RE      : in std_logic_vector(31 downto 0);
    Z2_IM      : in std_logic_vector(31 downto 0);
    RESULT_RE  : out std_logic_vector(31 downto 0);
    RESULT_IM  : out std_logic_vector(31 downto 0)
  );
end entity;

architecture RTL of COMPLEX_ADDER is
  component adder
  port (
    x : in  STD_LOGIC_VECTOR (31 downto 0);
    y : in  STD_LOGIC_VECTOR (31 downto 0);
    z : out  STD_LOGIC_VECTOR (31 downto 0);
    clk: in std_logic
  );
  end component;
begin
  RE_ADDER : adder
  port map(
    x => Z1_RE,
    y => Z2_RE,
    z => RESULT_RE,
    clk => CLK
  );

  IM_ADDER : adder
  port map(
    x => Z1_IM,
    y => Z2_IM,
    z => RESULT_IM,
    clk => CLK
  );

end RTL;