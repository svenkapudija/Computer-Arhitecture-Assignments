                       BVJ1		`EQU 0FFFFFFFC 
                        
                       CT_LR		`EQU 0FFFF0000 
                       CT_CR		`EQU 0FFFF0004 
                       CT_CLR		`EQU 0FFFF0008 
                       CT_END		`EQU 0FFFF000C 
                        
                       DMA_SRC		`EQU 0FFFF1000 
                       DMA_DEST	`EQU 0FFFF1004 
                       DMA_SIZE	`EQU 0FFFF1005 
                       DMA_CTRL	`EQU 0FFFF100C 
                       DMA_START	`EQU 0FFFF1010 
                       DMA_IACK	`EQU 0FFFF1014 
                        
                       		`ORG 0 
                       		 
                       		; inicijalizacija DMA-sklopa 
00000000  E8 03 00 04  		MOVE %D 1000, R0		; 100 mikro-sekundi, 10 Mhz -> 1000 i
00000004  04 00 0F B8  		STORE R0, (CT_CR) 
                       		 
00000008  02 00 00 04  		MOVE %B 10, R0			; broji, bez prekida 
0000000C  04 00 0F B8  		STORE R0, (CT_CR) 
                       		 
00000010  F0 01 80 05  		MOVE 01F0, R3			; spremi prvu adresu izvora 
00000014  0A 00 00 06  		MOVE %D 10, R4			; brojac blokova 
                       		 
00000018  04 00 0F B0  CT		LOAD R0, (CT_CR)		; cekanje CT-a 
0000001C  00 00 00 08  		OR R0, R0, R0 
00000020  F4 FF CF D5  		JR_Z CT 
                       		 
00000024  08 00 0F B8  		STORE R0, (CT_CLR)		; brisanje bistabila stanja 
00000028  0C 00 0F B8  		STORE R0, (CT_END)		; kraj posluzivanja 
                       		 
0000002C  FC FF 0F 04  		MOVE BVJ1, R0 
00000030  00 10 0F B8  		STORE R0, (DMA_SRC)		; u SRC je sada adresa izvora 
00000034  04 10 8F B9  		STORE R3, (DMA_DEST)	; u DEST je sada adresa odredista 
00000038  0A 00 00 04  		MOVE %D 10, R0			; kolicina podataka koju prenosi 
0000003C  05 10 0F B8  		STORE R0, (DMA_SIZE) 
00000040  06 00 00 04  		MOVE %B 0110, R0		; iz VJ u mem, krada ciklusa, no int 
00000044  0C 10 0F B8  		STORE R0, (DMA_CTRL) 
00000048  10 10 0F B8  		STORE R0, (DMA_START)	; pokreni DMA 
                       		 
0000004C  0C 10 0F B0  DMA		LOAD R0, (DMA_CTRL)		; provjeri stanje 
00000050  00 00 00 08  		OR R0, R0, R0 
00000054  F4 FF CF D5  		JR_Z DMA 
                       		 
                       		; prijenos gotov 
00000058  14 10 0F B8  		STORE R0, (DMA_IACK) 
0000005C  28 00 B0 25  		ADD R3, %D 40, R3 
                       		 
00000060  01 00 40 36  		SUB R4, 1, R4 
00000064  B0 FF 0F D6  		JR_NZ CT 
                       	 
00000068  00 00 00 04  KRAJ	MOVE %B 00, R0 
0000006C  04 00 0F B8  		STORE R0, (CT_CR)		; zaustavi CT 
00000070  00 00 00 F8  		HALT 
