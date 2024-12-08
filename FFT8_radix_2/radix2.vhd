

Library IEEE;
use IEEE.Std_Logic_1164.all;


entity RADIX is
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
    input_ready : out std_logic;
    valid : in std_logic;
    reset : in std_logic
  );
end entity;

architecture RTL of RADIX is
  type statetype is (ST1_A,ST1_M,ST2_A,ST2_M,ST3_A,ST3_M,ST4_A,RESULT);
  signal STATE : statetype := ST1_A;
  subtype	bufferType   is std_logic_vector(31 downto 0);
  type 	addType  is array (23 downto 0) of bufferType;
  type 	multiType  is array (7 downto 0) of bufferType;
  type 	buffersType_8  is array (7 downto 0) of bufferType;
  type 	buffersType_16  is array (15 downto 0) of bufferType;
  signal	add_input_1_re	:	addType := ((others=> (others=>'0')));
  signal	add_input_1_im	:	addType := ((others=> (others=>'0')));
  signal	add_input_2_re	:	addType := ((others=> (others=>'0')));
  signal	add_input_2_im	:	addType := ((others=> (others=>'0')));
  signal	add_result_re	:	addType := ((others=> (others=>'0')));
  signal	add_result_im	:	addType := ((others=> (others=>'0')));

  signal buffer1_RE : buffersType_8:= ((others=> (others=>'0')));
  signal buffer1_IM : buffersType_8:= ((others=> (others=>'0')));
  signal buffer2_RE : buffersType_8:= ((others=> (others=>'0')));
  signal buffer2_IM : buffersType_8:= ((others=> (others=>'0')));
  signal buffer3_RE : buffersType_8:= ((others=> (others=>'0')));
  signal buffer3_IM : buffersType_8:= ((others=> (others=>'0')));
  signal buffer4_RE : buffersType_8:= ((others=> (others=>'0')));
  signal buffer4_IM : buffersType_8:= ((others=> (others=>'0')));
  signal buffer5_RE : buffersType_8:= ((others=> (others=>'0')));
  signal buffer5_IM : buffersType_8:= ((others=> (others=>'0')));
  signal buffer6_RE : buffersType_8:= ((others=> (others=>'0')));
  signal buffer6_IM : buffersType_8:= ((others=> (others=>'0')));


  subtype	validType   is std_logic;
  type 	validListType is array (4 downto 0) of validType ;
  signal valid_list : validListType;
  signal ready_list : validListType;




  signal	multi_input_1_re	:	multiType := ((others=> (others=>'0')));
  signal	multi_input_1_im	:	multiType := ((others=> (others=>'0')));
  signal	multi_input_2_re	:	multiType := ((others=> (others=>'0')));
  signal	multi_input_2_im	:	multiType := ((others=> (others=>'0')));
  signal	multi_result_re	:	multiType := ((others=> (others=>'0')));
  signal	multi_result_im	:	multiType := ((others=> (others=>'0')));


  -- LUT
  -- W8_0 = 1
  signal W8_0_RE : STD_LOGIC_VECTOR (31 downto 0) := "00111111100000000000000000000000";
  signal W8_0_IM : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
  -- W8_1 = 0.70711-0.70711i
  signal W8_1_RE : STD_LOGIC_VECTOR (31 downto 0) := "00111111001101010000010011110011";
  signal W8_1_IM : STD_LOGIC_VECTOR (31 downto 0) := "10111111001101010000010011110011";
  -- W8_2 = 6.1232e-17-1i
  signal W8_2_RE : STD_LOGIC_VECTOR (31 downto 0) := "00100100100011010011000100110010";
  signal W8_2_IM : STD_LOGIC_VECTOR (31 downto 0) := "10111111100000000000000000000000";
  -- W8_3 = -0.70711-0.70711i
  signal W8_3_RE : STD_LOGIC_VECTOR (31 downto 0) := "10111111001101010000010011110011";
  signal W8_3_IM : STD_LOGIC_VECTOR (31 downto 0) := "10111111001101010000010011110011";
 

  component MULTI
    port (
      CLK        : in std_logic;
      Z1_IM      : in std_logic_vector(31 downto 0);
      Z1_RE      : in std_logic_vector(31 downto 0);
      Z2_RE      : in std_logic_vector(31 downto 0);
      Z2_IM      : in std_logic_vector(31 downto 0);
      RESULT_RE  : out std_logic_vector(31 downto 0);
      RESULT_IM  : out std_logic_vector(31 downto 0)
    );
  end component;

  component COMPLEX_ADDER
    port (
      CLK        : in std_logic;
      Z1_IM      : in std_logic_vector(31 downto 0);
      Z1_RE      : in std_logic_vector(31 downto 0);
      Z2_RE      : in std_logic_vector(31 downto 0);
      Z2_IM      : in std_logic_vector(31 downto 0);
      RESULT_RE  : out std_logic_vector(31 downto 0);
      RESULT_IM  : out std_logic_vector(31 downto 0)
    );
  end component;

  component QUEUE
    port (
      valid : in std_logic;
      ready : out std_logic;
      clk   : in std_logic;
      reset : in std_logic
    );
  end component;

  component READY
    port (
      valid : in std_logic;
      ready : out std_logic;
      clk   : in std_logic;
      reset : in std_logic
    );
  end component;
begin

    -------------SUMMATION PORT MAP
  ADDERS: for i in 0 to 23 generate
    UX: COMPLEX_ADDER port map(
      CLK => CLK,
      Z1_IM => add_input_1_im(i),
      Z1_RE => add_input_1_re(i),
      Z2_IM => add_input_2_im(i),
      Z2_RE => add_input_2_re(i),
      RESULT_IM => add_result_im(i),
      RESULT_RE => add_result_re(i)
    );
  end generate;

  -------------MULTIPLICATION PORT MAP
  MULTIPLIERS: for i in 0 to 7 generate
    UX: MULTI port map(
      CLK => CLK,
      Z1_IM => multi_input_1_im(i),
      Z1_RE => multi_input_1_re(i),
      Z2_IM => multi_input_2_im(i),
      Z2_RE => multi_input_2_re(i),
      RESULT_IM => multi_result_im(i),
      RESULT_RE => multi_result_re(i)
    );
  end generate;

  QUEUE_LIST: for i in 0 to 4 generate
    UX: QUEUE port map(
      CLK => CLK,
      ready => ready_list(i),
      valid => valid_list(i),
      reset => reset
    );
  end generate;

  UX: READY port map(
    CLK => CLK,
    ready => input_ready,
    valid => valid,
    reset => reset
  );


  state_proc: process(CLK)
  begin
    if (clk'event and clk = '1') then
      if(ready_list(0) = '1') then
        buffer1_RE(0) <= add_result_re(0);
        buffer1_IM(0) <= add_result_im(0);
        buffer1_RE(1) <= add_result_re(1);
        buffer1_IM(1) <= add_result_im(1);
        buffer1_RE(2) <= add_result_re(2);
        buffer1_IM(2) <= add_result_im(2);
        buffer1_RE(3) <= add_result_re(3);
        buffer1_IM(3) <= add_result_im(3);
        buffer1_RE(4) <= add_result_re(4);
        buffer1_IM(4) <= add_result_im(4);
        buffer1_RE(5) <= add_result_re(5);
        buffer1_IM(5) <= add_result_im(5);
        buffer1_RE(6) <= add_result_re(6);
        buffer1_IM(6) <= add_result_im(6);
        buffer1_RE(7) <= add_result_re(7);
        buffer1_IM(7) <= add_result_im(7);
        
      end if;
      if(ready_list(1) = '1') then
        buffer2_RE(0) <= buffer1_RE(0);
        buffer2_IM(0) <= buffer1_IM(0);
        buffer2_RE(1) <= buffer1_RE(1);
        buffer2_IM(1) <= buffer1_IM(1);
        buffer2_RE(2) <= buffer1_RE(2);
        buffer2_IM(2) <= buffer1_IM(2);
        buffer2_RE(3) <= buffer1_RE(3);
        buffer2_IM(3) <= buffer1_IM(3);
        

        buffer2_RE(4) <=  multi_result_re(0);
        buffer2_IM(4) <=  multi_result_im(0);
        buffer2_RE(5) <=  multi_result_re(1);
        buffer2_IM(5) <=  multi_result_im(1);
        buffer2_RE(6) <= multi_result_re(2);
        buffer2_IM(6) <= multi_result_im(2);
        buffer2_RE(7) <= multi_result_re(3);
        buffer2_IM(7) <= multi_result_im(3);
        
      end if;
      if(ready_list(2) = '1') then
        buffer3_RE(0) <=  add_result_re(8);
        buffer3_IM(0) <=  add_result_im(8);
        buffer3_RE(1) <=  add_result_re(9);
        buffer3_IM(1) <=  add_result_im(9);
        buffer3_RE(2) <=  add_result_re(10);
        buffer3_IM(2) <=  add_result_im(10);
        buffer3_RE(3) <=  add_result_re(11);
        buffer3_IM(3) <=  add_result_im(11);
        buffer3_RE(4) <=  add_result_re(12);
        buffer3_IM(4) <=  add_result_im(12);
        buffer3_RE(5) <=  add_result_re(13);
        buffer3_IM(5) <=  add_result_im(13);
        buffer3_RE(6) <=  add_result_re(14);
        buffer3_IM(6) <=  add_result_im(14);
        buffer3_RE(7) <=  add_result_re(15);
        buffer3_IM(7) <=  add_result_im(15);
        
      end if;
      if(ready_list(3) = '1') then
        buffer4_RE(0) <= buffer3_RE(0);
        buffer4_IM(0) <= buffer3_IM(0);
        buffer4_RE(1) <= buffer3_RE(1);
        buffer4_IM(1) <= buffer3_IM(1);
        buffer4_RE(2) <= buffer3_RE(2);
        buffer4_IM(2) <= buffer3_IM(2);
        buffer4_RE(3) <= buffer3_RE(3);
        buffer4_IM(3) <= buffer3_IM(3);
        

        buffer4_RE(4) <= multi_result_re(4);
        buffer4_IM(4) <= multi_result_im(4);
        buffer4_RE(5) <= multi_result_re(5);
        buffer4_IM(5) <= multi_result_im(5);
        buffer4_RE(6) <= multi_result_re(6);
        buffer4_IM(6) <= multi_result_im(6);
        buffer4_RE(7) <= multi_result_re(7);
        buffer4_IM(7) <= multi_result_im(7);
        
      end if;
     
    end if;
  end process state_proc;

  valid_list(0) <= valid;
  valid_list(1) <= ready_list(0);
  valid_list(2) <= ready_list(1);
  valid_list(3) <= ready_list(2);
  valid_list(4) <= ready_list(3);
  result_ready <= ready_list(4);


  ---------------------ST1_A (LAYER 1)

  add_input_1_re(0) <= X0;
  add_input_1_im(0) <= (others => '0');
  add_input_2_re(0) <= X4;
  add_input_2_im(0) <= (others => '0');

  add_input_1_re(1) <= X1;
  add_input_1_im(1) <= (others => '0');
  add_input_2_re(1) <= X5;
  add_input_2_im(1) <= (others => '0');

  add_input_1_re(2) <= X2;
  add_input_1_im(2) <= (others => '0');
  add_input_2_re(2) <= X6;
  add_input_2_im(2) <= (others => '0');
  
  
  add_input_1_re(3) <= X3;
  add_input_1_im(3) <= (others => '0');
  add_input_2_re(3) <= X7;
  add_input_2_im(3) <= (others => '0');

  

  add_input_1_re(4) <= X0;
  add_input_1_im(4) <= (others => '0');
  add_input_2_re(4)(31) <= not X4(31);
  add_input_2_re(4)(30 downto 0) <= X4(30 downto 0);
  add_input_2_im(4) <= (others => '0');

  add_input_1_re(5) <= X1;
  add_input_1_im(5) <= (others => '0');
  add_input_2_re(5)(31) <= not X5(31);
  add_input_2_re(5)(30 downto 0) <= X5(30 downto 0);
  add_input_2_im(5) <= (others => '0');

  add_input_1_re(6) <= X2;
  add_input_1_im(6) <= (others => '0');
  add_input_2_re(6)(31) <= not X6(31);
  add_input_2_re(6)(30 downto 0) <= X6(30 downto 0);
  add_input_2_im(6) <= (others => '0');

  add_input_1_re(7) <= X3;
  add_input_1_im(7) <= (others => '0');
  add_input_2_re(7)(31) <= not X7(31);
  add_input_2_re(7)(30 downto 0) <= X7(30 downto 0);
  add_input_2_im(7) <= (others => '0');

  

  ---------------------ST1_M (LAYER 2)

  multi_input_1_re(0) <= buffer1_RE(4);
  multi_input_1_im(0) <= buffer1_IM(4);
  multi_input_2_re(0) <= W8_0_RE;
  multi_input_2_im(0) <= W8_0_IM;

  multi_input_1_re(1) <= buffer1_RE(5);
  multi_input_1_im(1) <= buffer1_IM(5);
  multi_input_2_re(1) <= W8_1_RE;
  multi_input_2_im(1) <= W8_1_IM;

  multi_input_1_re(2) <= buffer1_RE(6);
  multi_input_1_im(2) <= buffer1_IM(6);
  multi_input_2_re(2) <= W8_2_RE;
  multi_input_2_im(2) <= W8_2_IM;

  multi_input_1_re(3) <= buffer1_RE(7);
  multi_input_1_im(3) <= buffer1_IM(7);
  multi_input_2_re(3) <= W8_3_RE;
  multi_input_2_im(3) <= W8_3_IM;

 

  ---------------------ST2_A (LAYER 3)

  add_input_1_re(8) <= buffer2_RE(0);
  add_input_1_im(8) <= buffer2_IM(0);
  add_input_2_re(8) <= buffer2_RE(2);
  add_input_2_im(8) <= buffer2_IM(2);

  add_input_1_re(9) <= buffer2_RE(1);
  add_input_1_im(9) <= buffer2_IM(1);
  add_input_2_re(9) <= buffer2_RE(3);
  add_input_2_im(9) <= buffer2_IM(3);

  add_input_1_re(10) <= buffer2_RE(4);
  add_input_1_im(10) <= buffer2_IM(4);
  add_input_2_re(10) <= buffer2_RE(6);
  add_input_2_im(10) <= buffer2_IM(6);

  add_input_1_re(11) <= buffer2_RE(5);
  add_input_1_im(11) <= buffer2_IM(5);
  add_input_2_re(11) <= buffer2_RE(7);
  add_input_2_im(11) <= buffer2_IM(7);

  add_input_1_re(12) <= buffer2_RE(0);
  add_input_1_im(12) <= buffer2_IM(0);
  add_input_2_re(12)(31) <= not buffer2_RE(2)(31);
  add_input_2_re(12)(30 downto 0) <= buffer2_RE(2)(30 downto 0);
  add_input_2_im(12)(31) <= not buffer2_IM(2)(31);
  add_input_2_im(12)(30 downto 0) <= buffer2_IM(2)(30 downto 0);

  add_input_1_re(13) <= buffer2_RE(1);
  add_input_1_im(13) <= buffer2_IM(1);
  add_input_2_re(13)(31) <= not buffer2_RE(3)(31);
  add_input_2_re(13)(30 downto 0) <= buffer2_RE(3)(30 downto 0);
  add_input_2_im(13)(31) <= not buffer2_IM(3)(31);
  add_input_2_im(13)(30 downto 0) <= buffer2_IM(3)(30 downto 0);

  add_input_1_re(14) <= buffer2_RE(4);
  add_input_1_im(14) <= buffer2_IM(4);
  add_input_2_re(14)(31) <= not buffer2_RE(6)(31);
  add_input_2_re(14)(30 downto 0) <= buffer2_RE(6)(30 downto 0);
  add_input_2_im(14)(31) <= not buffer2_IM(6)(31);
  add_input_2_im(14)(30 downto 0) <= buffer2_IM(6)(30 downto 0);

  add_input_1_re(15) <= buffer2_RE(5);
  add_input_1_im(15) <= buffer2_IM(5);
  add_input_2_re(15)(31) <= not buffer2_RE(7)(31);
  add_input_2_re(15)(30 downto 0) <= buffer2_RE(7)(30 downto 0);
  add_input_2_im(15)(31) <= not buffer2_IM(7)(31);
  add_input_2_im(15)(30 downto 0) <= buffer2_IM(7)(30 downto 0);
--
  

    ---------------------ST2_M (LAYER 4)


  multi_input_1_re(4) <= buffer3_RE(4);
  multi_input_1_im(4) <= buffer3_IM(4);
  multi_input_2_re(4) <= W8_0_RE;
  multi_input_2_im(4) <= W8_0_IM;

  multi_input_1_re(5) <= buffer3_RE(5);
  multi_input_1_im(5) <= buffer3_IM(5);
  multi_input_2_re(5) <= W8_2_RE;
  multi_input_2_im(5) <= W8_2_IM;

  multi_input_1_re(6) <= buffer3_RE(6);
  multi_input_1_im(6) <= buffer3_IM(6);
  multi_input_2_re(6) <= W8_0_RE;
  multi_input_2_im(6) <= W8_0_IM;

  multi_input_1_re(7) <= buffer3_RE(7);
  multi_input_1_im(7) <= buffer3_IM(7);
  multi_input_2_re(7) <= W8_2_RE;
  multi_input_2_im(7) <= W8_2_IM;

  

  ---------------------ST3_A (LAYER 5)



  add_input_1_re(16) <= buffer4_RE(0);
  add_input_1_im(16) <= buffer4_IM(0);
  add_input_2_re(16) <= buffer4_RE(1);
  add_input_2_im(16) <= buffer4_IM(1);

  add_input_1_re(17) <= buffer4_RE(0);
  add_input_1_im(17) <= buffer4_IM(0);
  add_input_2_re(17)(31) <= not buffer4_RE(1)(31);
  add_input_2_re(17)(30 downto 0) <= buffer4_RE(1)(30 downto 0);
  add_input_2_im(17)(31) <= not buffer4_IM(1)(31);
  add_input_2_im(17)(30 downto 0) <= buffer4_IM(1)(30 downto 0);

  add_input_1_re(18) <= buffer4_RE(4);
  add_input_1_im(18) <= buffer4_IM(4);
  add_input_2_re(18) <= buffer4_RE(5);
  add_input_2_im(18) <= buffer4_IM(5);

  add_input_1_re(19) <= buffer4_RE(4);
  add_input_1_im(19) <= buffer4_IM(4);
  add_input_2_re(19)(31) <= not buffer4_RE(5)(31);
  add_input_2_re(19)(30 downto 0) <= buffer4_RE(5)(30 downto 0);
  add_input_2_im(19)(31) <= not buffer4_IM(5)(31);
  add_input_2_im(19)(30 downto 0) <= buffer4_IM(5)(30 downto 0);

  add_input_1_re(20) <= buffer4_RE(2);
  add_input_1_im(20) <= buffer4_IM(2);
  add_input_2_re(20) <= buffer4_RE(3);
  add_input_2_im(20) <= buffer4_IM(3);

  add_input_1_re(21) <= buffer4_RE(2);
  add_input_1_im(21) <= buffer4_IM(2);
  add_input_2_re(21)(31) <= not buffer4_RE(3)(31);
  add_input_2_re(21)(30 downto 0) <= buffer4_RE(3)(30 downto 0);
  add_input_2_im(21)(31) <= not buffer4_IM(3)(31);
  add_input_2_im(21)(30 downto 0) <= buffer4_IM(3)(30 downto 0);

  add_input_1_re(22) <= buffer4_RE(6);
  add_input_1_im(22) <= buffer4_IM(6);
  add_input_2_re(22) <= buffer4_RE(7);
  add_input_2_im(22) <= buffer4_IM(7);

  add_input_1_re(23) <= buffer4_RE(6);
  add_input_1_im(23) <= buffer4_IM(6);
  add_input_2_re(23)(31) <= not buffer4_RE(7)(31);
  add_input_2_re(23)(30 downto 0) <= buffer4_RE(7)(30 downto 0);
  add_input_2_im(23)(31) <= not buffer4_IM(7)(31);
  add_input_2_im(23)(30 downto 0) <= buffer4_IM(7)(30 downto 0);
  
  
   Z0_RE <= add_result_re(16);
  Z0_IM <= add_result_im(16);
  Z1_RE <= add_result_re(20);
  Z1_IM <= add_result_im(20);
  Z2_RE <= add_result_re(18);
  Z2_IM <= add_result_im(18);
  Z3_RE <= add_result_re(22);
  Z3_IM <= add_result_im(22);
  Z4_RE <= add_result_re(17);
  Z4_IM <= add_result_im(17);
  Z5_RE <= add_result_re(21);
  Z5_IM <= add_result_im(21);
  Z6_RE <= add_result_re(19);
  Z6_IM <= add_result_im(19);
  Z7_RE <= add_result_re(23);
  Z7_IM <= add_result_im(23);

 

  

end architecture;