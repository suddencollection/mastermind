library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity datapath is 
port (S: in std_logic_vector(15 downto 0); -- dos switches
			clk, R1, R2, E1, E2, E3, E4, E5: in std_logic;
			end_game, end_time, end_round: out std_logic;
			HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0: out std_logic_vector(6 downto 0);
			LED: out std_logic_vector(15 downto 0));
end datapath;

architecture arqdtp of datapath is
signal SEL_MUX: std_logic_vector(1 downto 0);
signal X: std_logic_vector(3 downto 0);
signal RESULT: std_logic_vector(7 downto 0);
signal P,P_REG,E,E_REG: std_logic_vector(2 downto 0);
signal SEL: std_logic_vector(5 downto 0);
signal USER,CODE,Z: std_logic_vector(15 downto 0);
signal clock_s,end_game_s,end_time_s: std_logic;
signal TIME_s, somadormenor_s, F: std_logic_vector(3 downto 0);
signal end_round_s: std_logic;
signal comp0_s, comp1_s, comp2_s, comp3_s: std_logic;
signal decodtermo_s, rom0_s, rom1_s, rom2_s, rom3_s: std_logic_vector(15 downto 0);
-- All the HEX signal outputs
signal dec_result7to4_hex7, dec_result3to0_hex7: std_logic_vector(6 downto 0);
signal dec_time_hex4: std_logic_vector(6 downto 0);
signal dec_user_hex3, dec_code_hex3: std_logic_vector(6 downto 0);
signal dec_sel_hex2, dec_user_hex2, dec_preg_hex2, dec_code_hex2: std_logic_vector(6 downto 0); -- WARN: preg precisa ser concatenado
signal dec_user_hex1, dec_code_hex1: std_logic_vector(6 downto 0);
signal dec_sel_hex0, dec_user_hex0, dec_ereg_hex0, dec_code_hex0: std_logic_vector(6 downto 0); -- WARN: sel e ereg precisam ser concatenados
-- input signals
signal in_dec_preg_hex2, in_dec_sel_hex0, in_dec_ereg_hex0: std_logic_vector(3 downto 0);

-- OK: SOMA no canto superior esquerdo do documento
component somadormenor is
port (A: in  std_logic_vector(3 downto 0);
		B: in  std_logic_vector(3 downto 0);
		F: out  std_logic_vector(3 downto 0));
end component;

-- OK: SOMA_P no documento, aceita inputs de 4 comp_n's
component somadormaior is
port (A, B, C, D: in  std_logic;
			F: out  std_logic_vector(2 downto 0));
end component;

-- OK
component selector is 
port(in0, in1, in2, in3: in  std_logic;
     saida: out std_logic_vector(1 downto 0));    
end component;

-- OK
component ROM3 is 
port(address : in  std_logic_vector(3 downto 0);
     data: out std_logic_vector(15 downto 0));
end component;

-- OK
component ROM2 is 
port(address : in  std_logic_vector(3 downto 0);
     data: out std_logic_vector(15 downto 0));    
end component;

-- OK
component ROM1 is 
port(address : in  std_logic_vector(3 downto 0);
     data: out std_logic_vector(15 downto 0));
end component;

-- OK
component ROM0 is 
port(address : in  std_logic_vector(3 downto 0);
     data: out std_logic_vector(15 downto 0));
end component;

-- OK
component registrador16 is 
port (CLK, RST, EN: in std_logic; 
		D: in std_logic_vector(15 downto 0); 
		Q: out std_logic_vector(15 downto 0)); 
end component;

-- OK
component registrador6 is 
port (CLK, RST, EN: in std_logic; 
		D: in std_logic_vector(5 downto 0); 
		Q: out std_logic_vector(5 downto 0)); 
end component;

-- OK
component registrador3 is 
port (CLK, RST, EN: in std_logic; 
		D: in std_logic_vector(2 downto 0); 
		Q: out std_logic_vector(2 downto 0)); 
end component;

-- HACK: Não sei onde isso se encaixa!
component registrador is 
port (CLK, RST, EN: in std_logic; 
		D: in std_logic_vector(3 downto 0); 
		Q: out std_logic_vector(3 downto 0)); 
end component;

-- OK
component multiplexador74 is	
port (F1: in  std_logic_vector(6 downto 0);
		F2: in  std_logic_vector(6 downto 0);
		F3: in  std_logic_vector(6 downto 0);
		F4: in  std_logic_vector(6 downto 0);
		sel: in  std_logic_vector(1 downto 0);
		F: out  std_logic_vector(6 downto 0));
end  component;

-- OK
component multiplexador72 is	
port (F1: in  std_logic_vector(6 downto 0);
		F2: in  std_logic_vector(6 downto 0);
		sel: in  std_logic;
		F: out  std_logic_vector(6 downto 0));
end component;

-- OK
component multiplexador16 is	
port (F1: in  std_logic_vector(15 downto 0);
		F2: in  std_logic_vector(15 downto 0);
		F3: in  std_logic_vector(15 downto 0);
		F4: in  std_logic_vector(15 downto 0);
		sel: in  std_logic_vector(1 downto 0);
		F: out  std_logic_vector(15 downto 0));
end component;

-- OK
component decodtermo is
port (X: in  std_logic_vector(3 downto 0);
			S: out std_logic_vector(15 downto 0));
end component;

-- OK
component decod7seg is
port (G: in  std_logic_vector(3 downto 0);
			S: out std_logic_vector(6 downto 0));
end component;

-- OK
component counter_time is
port( R: in std_logic;
	  	E: in std_logic;
	  	clock: in std_logic;
	  	ended: out std_logic;
	  	count: out std_logic_vector(3 downto 0)
    );
end component;

-- OK
component counter_round is
port( R: in std_logic;
	 		E: in std_logic;
	 		clock: in std_logic;
	 		end_round: out std_logic;
     	X: out std_logic_vector(3 downto 0)
);
end component;

-- OK
component comp_3bits is 
port(A, B: in  std_logic_vector(2 downto 0);
     R: out std_logic);
end component;

-- OK
component comp_4bits is 
port(A, B: in  std_logic_vector(3 downto 0);
     R: out std_logic);
end component;

-- OK: retorna quantos dígitos são iguais
component comp_e is 
port(inc, inu: in  std_logic_vector(15 downto 0);
     E: out std_logic_vector(2 downto 0));
end component;

-- OK
component Div_Freq_DE2 is -- Usar esse componente para a placa DE2
port (	clk: in std_logic;
	reset: in std_logic;
	CLK_1Hz: out std_logic
	);
end component;

-- OK
component Div_Freq is -- Usar esse componente para o emulador
port (	clk: in std_logic;
	reset: in std_logic;
	CLK_1Hz, sim_2hz: out std_logic
	);
end component;

begin -- WARN: the #HEXADECIMAL colors comments represents the diagram elements in the docs!

  --#707070
  --DIVFREQ: div_Freq_DE2 port map(clk, R1, clock_s); 	-- usar esse componente para a placa	
  DIVFREQ_EMU: div_freq 	port map (clk, R1, clock_s);	-- usar esse componente para o emulador
  SELEC: selector 				port map (E1, E2, R1, E5, SEL_MUX);
  COMPE: comp_e 					port map (CODE, USER, E);

  --#6666FF
  REG_6:  registrador6  port map(clk, R2, E1, S(5 downto 0), SEL);
  REG_16: registrador16 port map(clk, R2, E2, S(15 downto 0), USER);
  REG_P: registrador3  port map(clk, R2, E4, P, P_REG);
  REG_E: registrador3  port map(clk, R2, E4, E, E_REG);

  --#FFFF00
  COUNTER_TIME_LABEL:   counter_time  port map(R1, E2, clock_s, end_time_s, TIME_s);
	COUNTER_ROUND_LABEL:  counter_round port map(R2, E3, clk, end_round_s, X);

  --#FFA500
  COMP_SUM0: comp_4bits port map(CODE(3 downto 0), USER(3 downto 0), comp0_s);
  COMP_SUM1: comp_4bits port map(CODE(7 downto 4), USER(7 downto 4), comp1_s);
  COMP_SUM2: comp_4bits port map(CODE(11 downto 8), USER(11 downto 8), comp2_s);
  COMP_SUM3: comp_4bits port map(CODE(15 downto 12), USER(15 downto 12), comp3_s);
  COMP_END: comp_3bits port map(P, "100", end_game_s);
  -- The LEDR output
  DECOD_LED: decodtermo port map(X, decodtermo_s);
 	LED <= (decodtermo_s) when E1='0' else (others=>'0');

	--#BBFF55
	-- All the HEX outputs
	DEC_HEX7: decod7seg 			port map(RESULT(7 downto 4), dec_result7to4_hex7);
	DEC_HEX6: decod7seg 			port map(RESULT(3 downto 0), dec_result3to0_hex7);
	DEC_HEX4: decod7seg 			port map(TIME_s, dec_time_hex4);
	DEC0_HEX3: decod7seg 			port map(USER(15 downto 12), dec_user_hex3);
	DEC1_HEX3: decod7seg 			port map(CODE(15 downto 12), dec_code_hex3);

	in_dec_preg_hex2 <= ('0' & P_REG(2 downto 0));
	DEC1_HEX2: decod7seg 			port map(SEL(5 downto 2), dec_sel_hex2);
	DEC2_HEX2: decod7seg 			port map(USER(11 downto 8), dec_user_hex2);
	DEC3_HEX2: decod7seg 			port map(in_dec_preg_hex2, dec_preg_hex2);
	DEC0_HEX2: decod7seg 			port map(CODE(11 downto 8), dec_code_hex2);

	DEC0_HEX1: decod7seg 			port map(USER(7 downto 4), dec_user_hex1);
	DEC1_HEX1: decod7seg 			port map(CODE(7 downto 4), dec_code_hex1);

	in_dec_sel_hex0 <= "00" & SEL(1 downto 0);
	in_dec_ereg_hex0 <= '0' & E_REG(2 downto 0);
	DEC0_HEX0: decod7seg 			port map(in_dec_sel_hex0, dec_sel_hex0);
	DEC1_HEX0: decod7seg 			port map(USER(3 downto 0), dec_user_hex0);
	DEC2_HEX0: decod7seg 			port map(in_dec_ereg_hex0, dec_ereg_hex0);
	DEC3_HEX0: decod7seg 			port map(CODE(3 downto 0), dec_code_hex0);

	MUX_HEX7: multiplexador72 port map("1111111", dec_result7to4_hex7, E5, HEX7);
	MUX_HEX6: multiplexador72 port map("1111111", dec_result3to0_hex7, E5, HEX6);
	MUX_HEX5: multiplexador72 port map("1111111", "0000111", E2, HEX5); -- HACK: "0000111" ==> t
	MUX_HEX4: multiplexador72 port map("1111111", dec_time_hex4, E2, HEX4);
	MUX_HEX3: multiplexador74 port map("1000110", dec_user_hex3, "0001100", dec_user_hex3, SEL_MUX, HEX3); -- HACK: c="1000110" p="0001100"
	MUX_HEX2: multiplexador74 port map(dec_sel_hex2, dec_user_hex2, dec_preg_hex2, dec_code_hex2, SEL_MUX, HEX2);
	MUX_HEX1: multiplexador74 port map("1000111", dec_user_hex1, "0000110", dec_code_hex1, SEL_MUX, HEX1); -- HACK: E="0000110", L="1000111";
	MUX_HEX0: multiplexador74 port map(dec_sel_hex0, dec_user_hex0, dec_ereg_hex0, dec_code_hex0, SEL_MUX, HEX0);
	-- -- The remaining light green logic
	SOMA_X: somadormenor port map(X, "0001", somadormenor_s);
	SOMA_P: somadormaior port map(comp0_s, comp1_s, comp2_s, comp3_s, P);

 	F <= (not somadormenor_s) when end_time_s='0' else (others=>'0');
 	RESULT <= "000" & end_game_s & F;

	--#00FF00
	ROM0_LABEL: ROM0  port map(SEL(5 downto 2), rom0_s);
	ROM1_LABEL: ROM1  port map(SEL(5 downto 2), rom1_s);
	ROM2_LABEL: ROM2  port map(SEL(5 downto 2), rom2_s);
	ROM3_LABEL: ROM3  port map(SEL(5 downto 2), rom3_s);
	MUX_ROM: multiplexador16 port map(rom0_s, rom1_s, rom2_s, rom3_s, SEL(1 downto 0), CODE);
	 --

	-- outputs
	end_game 	<= end_game_s;
	end_time 	<= end_time_s;
	end_round <= end_round_s;
end arqdtp;
