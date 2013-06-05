                       		`ORG 0 
00000000  50 00 80 04  		MOVE	50, R1 
00000004  70 00 00 05  		MOVE	70, R2 
00000008  2C 00 80 B1  		LOAD	R3, (NULA)	; sluzit ce za prekid petlje 
                       	 
0000000C  00 00 10 B4  LOOP	LOAD	R0, (R1) 
00000010  00 00 20 BC  		STORE 	R0, (R2) 
00000014  00 00 06 68  		CMP		R0, R3		; usporedi R0 i R3 
00000018  0C 00 C0 D5  		JR_EQ	END			; provjeri je su li jednaki (tj. R0 == 0) 
                       							; ako jesu, zavrsi petlju 
0000001C  04 00 90 24  		ADD		R1, 4, R1 
00000020  04 00 20 25  		ADD		R2, 4, R2 
00000024  E4 FF 0F D4  		JR		LOOP 
                       		 
00000028  00 00 00 F8  END		HALT 
                        
0000002C  00 00 00 00  NULA	DW 0 
                        
                       		`ORG	50 
00000050  01 00 00 00  		DW		1,2,3,0 
          02 00 00 00  
          03 00 00 00  
          00 00 00 00  
                       		 
                       		`ORG	70 
                       		`DS		%D 20 
                       		`END 
