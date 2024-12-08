----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2024 11:17:46
-- Design Name: 
-- Module Name: Matriz_FFT - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
library work;
use work.fft_pkg.ALL;



entity DFT is
  Port (
  muestra_re: in x;
  y_re,y_im: out x
   );
end DFT;

architecture Behavioral of DFT is

signal z0,z1,z2,z3,z4,z5,z6,z7,
 c0,c1,c2,c3,c4,c5,c6,c7: x :=(others => 0.0);
signal muestra_im:x:=(others => 0.0);
signal dones: std_logic;


--Matriz de reales
constant y0 : x :=( --1

(1.0),
(1.0),
(1.0),
(1.0),
(1.0),
(1.0),
(1.0),
(1.0)
);

constant y1 : x :=( --2

(1.0),
(0.70711),
(0.000000000000000061232),
(-0.70711),
(-1.0),
(-0.70711),
(0.000000000000000061232),
(0.70711)
);

constant y2 : x :=( --3

(1.0),
(0.000000000000000061232),
(-1.0),
(0.000000000000000061232),
(1.0),
(0.000000000000000061232),
(-1.0),
(0.000000000000000061232)
);

constant y3: x :=( --4

(1.0),
(-0.70711),
(0.000000000000000061232),
(0.70711),
(-1.0),
(0.70711),
(0.000000000000000061232),
(-0.70711)
);

constant y4: x :=( --5

(1.0),
(-1.0),
(1.0),
(-1.0),
(1.0),
(-1.0),
(1.0),
(-1.0)
);

constant y5: x :=( --6

(1.0),
(-0.70711),
(0.000000000000000061232),
(0.70711),
(-1.0),
(0.70711),
(0.000000000000000061232),
(-0.70711)
);


constant y6: x :=( --7

(1.0),
(0.000000000000000061232),
(-1.0),
(0.000000000000000061232),
(1.0),
(0.000000000000000061232),
(-1.0),
(0.000000000000000061232)
);


constant y7: x :=( --8

(1.0),
(0.70711),
(0.000000000000000061232),
(-0.70711),
(-1.0),
(-0.70711),
(0.000000000000000061232),
(0.70711)
);



--Matriz de imaginarios
constant yi0 : x :=( --1

(0.0),
(0.0),
(0.0),
(0.0),
(0.0),
(0.0),
(0.0),
(0.0)
);

constant yi1 : x :=( --2

(0.0),
(-0.70711),
(-1.0),
(-0.70711),
(0.0),
(0.70711),
(1.0),
(0.70711)
);

constant yi2 : x :=( --3

(0.0),
(-1.0),
(0.0),
(1.0),
(0.0),
(-1.0),
(-0.0),
(1.0)
);

constant yi3: x :=( --4 

(1.0),
(-0.70711),
(1.0),
(-0.70711),
(0.0),
(0.70711),
(-1.0),
(0.70711)
);

constant yi4: x :=( --5

(0.0),
(0.0),
(0.0),
(0.0),
(0.0),
(0.0),
(0.0),
(0.0)
);

constant yi5: x :=( --6

(0.0),
(0.70711),
(-1.0),
(0.70711),
(0.0),
(-0.70711),
(1.0),
(-0.70711)
);


constant yi6: x :=( --7

(0.0),
(1.0),
(0.0),
(-1.0),
(0.0),
(1.0),
(0.0),
(-1.0)
);


constant yi7: x :=( --8

(0.0),
(0.70711),
(1.0),
(0.70711),
(0.0),
(-0.70711),
(-1.0),
(-0.70711)
);

begin

--Multiplicacion de muestra con matriz de reales


        z0<=mult(muestra_re(0),y0);
    
        z1<=mult(muestra_re(1),y1);
    
        z2<=mult(muestra_re(2),y2);
    
        z3<=mult(muestra_re(3),y3);
    
        z4<=mult(muestra_re(4),y4);
    
        z5<=mult(muestra_re(5),y5);
    
        z6<=mult(muestra_re(6),y6);
    
        z7<=mult(muestra_re(7),y7);
    
    --Obtencion de vector de reales
    
        y_re<=add(z0,z1,z2,z3,z4,z5,z6,z7);
    
    
    
    --//////////////////////////////////////////////////
    
    
    
    --Multiplicacion de muestra con matriz de imaginarios
    
        c0<=mult(muestra_im(0),yi0);
    
        c1<=mult(muestra_im(1),yi1);
    
        c2<=mult(muestra_im(2),yi2);
    
        c3<=mult(muestra_im(3),yi3);
    
        c4<=mult(muestra_im(4),yi4);
    
        c5<=mult(muestra_im(5),yi5);
    
        c6<=mult(muestra_im(6),yi6);
    
        c7<=mult(muestra_im(7),yi7);
    
    --Obtencion de vector de imaginarios
    
        y_im<=add(c0,c1,c2,c3,c4,c5,c6,c7);
        
       





end Behavioral;

