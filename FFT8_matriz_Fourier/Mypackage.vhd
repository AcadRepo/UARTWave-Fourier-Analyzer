----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2024 11:19:05
-- Design Name: 
-- Module Name: Mypackage - Behavioral
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
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;
use std.textio.all;
use ieee.std_logic_textio.all;


package fft_pkg is


type x is array (0 to 7) of real;
--type y is array (0 to 1) of real;

function mult (signal n1: real ;n2 : x) return x;
function add (signal y1,y2,y3,y4,y5,y6,y7,y8 : x) return x;

end fft_pkg; 

package body fft_pkg is 

-- Addition of complex numbers 
  function add (signal y1,y2,y3,y4,y5,y6,y7,y8: x) return x is
    variable sum : x;
  begin
  
  for i in 0 to 7 loop
  
    sum(i):= y1(i) + y2(i) + y3(i) + y4(i) + y5(i) + y6(i) + y7(i) + y8(i);
    
   
   end loop;
    return sum; 
  end add;


---- Multiplication of complex numbers
function mult (signal n1:real;n2 : x) return x is
    variable prod : x;
  begin
  for i in 0 to 7 loop
    prod(i):= n1* n2(i);
    
  end loop;     
    return prod; 
  end mult;
  

end fft_pkg;
