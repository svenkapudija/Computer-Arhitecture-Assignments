                       BVJ1		`EQU 0FFFF1000 
                       		 
                       UVJ2POD		`EQU 0FFFF2000 
                       UVJ2STAT	`EQU 0FFFF2004 
                       		 
                       PVJ3POD		`EQU 0FFFF3000 
                       PVJ3IACK	`EQU 0FFFF3004 
                       PVJ3END		`EQU 0FFFF3008 
                       PVJ3STOP	`EQU 0FFFF300C 
                       		 
                       		`ORG 0 
00000000  00 10 80 07  		MOVE 1000, SP 
00000004  04 00 00 D4  		JR GLAVNI 
                       		 
                       		`ORG 8 
00000008  00 05 00 00  		DW 500 
                       		 
0000000C  90 00 10 04  GLAVNI	MOVE %B 10010000, SR 
00000010  01 00 00 04  		MOVE 1, R0 
00000014  0C 30 0F B8  		STORE R0, (PVJ3STOP) 
00000018  00 00 00 F8  		HALT 
0000001C  04 20 0F B0  PETLJA	LOAD R0, (UVJ2STAT) 
00000020  00 00 00 08  		OR R0, R0, R0 
00000024  F4 FF CF D5  		JR_Z PETLJA 
                       		 
00000028  78 00 80 B2  		LOAD R5, (BROJ) 
0000002C  00 20 8F BA  		STORE R5, (UVJ2POD) 
00000030  04 20 8F BA  		STORE R5, (UVJ2STAT) 
                       		 
00000034  7C 00 00 B3  		LOAD R6, (BROJPOD) 
00000038  01 00 60 27  		ADD R6, 1, R6 
0000003C  7C 00 00 BB  		STORE R6, (BROJPOD) 
                       		 
00000040  D8 FF 0F D4  		JR PETLJA 
                        
00000044  00 00 80 89  OBRADI	PUSH R3 
00000048  00 00 A0 01  		MOVE SR, R3 
0000004C  00 00 80 89  		PUSH R3 
                       		 
00000050  01 00 00 04  		MOVE 1, R0 
00000054  0C 00 F0 B5  		LOAD R3, (SP+0C) 
                       		 
00000058  00 00 06 50  		SHL R0, R3, R0 
                       		 
0000005C  00 00 80 81  		POP R3 
00000060  00 00 16 00  		MOVE R3, SR 
00000064  00 00 80 81  		POP R3 
                       		 
00000068  00 00 00 D8  		RET 
                       		 
0000006C  00 00 00 04  KRAJ	MOVE 0, R0 
00000070  0C 30 0F B8  		STORE R0, (PVJ3STOP) 
00000074  00 00 00 F8  		HALT 
                       		 
00000078  00 00 00 00  BROJ 	DW 0 
0000007C  00 00 00 00  BROJPOD	DW 0 
                        
                       		`ORG 500 
                       		 
00000500  00 00 80 88  PREKID	PUSH R1 
00000504  00 00 A0 00  		MOVE SR, R1 
00000508  00 00 80 88  		PUSH R1 
                       		 
0000050C  04 30 8F B8  		STORE R1, (PVJ3IACK) 
                       		 
00000510  00 10 8F B0  		LOAD R1, (BVJ1) 
00000514  00 00 92 08  		OR R1, R1, R1 
00000518  50 FB 4F D4  		JR_N KRAJ 
                       		 
0000051C  00 00 80 88  		PUSH R1 
00000520  44 00 00 CC  		CALL OBRADI 
00000524  04 00 F0 27  		ADD SP, 4, SP 
00000528  78 00 00 B8  		STORE R0, (BROJ) 
0000052C  7C 00 00 B0  		LOAD R0, (BROJPOD) 
00000530  00 30 0F B8  		STORE R0, (PVJ3POD) 
                       		 
00000534  00 00 80 80  		POP R1 
00000538  00 00 12 00  		MOVE R1, SR 
0000053C  00 00 80 80  		POP R1 
00000540  08 30 0F B8  		STORE R0, (PVJ3END) 
00000544  01 00 00 D8  		RETI 
                        
