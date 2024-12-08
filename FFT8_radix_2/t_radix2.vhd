----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2024 22:56:41
-- Design Name: 
-- Module Name: t_radix2 - Behavioral
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
use STD.textio.all;
use ieee.std_logic_textio.all;

entity T_RADIX is
end entity;


architecture TEST of T_RADIX is
  file file_VECTORS : text;
  file file_RESULTS : text;

  signal CLK     :  std_logic;
  signal X0      :  STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
  signal X1      :  STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
  signal X2      :  STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
  signal X3      :  STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
  signal X4      :  STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
  signal X5      :  STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
  signal X6      :  STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
  signal X7      :  STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
 
  signal Z0_RE   :  STD_LOGIC_VECTOR (31 downto 0);
  signal Z0_IM   :  STD_LOGIC_VECTOR (31 downto 0);
  signal Z1_RE   :  STD_LOGIC_VECTOR (31 downto 0);
  signal Z1_IM   :  STD_LOGIC_VECTOR (31 downto 0);
  signal Z2_RE   :  STD_LOGIC_VECTOR (31 downto 0);
  signal Z2_IM   :  STD_LOGIC_VECTOR (31 downto 0);
  signal Z3_RE   :  STD_LOGIC_VECTOR (31 downto 0);
  signal Z3_IM   :  STD_LOGIC_VECTOR (31 downto 0);
  signal Z4_RE   :  STD_LOGIC_VECTOR (31 downto 0);
  signal Z4_IM   :  STD_LOGIC_VECTOR (31 downto 0);
  signal Z5_RE   :  STD_LOGIC_VECTOR (31 downto 0);
  signal Z5_IM   :  STD_LOGIC_VECTOR (31 downto 0);
  signal Z6_RE   :  STD_LOGIC_VECTOR (31 downto 0);
  signal Z6_IM   :  STD_LOGIC_VECTOR (31 downto 0);
  signal Z7_RE   :  STD_LOGIC_VECTOR (31 downto 0);
  signal Z7_IM   :  STD_LOGIC_VECTOR (31 downto 0);

  signal result_ready :  std_logic;
  signal input_ready  :  std_logic;
  signal valid        :  std_logic;
  signal reset        :  std_logic;

component RADIX
  port (
    CLK     : in   std_logic;
    X0      : in   STD_LOGIC_VECTOR (31 downto 0);
    X1      : in   STD_LOGIC_VECTOR (31 downto 0);
    X2      : in   STD_LOGIC_VECTOR (31 downto 0);
    X3      : in   STD_LOGIC_VECTOR (31 downto 0);
    X4      : in   STD_LOGIC_VECTOR (31 downto 0);
    X5      : in   STD_LOGIC_VECTOR (31 downto 0);
    X6      : in   STD_LOGIC_VECTOR (31 downto 0);
    X7      : in   STD_LOGIC_VECTOR (31 downto 0);
    
    Z0_RE   : inout  STD_LOGIC_VECTOR (31 downto 0);
    Z0_IM   : inout  STD_LOGIC_VECTOR (31 downto 0);
    Z1_RE   : inout  STD_LOGIC_VECTOR (31 downto 0);
    Z1_IM   : inout  STD_LOGIC_VECTOR (31 downto 0);
    Z2_RE   : inout  STD_LOGIC_VECTOR (31 downto 0);
    Z2_IM   : inout  STD_LOGIC_VECTOR (31 downto 0);
    Z3_RE   : inout  STD_LOGIC_VECTOR (31 downto 0);
    Z3_IM   : inout  STD_LOGIC_VECTOR (31 downto 0);
    Z4_RE   : inout  STD_LOGIC_VECTOR (31 downto 0);
    Z4_IM   : inout  STD_LOGIC_VECTOR (31 downto 0);
    Z5_RE   : inout  STD_LOGIC_VECTOR (31 downto 0);
    Z5_IM   : inout  STD_LOGIC_VECTOR (31 downto 0);
    Z6_RE   : inout  STD_LOGIC_VECTOR (31 downto 0);
    Z6_IM   : inout  STD_LOGIC_VECTOR (31 downto 0);
    Z7_RE   : inout  STD_LOGIC_VECTOR (31 downto 0);
    Z7_IM   : inout  STD_LOGIC_VECTOR (31 downto 0);
    
    result_ready : out std_logic;
    input_ready  : out std_logic;
    valid        : in    std_logic;
    reset        : in    std_logic
  );
end component;

begin

  comp : RADIX
  port map (
    CLK     =>  CLK,
    X0      =>  X0,
    X1      =>  X1,
    X2      =>  X2,
    X3      =>  X3,
    X4      =>  X4,
    X5      =>  X5,
    X6      =>  X6,
    X7      =>  X7,
    
    Z0_RE   =>  Z0_RE,
    Z0_IM   =>  Z0_IM,
    Z1_RE   =>  Z1_RE,
    Z1_IM   =>  Z1_IM,
    Z2_RE   =>  Z2_RE,
    Z2_IM   =>  Z2_IM,
    Z3_RE   =>  Z3_RE,
    Z3_IM   =>  Z3_IM,
    Z4_RE   =>  Z4_RE,
    Z4_IM   =>  Z4_IM,
    Z5_RE   =>  Z5_RE,
    Z5_IM   =>  Z5_IM,
    Z6_RE   =>  Z6_RE,
    Z6_IM   =>  Z6_IM,
    Z7_RE   =>  Z7_RE,
    Z7_IM   =>  Z7_IM,
    
    result_ready => result_ready,
    input_ready  => input_ready,
    valid        => valid,
    reset        => reset
    );


  test_proc: process
   
    variable v_TERM0 : std_logic_vector(31 downto 0):=(others => '0');
    variable v_TERM1 : std_logic_vector(31 downto 0):=(others => '0');
    variable v_TERM2 : std_logic_vector(31 downto 0):=(others => '0');
    variable v_TERM3 : std_logic_vector(31 downto 0):=(others => '0');
    variable v_TERM4 : std_logic_vector(31 downto 0):=(others => '0');
    variable v_TERM5 : std_logic_vector(31 downto 0):=(others => '0');
    variable v_TERM6 : std_logic_vector(31 downto 0):=(others => '0');
    variable v_TERM7 : std_logic_vector(31 downto 0):=(others => '0');
   
  
  begin
  
    reset <= '0';
    valid <= '0'; 
    wait for 5 ns;
      X0  <= "01000011000010010000000000000000";
      X1  <= "01000011000000110000000000000000";
      X2  <= "01000011000010010000000000000000";
      X3  <= "01000011000000110000000000000000";
      X4  <= "01000011000010010000000000000000";
      X5  <= "01000011000000110000000000000000";
      X6  <= "01000011000010010000000000000000";
      X7  <= "01000011000000110000000000000000";

    reset <= '1';
   
    
    valid <= '1';  -- Indicar que los datos son válidos
    wait for 3 ns; -- Mantener `valid` activo por un ciclo de reloj
    valid <= '0'; 

    
    
      wait until input_ready = '1';
     
      --wait for 40 ns;
    


    wait;
  end process test_proc;

  clk_proc: process
  begin
    clk <= '0';
    wait for 1 ns;
    clk <= '1';
    wait for 1 ns;
  end process clk_proc;

 

end TEST;
