library ieee;
use ieee.std_logic_1164.all;

entity controle is port(
    clock,K1,K0,endtime,endgame,endround: in std_logic;			  
    R1,R2,E1,E2,E3,E4,E5: out std_logic);
end controle;

architecture bhv of controle is
    type STATES is (W,INIT,SETUP,PLAY,COUNTROUND,CHECK,RESULT);
    signal EA, PE: STATES;
begin
	P1: process(clock,K0)
	begin
			if K0 = '1' then
				EA <= INIT;
			elsif clock'event and clock = '1' then
				EA <= PE;
			end if;
	end process;
	
	P2: process(EA,K1,endtime,endgame,endround)
	begin
		case EA is
			  when INIT =>
			 		R1<= '1'; -- OK
			 		R2<= '1'; -- OK
			 		E1<= '0';
			 		E2<= '0';
			 		E3<= '0';
			 		E4<= '0';
			 		E5<= '0';
					PE <= SETUP;
			  when SETUP =>
			 		R1<= '0';
			 		R2<= '0';
			 		E1<= '1'; -- OK
			 		E2<= '0';
			 		E3<= '0';
			 		E4<= '0';
			 		E5<= '0';
			  	if K1='1' then
			  		PE <= PLAY;
			  	else
			  		PE <= SETUP;
			  	end if;
			  when PLAY =>
  				 R1<= '0';
					 R2<= '0';
					 E1<= '0';
					 E2<= '1'; -- OK
					 E3<= '0';
					 E4<= '0';
					 E5<= '0';
		  		 if K1='1' then
		  			 PE <= COUNTROUND;
		  		 elsif endtime='1' then
		  			 PE <= RESULT;
		  			else
		  				PE <= PLAY;
		  		end if;
			  when COUNTROUND =>
			 		R1<= '0';
			 		R2<= '0';
			 		E1<= '0';
			 		E2<= '0';
			 		E3<= '1'; -- OK
			 		E4<= '0';
			 		E5<= '0';
		  		PE <= CHECK;
			  when CHECK =>
    			R1<= '0';
					R2<= '0';
					E1<= '0';
					E2<= '0';
					E3<= '0';
					E4<= '1';
					E5<= '0';
		  		if endround='1' or endgame='1' then
		  			PE <= RESULT;
		  		else
		  			PE <= W;
		  		end if;
		    when W =>
  		 		R1<= '1';
			 		R2<= '0';
			 		E1<= '0';
			 		E2<= '0';
			 		E3<= '0';
			 		E4<= '0';
			 		E5<= '0';
		    	if K1='1' then
		    		PE <= PLAY;
		    	else
		    		PE <= W;
		    	end if;
			  when RESULT =>
			 		R1<= '0';
			 		R2<= '0';
			 		E1<= '0';
			 		E2<= '0';
			 		E3<= '0';
			 		E4<= '0';
			 		E5<= '1'; -- OK
		    	if K1='1' then
		    		PE <= INIT;
		    	else
		    		PE <= RESULT;
		    	end if;
		end case;
	end process;
end bhv;

