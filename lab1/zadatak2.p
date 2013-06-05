                       		`ORG 0 
                       		 
00000000  00 00 81 07  		MOVE 10000, R7 
00000004  0D 00 00 05  		MOVE 0D, R2 
00000008  40 00 80 05  		MOVE BLOK, R3 
0000000C  00 00 00 07  		MOVE 0, R6 
                       		 
00000010  00 00 30 96  LOOP	LOADB R4, (R3) 
00000014  00 00 00 8A  			PUSH R4 
00000018  4C 00 00 CC  			CALL PAR 
0000001C  04 00 F0 27  			ADD R7, 4, R7 
                       			 
00000020  00 00 40 68  			CMP R4, R0 
                       			 
00000024  08 00 C0 D5  			JR_EQ CONT 
00000028  00 00 30 9C  				STOREB R0, (R3) 
0000002C  01 00 60 27  				ADD R6, 1, R6 
00000030  01 00 B0 25  CONT		ADD R3, 1, R3 
00000034  01 00 20 35  			SUB R2, 1, R2 
00000038  D4 FF 0F D6  		JR_NZ LOOP 
                       		 
0000003C  00 00 00 F8  		HALT 
                       		 
00000040  01 00 0E 0B  BLOK 	DB 1, 0, 0E, 0B, 36, 0F2, 3, 2, 0FE, 0F8, 7E, 8F 
          36 F2 03 02  
          FE F8 7E 8F  
                        
                       ; /*** potprogram PAR ***/ 
                        
0000004C  00 00 00 89  PAR		PUSH R2 
00000050  00 00 80 89  		PUSH R3 
00000054  0C 00 70 94  		LOADB R0, (R7+0C) 
00000058  08 00 00 05  		MOVE 8, R2 
0000005C  00 00 80 05  		MOVE 0, R3 
                       		 
00000060  01 00 00 4C  LOOP_1	ROTR R0, 1, R0 
00000064  04 00 00 D5  			JR_NC CONT_1 
00000068  01 00 B0 1D  				XOR R3, 1, R3 
0000006C  01 00 20 35  CONT_1		SUB R2, 1, R2 
00000070  EC FF 0F D6  		JR_NZ LOOP_1 
                       		 
00000074  08 00 00 44  		ROTL R0, 8, R0 
                       		 
00000078  00 00 B6 09  		OR R3, R3, R3 
0000007C  04 00 C0 D5  		JR_Z FINISH 
00000080  80 00 00 1C  			XOR R0, 80, R0 
00000084  00 00 80 81  FINISH	POP R3 
00000088  00 00 00 81  		POP R2 
0000008C  00 00 00 D8  		RET 
