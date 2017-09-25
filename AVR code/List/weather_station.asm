
;CodeVisionAVR C Compiler V2.05.3 Standard
;(C) Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega8
;Program type             : Application
;Clock frequency          : 1.843200 MHz
;Memory model             : Small
;Optimize for             : Size
;(s)printf features       : long, width, precision
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 256 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : Yes
;'char' is unsigned       : Yes
;8 bit enums              : Yes
;Global 'const' stored in FLASH     : No
;Enhanced function parameter passing: Yes
;Enhanced core instructions         : On
;Smart register allocation          : On
;Automatic register allocation      : On

	#pragma AVRPART ADMIN PART_NAME ATmega8
	#pragma AVRPART MEMORY PROG_FLASH 8192
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1119
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	RCALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _ac1=R4
	.DEF _ac2=R6
	.DEF _ac3=R8
	.DEF _b1=R10
	.DEF _b2=R12

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	RJMP __RESET
	RJMP _ext_int0_isr
	RJMP _ext_int1_isr
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP _timer1_compa_isr
	RJMP 0x00
	RJMP _timer1_ovf_isr
	RJMP 0x00
	RJMP 0x00
	RJMP _usart_rx_isr
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00

;REGISTER BIT VARIABLES INITIALIZATION
__REG_BIT_VARS:
	.DW  0x0000

_0x64:
	.DB  0x0,0x0,0x80,0xC0
_0x65:
	.DB  0x54,0xE3,0x25,0x3D
_0x66:
	.DB  0xA2,0xE7,0x3B,0xB6
_0x67:
	.DB  0xA,0xD7,0x23,0x3C
_0x68:
	.DB  0xAC,0xC5,0xA7,0x38
_0x0:
	.DB  0x4F,0x4B,0xA,0x0,0x41,0x25,0x64,0x42
	.DB  0x25,0x64,0x43,0x25,0x64,0x44,0x25,0x64
	.DB  0x45,0x25,0x64,0x46,0x25,0x64,0x47,0x25
	.DB  0x6C,0x64,0x48,0x25,0x64,0x49,0x25,0x64
	.DB  0x4A,0x25,0x64,0x4B,0x25,0x64,0x5A,0xA
	.DB  0x0,0x44,0x31,0x32,0x33,0x34,0x35,0x36
	.DB  0x37,0x38,0x39,0x30,0x31,0x32,0x33,0x34
	.DB  0x35,0x36,0x37,0x38,0x39,0x30,0x31,0x32
	.DB  0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x30
	.DB  0xA,0x0,0x4C,0x25,0x64,0x5A,0xA,0x0
	.DB  0x54,0x25,0x64,0x5A,0xA,0x0,0x50,0x25
	.DB  0x64,0x5A,0xA,0x0,0x57,0xA,0x0,0x53
	.DB  0xA,0x0,0x30,0x31,0x32,0x33,0x34,0x35
	.DB  0x36,0x37,0x38,0x39,0x30,0x61,0x62,0x63
	.DB  0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B
	.DB  0x6C,0x6D,0x6E,0x6F,0x70,0x71,0x72,0x73
	.DB  0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0xD
	.DB  0xA,0x0
_0x2020060:
	.DB  0x1
_0x2020000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  0x02
	.DW  __REG_BIT_VARS*2

	.DW  0x01
	.DW  __seed_G101
	.DW  _0x2020060*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;#include <mega8.h> //1.8432MHz
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <stdio.h>
;#include <stdlib.h>
;#include <delay.h>
;#include <bcd.h>
;#include <sleep.h>
;#include <math.h>
;#include <ds3231.c>
;#include <i2c.h>
;
;void alarm_mati(){
; 0000 0008 void alarm_mati(){

	.CSEG
_alarm_mati:
;i2c_start();
	RCALL SUBOPT_0x0
;i2c_write(0xd0);
;i2c_write(15);
	LDI  R26,LOW(15)
	RCALL _i2c_write
;i2c_write(0b00000000);
	LDI  R26,LOW(0)
	RJMP _0x20E0004
;i2c_stop();
;}
;
;void set_rtc(){
_set_rtc:
;i2c_start();
	RCALL SUBOPT_0x0
;i2c_write(0xd0);
;i2c_write(14); //control 0x0E
	LDI  R26,LOW(14)
	RCALL _i2c_write
;i2c_write(0b00000110); //bit7=disable osc, bit2=alarm enable bit1=alarm2 enable
	LDI  R26,LOW(6)
_0x20E0004:
	RCALL _i2c_write
;i2c_stop();
	RCALL _i2c_stop
;}
	RET
;
;void set_alarm(unsigned char jam,unsigned char menit){
_set_alarm:
;i2c_start();
	ST   -Y,R26
;	jam -> Y+1
;	menit -> Y+0
	RCALL SUBOPT_0x0
;i2c_write(0xd0);
;i2c_write(11);
	LDI  R26,LOW(11)
	RCALL SUBOPT_0x1
;i2c_write(bin2bcd(menit)&0b01111111);
	ANDI R30,0x7F
	RCALL SUBOPT_0x2
;i2c_write(bin2bcd(jam)&0b01111111);
	LDD  R26,Y+1
	RCALL _bin2bcd
	ANDI R30,0x7F
	RCALL SUBOPT_0x2
;i2c_write(0b10000000);
	LDI  R26,LOW(128)
	RCALL _i2c_write
;i2c_stop();
	RCALL _i2c_stop
;}
	ADIW R28,2
	RET
;
;void set_waktu(unsigned char jam,unsigned char menit,unsigned char detik){
_set_waktu:
;i2c_start();
	ST   -Y,R26
;	jam -> Y+2
;	menit -> Y+1
;	detik -> Y+0
	RCALL SUBOPT_0x0
;i2c_write(0xd0);
;i2c_write(0);
	LDI  R26,LOW(0)
	RCALL SUBOPT_0x1
;i2c_write(bin2bcd(detik));
	RCALL SUBOPT_0x2
;i2c_write(bin2bcd(menit));
	LDD  R26,Y+1
	RCALL _bin2bcd
	RCALL SUBOPT_0x2
;i2c_write(bin2bcd(jam));
	LDD  R26,Y+2
	RCALL _bin2bcd
	RCALL SUBOPT_0x2
;i2c_stop();
	RCALL _i2c_stop
;}
	RJMP _0x20E0001
;
;void jam_brp(unsigned char *jam,unsigned char *menit,unsigned char *detik){
_jam_brp:
;i2c_start();
	ST   -Y,R27
	ST   -Y,R26
;	*jam -> Y+4
;	*menit -> Y+2
;	*detik -> Y+0
	RCALL SUBOPT_0x0
;i2c_write(0xd0);
;i2c_write(0);
	LDI  R26,LOW(0)
	RCALL SUBOPT_0x3
;i2c_start();
;i2c_write(0xd1);
;*detik=bcd2bin(i2c_read(1));
	LD   R26,Y
	LDD  R27,Y+1
	RCALL SUBOPT_0x4
;*menit=bcd2bin(i2c_read(1));
;*jam=bcd2bin(i2c_read(0));
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X,R30
;i2c_stop();
	RCALL _i2c_stop
;}
	RJMP _0x20E0003
;
;void tgl_brp(unsigned char *tanggal,unsigned char *bulan,unsigned char *tahun){
_tgl_brp:
;i2c_start();
	RCALL SUBOPT_0x5
;	*tanggal -> Y+4
;	*bulan -> Y+2
;	*tahun -> Y+0
	RCALL SUBOPT_0x0
;i2c_write(0xd0);
;i2c_write(4);
	LDI  R26,LOW(4)
	RCALL SUBOPT_0x3
;i2c_start();
;i2c_write(0xd1);
;*tanggal=bcd2bin(i2c_read(1));
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	RCALL SUBOPT_0x4
;*bulan=bcd2bin(i2c_read(1));
;*tahun=bcd2bin(i2c_read(0));
	LD   R26,Y
	LDD  R27,Y+1
	ST   X,R30
;i2c_stop();
	RCALL _i2c_stop
;}
	RJMP _0x20E0003
;
;void set_tgl(unsigned char tanggal,unsigned char bulan,unsigned char tahun){
_set_tgl:
;i2c_start();
	ST   -Y,R26
;	tanggal -> Y+2
;	bulan -> Y+1
;	tahun -> Y+0
	RCALL SUBOPT_0x0
;i2c_write(0xd0);
;i2c_write(4);
	LDI  R26,LOW(4)
	RCALL _i2c_write
;i2c_write(bin2bcd(tanggal));
	LDD  R26,Y+2
	RCALL _bin2bcd
	RCALL SUBOPT_0x2
;i2c_write(bin2bcd(bulan));
	LDD  R26,Y+1
	RCALL _bin2bcd
	MOV  R26,R30
	RCALL SUBOPT_0x1
;i2c_write(bin2bcd(tahun));
	RCALL SUBOPT_0x2
;i2c_stop();
	RCALL _i2c_stop
;}
	RJMP _0x20E0001
;#include <sht11.c>
;typedef union
;{ unsigned int i;
;  float f;
;} value;
;
;enum {TEMP,HUMI};
;
;#define        DATA_OUT           PORTC.2
;#define        DATA_IN            PINC.2
;#define        SCK                PORTC.3
;#define noACK 0
;#define ACK   1
;                            //adr  command  r/w
;#define STATUS_REG_W 0x06   //000   0011    0
;#define STATUS_REG_R 0x07   //000   0011    1
;#define UKUR_SUHU    0x03   //000   0001    1
;#define UKUR_HUMI    0x05   //000   0010    1
;#define RESET        0x1e   //000   1111    0
;
;unsigned int nilaisuhu[2]={0,0};
;
;//Untuk menulis data ke SHT11
;char tulis_SHT(unsigned char bytte)
; 0000 0009 {
_tulis_SHT:
;  unsigned char i,error=0;
;  DDRC.2=1;
	ST   -Y,R26
	RCALL __SAVELOCR2
;	bytte -> Y+2
;	i -> R17
;	error -> R16
	LDI  R16,0
	SBI  0x14,2
;  for (i=0x80;i>0;i/=2) //shift bit
	LDI  R17,LOW(128)
_0x6:
	CPI  R17,1
	BRLO _0x7
;  {
;    if (i & bytte)
	LDD  R30,Y+2
	AND  R30,R17
	BREQ _0x8
;    DATA_OUT=1;
	SBI  0x15,2
;    else DATA_OUT=0;
	RJMP _0xB
_0x8:
	CBI  0x15,2
;    SCK=1;       //clk
_0xB:
	RCALL SUBOPT_0x6
;    delay_us(1); //delay 5 us
;    SCK=0;
	CBI  0x15,3
;  }
	RCALL SUBOPT_0x7
	RJMP _0x6
_0x7:
;  DATA_OUT=1;
	SBI  0x15,2
;  DDRC.2=0;
	CBI  0x14,2
;  SCK=1;                //clk #9 ack
	RCALL SUBOPT_0x6
;  delay_us(1);
;  error=DATA_IN;        //cek ack (DATA akan di pull down oleh SHT11)
	LDI  R30,0
	SBIC 0x13,2
	LDI  R30,1
	MOV  R16,R30
;  delay_us(1);
	RCALL SUBOPT_0x8
;  SCK=0;
;  return error;         //cek jika ada error
	MOV  R30,R16
	RCALL __LOADLOCR2
	RJMP _0x20E0001
;}
;
;//Untuk membaca data dari SHT11
;char baca_SHT(unsigned char ack)
;{
_baca_SHT:
;  unsigned char i,val=0;
;  DDRC.2=0;                // DATA Input
	ST   -Y,R26
	RCALL __SAVELOCR2
;	ack -> Y+2
;	i -> R17
;	val -> R16
	LDI  R16,0
	CBI  0x14,2
;  for (i=0x80;i>0;i/=2)             //shift bit
	LDI  R17,LOW(128)
_0x1D:
	CPI  R17,1
	BRLO _0x1E
;  { SCK=1;                          //clk
	RCALL SUBOPT_0x6
;    delay_us(1);
;    if (DATA_IN) val=(val | i);     //baca bit
	SBIC 0x13,2
	OR   R16,R17
;    delay_us(1);
	RCALL SUBOPT_0x8
;    SCK=0;
;  }
	RCALL SUBOPT_0x7
	RJMP _0x1D
_0x1E:
;  DDRC.2=1;
	SBI  0x14,2
;  DATA_OUT=!ack;        //"ack==1" pull down DATA-Line
	LDD  R30,Y+2
	CPI  R30,0
	BREQ _0x26
	CBI  0x15,2
	RJMP _0x27
_0x26:
	SBI  0x15,2
_0x27:
;  SCK=1;                //clk #9 ack
	RCALL SUBOPT_0x6
;  delay_us(1);          //delay 5 us
;  SCK=0;
	CBI  0x15,3
;  DATA_OUT=1;           //DATA-line
	SBI  0x15,2
;  return val;
	MOV  R30,R16
	RCALL __LOADLOCR2
	RJMP _0x20E0001
;}
;//----------------------------------------------------------------------------------
;// menghasilkan sinyal awal untuk transmisi data
;//       _____         ________
;// DATA:      |_______|
;//           ___     ___
;// SCK : ___|   |___|   |______
;//----------------------------------------------------------------------------------
;
;//Untuk memulai transmisi data
;void start_SHT(void)
;{
_start_SHT:
;   DDRC.2=1;
	SBI  0x14,2
;   DATA_OUT=1; SCK=0;   //Inisial state
	SBI  0x15,2
	RCALL SUBOPT_0x9
;   delay_us(1);
;   SCK=1;
	RCALL SUBOPT_0x6
;   delay_us(1);
;   DATA_OUT=0;
	CBI  0x15,2
;   delay_us(1);
	RCALL SUBOPT_0x8
;   SCK=0;
;   delay_us(1);
	__DELAY_USB 1
;   SCK=1;
	RCALL SUBOPT_0x6
;   delay_us(1);
;   DATA_OUT=1;
	SBI  0x15,2
;   delay_us(1);
	RCALL SUBOPT_0x8
;   SCK=0;
;   DDRC.2=0;
	CBI  0x14,2
;}
	RET
;//----------------------------------------------------------------------------------
;// reset: DATA-line=1 dengan 9 SCK cycle di awal
;//       _____________________________________________________         ________
;// DATA:                                                      |_______|
;//          _    _    _    _    _    _    _    _    _        ___     ___
;// SCK : __| |__| |__| |__| |__| |__| |__| |__| |__| |______|   |___|   |______
;//----------------------------------------------------------------------------------
;
;//Untuk mereset koneksi dengan SHT11
;void reset_SHT(void)
;{
_reset_SHT:
;  unsigned char i;
;  DDRC.2=1;
	ST   -Y,R17
;	i -> R17
	SBI  0x14,2
;  DATA_OUT=1; SCK=0;    //Inisial state
	SBI  0x15,2
	CBI  0x15,3
;  for(i=0;i<9;i++)      //9 SCK cycle
	LDI  R17,LOW(0)
_0x49:
	CPI  R17,9
	BRSH _0x4A
;  { SCK=1;
	RCALL SUBOPT_0x6
;    delay_us(1);
;    SCK=0;
	RCALL SUBOPT_0x9
;    delay_us(1);
;  }
	SUBI R17,-1
	RJMP _0x49
_0x4A:
;  start_SHT();          //start transmisi data
	RCALL _start_SHT
;  DDRC.2=0;
	CBI  0x14,2
;}
	LD   R17,Y+
	RET
;
;//Mengecek status register sensor
;char StatusReg_SHT(unsigned char *p_value, unsigned char *p_checksum)
;{
_StatusReg_SHT:
;  unsigned char error=0;
;  start_SHT();                   //start transmisi data
	RCALL SUBOPT_0x5
	ST   -Y,R17
;	*p_value -> Y+3
;	*p_checksum -> Y+1
;	error -> R17
	LDI  R17,0
	RCALL _start_SHT
;  error=tulis_SHT(STATUS_REG_R); //mengirim command ke sensor
	LDI  R26,LOW(7)
	RCALL _tulis_SHT
	MOV  R17,R30
;  *p_value=baca_SHT(ACK);        //baca status register (8-bit)
	RCALL SUBOPT_0xA
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	ST   X,R30
;  *p_checksum=baca_SHT(noACK);   //baca checksum (8-bit)
	LDI  R26,LOW(0)
	RCALL _baca_SHT
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ST   X,R30
;  return error;               //error=1 jika tidak ada respon dari sensor
	MOV  R30,R17
	LDD  R17,Y+0
	ADIW R28,5
	RET
;}
;
;//Membaca data hasil pengukuran
;char ukur_SHT(unsigned char *p_checksum, unsigned char mode)
;{
_ukur_SHT:
;  unsigned error=0;
; unsigned int temp=0;
;  start_SHT();                   //start transmisi data
	ST   -Y,R26
	RCALL __SAVELOCR4
;	*p_checksum -> Y+5
;	mode -> Y+4
;	error -> R16,R17
;	temp -> R18,R19
	__GETWRN 16,17,0
	RCALL SUBOPT_0xB
	RCALL _start_SHT
;
;  switch(mode){                     //mengirim command ke sensor
	RCALL SUBOPT_0xC
;    case TEMP        : error+=tulis_SHT(UKUR_SUHU); break;
	BRNE _0x54
	LDI  R26,LOW(3)
	RCALL SUBOPT_0xD
	RJMP _0x53
;    case HUMI        : error+=tulis_SHT(UKUR_HUMI); break;
_0x54:
	RCALL SUBOPT_0xE
	BRNE _0x56
	LDI  R26,LOW(5)
	RCALL SUBOPT_0xD
;    default     : break;
_0x56:
;  }
_0x53:
;  DDRC.6=0;
	CBI  0x14,6
; while (1)
_0x59:
; {
;   if(DATA_IN==0) break;
	SBIS 0x13,2
	RJMP _0x5B
;//tunggu hingga sensor selesai melakukan pengukuran
;  }
	RJMP _0x59
_0x5B:
;  if(DATA_IN) error+=1;
	SBIS 0x13,2
	RJMP _0x5D
	__ADDWRN 16,17,1
;// jika sudah timeout (2 detik)
;
;  switch(mode){                     //mengirim command ke sensor
_0x5D:
	RCALL SUBOPT_0xC
;    case TEMP        : temp=0;
	BRNE _0x61
	RCALL SUBOPT_0xB
;                       temp=baca_SHT(ACK);
	RCALL SUBOPT_0xA
	RCALL SUBOPT_0xF
;                       temp<<=8;
	MOV  R19,R18
	CLR  R18
;                       nilaisuhu[0]=temp;
	__PUTWMRN _nilaisuhu,0,18,19
;                       temp=0;
	RCALL SUBOPT_0xB
;                       temp=baca_SHT(ACK);
	RCALL SUBOPT_0xA
	RCALL SUBOPT_0xF
;                       nilaisuhu[0]|=temp;
	MOVW R30,R18
	LDS  R26,_nilaisuhu
	LDS  R27,_nilaisuhu+1
	RCALL SUBOPT_0x10
	STS  _nilaisuhu,R30
	STS  _nilaisuhu+1,R31
;                       break;
	RJMP _0x60
;    case HUMI        : temp=0;
_0x61:
	RCALL SUBOPT_0xE
	BRNE _0x63
	RCALL SUBOPT_0xB
;                       temp=baca_SHT(ACK);
	RCALL SUBOPT_0xA
	RCALL SUBOPT_0xF
;                       temp<<=8;
	MOV  R19,R18
	CLR  R18
;                       nilaisuhu[1]=temp;
	__POINTW1MN _nilaisuhu,2
	ST   Z,R18
	STD  Z+1,R19
;                       temp=0;
	RCALL SUBOPT_0xB
;                       temp=baca_SHT(ACK);
	RCALL SUBOPT_0xA
	RCALL SUBOPT_0xF
;                       nilaisuhu[1]|=temp;
	RCALL SUBOPT_0x11
	OR   R30,R18
	OR   R31,R19
	__PUTW1MN _nilaisuhu,2
;                       break;
;    default     : break;
_0x63:
;  }
_0x60:
;  *p_checksum =baca_SHT(noACK);  //baca checksum
	LDI  R26,LOW(0)
	RCALL _baca_SHT
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	ST   X,R30
;  return error;
	MOV  R30,R16
	RCALL __LOADLOCR4
	ADIW R28,7
	RET
;}
;
;const float C1=-4.0;

	.DSEG
;const float C2=+0.0405;
;const float C3=-0.0000028;
;const float T1=+0.01;
;const float T2=+0.00008;
;
;
;float hitung_SHT(float p_humidity, float *p_temperature)
;{

	.CSEG
_hitung_SHT:
;  float rh_lin;             // rh_lin:  Kelembaban linear
;  float rh_true;            // rh_true: Suhu untuk kompensasi kelembaban
;  float t_C;                // t_C   :  nilai Suhu
;
;  t_C=*p_temperature*0.01-40;
	RCALL SUBOPT_0x5
	SBIW R28,12
;	p_humidity -> Y+14
;	*p_temperature -> Y+12
;	rh_lin -> Y+8
;	rh_true -> Y+4
;	t_C -> Y+0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	RCALL __GETD1P
	RCALL SUBOPT_0x12
	RCALL __MULF12
	RCALL SUBOPT_0x13
	__GETD1N 0x42200000
	RCALL __SWAPD12
	RCALL __SUBF12
	RCALL __PUTD1S0
;//mengubah nilai Suhu menjadi derajat Celcius [°C]
;  rh_lin=C3*(p_humidity)*(p_humidity) + C2*(p_humidity) + C1;
	RCALL SUBOPT_0x14
	__GETD2N 0xB63BE7A2
	RCALL __MULF12
	__GETD2S 14
	RCALL __MULF12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x14
	__GETD2N 0x3D25E354
	RCALL __MULF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL __ADDF12
	__GETD2N 0xC0800000
	RCALL __ADDF12
	RCALL SUBOPT_0x15
;//mengubah nilai kelembaban dalam % [%RH]
;  rh_true=(t_C-25)*(T1+T2*(p_humidity))+rh_lin;
	RCALL SUBOPT_0x16
	__GETD2N 0x41C80000
	RCALL __SUBF12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x14
	__GETD2N 0x38A7C5AC
	RCALL __MULF12
	RCALL SUBOPT_0x12
	RCALL __ADDF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL __MULF12
	RCALL SUBOPT_0x17
	RCALL __ADDF12
	RCALL SUBOPT_0x18
;//mengkompensasikan nilai suhu dan kelembaban[%RH]
;  if(rh_true>100)rh_true=100;
	RCALL SUBOPT_0x19
	RCALL SUBOPT_0x1A
	RCALL __CMPF12
	BREQ PC+2
	BRCC PC+2
	RJMP _0x69
	RCALL SUBOPT_0x1A
	RCALL SUBOPT_0x18
;  if(rh_true<0.1)rh_true=0.1;
_0x69:
	RCALL SUBOPT_0x19
	RCALL SUBOPT_0x1B
	RCALL __CMPF12
	BRSH _0x6A
	RCALL SUBOPT_0x1B
	RCALL SUBOPT_0x18
;
;  *p_temperature=t_C;
_0x6A:
	RCALL SUBOPT_0x16
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	RCALL SUBOPT_0x1C
;   return rh_true;
	ADIW R28,18
	RET
;}
;
;
;void baca_sht11(float *data_humi,float *data_temp){
_baca_sht11:
;value humi_val,temp_val;
;unsigned char error,checksum,inp;
;reset_SHT();
	RCALL SUBOPT_0x5
	SBIW R28,8
	RCALL __SAVELOCR4
;	*data_humi -> Y+14
;	*data_temp -> Y+12
;	humi_val -> Y+8
;	temp_val -> Y+4
;	error -> R17
;	checksum -> R16
;	inp -> R19
	RCALL _reset_SHT
;error=0;
	LDI  R17,LOW(0)
;      error+=ukur_SHT(&checksum,HUMI);  //mengukur kelembaban
	IN   R30,SPL
	IN   R31,SPH
	RCALL SUBOPT_0x1D
	PUSH R16
	LDI  R26,LOW(1)
	RCALL _ukur_SHT
	POP  R16
	ADD  R17,R30
;      error+=ukur_SHT(&checksum,TEMP);  //mengukur suhu
	IN   R30,SPL
	IN   R31,SPH
	RCALL SUBOPT_0x1D
	PUSH R16
	LDI  R26,LOW(0)
	RCALL _ukur_SHT
	POP  R16
	ADD  R17,R30
;      error += StatusReg_SHT(&inp, &checksum);
	IN   R30,SPL
	IN   R31,SPH
	RCALL SUBOPT_0x1D
	PUSH R19
	IN   R26,SPL
	IN   R27,SPH
	PUSH R16
	RCALL _StatusReg_SHT
	POP  R16
	POP  R19
	ADD  R17,R30
;      if(error!=0)
	CPI  R17,0
	BREQ _0x6B
;       {
;       reset_SHT();                 //jika ada error, reset koneksi
	RCALL _reset_SHT
;       }
;      else
	RJMP _0x6C
_0x6B:
;       {
;       humi_val.f=(float)nilaisuhu[1];
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0x1E
	RCALL SUBOPT_0x15
;//mengubah integer menjadi float
;       temp_val.f=(float)nilaisuhu[0];
	LDS  R30,_nilaisuhu
	LDS  R31,_nilaisuhu+1
	RCALL SUBOPT_0x1E
	RCALL SUBOPT_0x18
;       humi_val.f=hitung_SHT(humi_val.f,&temp_val.f);
	RCALL SUBOPT_0x1F
	RCALL __PUTPARD1
	MOVW R26,R28
	ADIW R26,8
	RCALL _hitung_SHT
	RCALL SUBOPT_0x15
;       }
_0x6C:
;       *data_humi=humi_val.f;
	RCALL SUBOPT_0x1F
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	RCALL SUBOPT_0x1C
;       *data_temp=temp_val.f;
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	RCALL __PUTDP1
;}
	RCALL __LOADLOCR4
	ADIW R28,16
	RET
;#include <bmp085.c>
;#include <i2c.h>
;
;int ac1,ac2,ac3,b1,b2,mb,mc,md;
;unsigned int ac4,ac5,ac6;
;long int x1,x2,b5,b3,x3,b6,b7;
;unsigned long int b4;
;long int up;
;long int ut;
;
;long pressure;
;
;int ac1_hi,ac1_lo;
;int ac2_hi,ac2_lo;
;int ac3_hi,ac3_lo;
;int ac4_hi,ac4_lo;
;int ac5_hi,ac5_lo;
;int ac6_hi,ac6_lo;
;int b1_hi,b1_lo;
;int b2_hi,b2_lo;
;int mb_hi,mb_lo;
;int mc_hi,mc_lo;
;int md_hi,md_lo;
;
;
;void read_calibration_bmp085(){
; 0000 000A void read_calibration_bmp085(){
_read_calibration_bmp085:
;i2c_start();
	RCALL SUBOPT_0x20
;i2c_write(0xee);
;i2c_write(0xaa);
	LDI  R26,LOW(170)
	RCALL SUBOPT_0x21
;i2c_start();
;i2c_write(0xef);
;
;ac1_hi=i2c_read(1);
	RCALL SUBOPT_0x22
	STS  _ac1_hi,R30
	STS  _ac1_hi+1,R31
;ac1_lo=i2c_read(1);
	RCALL SUBOPT_0x23
	STS  _ac1_lo,R30
	STS  _ac1_lo+1,R31
;
;ac2_hi=i2c_read(1);
	RCALL SUBOPT_0x23
	STS  _ac2_hi,R30
	STS  _ac2_hi+1,R31
;ac2_lo=i2c_read(1);
	RCALL SUBOPT_0x23
	STS  _ac2_lo,R30
	STS  _ac2_lo+1,R31
;
;ac3_hi=i2c_read(1);
	RCALL SUBOPT_0x23
	STS  _ac3_hi,R30
	STS  _ac3_hi+1,R31
;ac3_lo=i2c_read(1);
	RCALL SUBOPT_0x23
	STS  _ac3_lo,R30
	STS  _ac3_lo+1,R31
;
;ac4_hi=i2c_read(1);
	RCALL SUBOPT_0x23
	STS  _ac4_hi,R30
	STS  _ac4_hi+1,R31
;ac4_lo=i2c_read(1);
	RCALL SUBOPT_0x23
	STS  _ac4_lo,R30
	STS  _ac4_lo+1,R31
;
;ac5_hi=i2c_read(1);
	RCALL SUBOPT_0x23
	STS  _ac5_hi,R30
	STS  _ac5_hi+1,R31
;ac5_lo=i2c_read(1);
	RCALL SUBOPT_0x23
	STS  _ac5_lo,R30
	STS  _ac5_lo+1,R31
;
;ac6_hi=i2c_read(1);
	RCALL SUBOPT_0x23
	STS  _ac6_hi,R30
	STS  _ac6_hi+1,R31
;ac6_lo=i2c_read(1);
	RCALL SUBOPT_0x23
	STS  _ac6_lo,R30
	STS  _ac6_lo+1,R31
;
;b1_hi=i2c_read(1);
	RCALL SUBOPT_0x23
	STS  _b1_hi,R30
	STS  _b1_hi+1,R31
;b1_lo=i2c_read(1);
	RCALL SUBOPT_0x23
	STS  _b1_lo,R30
	STS  _b1_lo+1,R31
;
;b2_hi=i2c_read(1);
	RCALL SUBOPT_0x23
	STS  _b2_hi,R30
	STS  _b2_hi+1,R31
;b2_lo=i2c_read(1);
	RCALL SUBOPT_0x23
	STS  _b2_lo,R30
	STS  _b2_lo+1,R31
;
;mb_hi=i2c_read(1);
	RCALL SUBOPT_0x23
	STS  _mb_hi,R30
	STS  _mb_hi+1,R31
;mb_lo=i2c_read(1);
	RCALL SUBOPT_0x23
	STS  _mb_lo,R30
	STS  _mb_lo+1,R31
;
;mc_hi=i2c_read(1);
	RCALL SUBOPT_0x23
	STS  _mc_hi,R30
	STS  _mc_hi+1,R31
;mc_lo=i2c_read(1);
	RCALL SUBOPT_0x23
	STS  _mc_lo,R30
	STS  _mc_lo+1,R31
;
;md_hi=i2c_read(1);
	RCALL SUBOPT_0x23
	STS  _md_hi,R30
	STS  _md_hi+1,R31
;md_lo=i2c_read(0);
	LDI  R26,LOW(0)
	RCALL _i2c_read
	RCALL SUBOPT_0x22
	STS  _md_lo,R30
	STS  _md_lo+1,R31
;
;i2c_stop();
	RCALL _i2c_stop
;
;ac1=ac1_hi<<8 | ac1_lo;
	LDS  R31,_ac1_hi
	LDI  R30,LOW(0)
	LDS  R26,_ac1_lo
	LDS  R27,_ac1_lo+1
	RCALL SUBOPT_0x10
	MOVW R4,R30
;ac2=ac2_hi<<8 | ac2_lo;
	LDS  R31,_ac2_hi
	LDI  R30,LOW(0)
	LDS  R26,_ac2_lo
	LDS  R27,_ac2_lo+1
	RCALL SUBOPT_0x10
	MOVW R6,R30
;ac3=ac3_hi<<8 | ac3_lo;
	LDS  R31,_ac3_hi
	LDI  R30,LOW(0)
	LDS  R26,_ac3_lo
	LDS  R27,_ac3_lo+1
	RCALL SUBOPT_0x10
	MOVW R8,R30
;ac4=ac4_hi<<8 | ac4_lo;
	LDS  R31,_ac4_hi
	LDI  R30,LOW(0)
	LDS  R26,_ac4_lo
	LDS  R27,_ac4_lo+1
	RCALL SUBOPT_0x10
	STS  _ac4,R30
	STS  _ac4+1,R31
;ac5=ac5_hi<<8 | ac5_lo;
	LDS  R31,_ac5_hi
	LDI  R30,LOW(0)
	LDS  R26,_ac5_lo
	LDS  R27,_ac5_lo+1
	RCALL SUBOPT_0x10
	STS  _ac5,R30
	STS  _ac5+1,R31
;ac6=ac6_hi<<8 | ac6_lo;
	LDS  R31,_ac6_hi
	LDI  R30,LOW(0)
	LDS  R26,_ac6_lo
	LDS  R27,_ac6_lo+1
	RCALL SUBOPT_0x10
	STS  _ac6,R30
	STS  _ac6+1,R31
;
;b1=b1_hi<<8 | b1_lo;
	LDS  R31,_b1_hi
	LDI  R30,LOW(0)
	LDS  R26,_b1_lo
	LDS  R27,_b1_lo+1
	RCALL SUBOPT_0x10
	MOVW R10,R30
;b2=b2_hi<<8 | b2_lo;
	LDS  R31,_b2_hi
	LDI  R30,LOW(0)
	LDS  R26,_b2_lo
	LDS  R27,_b2_lo+1
	RCALL SUBOPT_0x10
	MOVW R12,R30
;
;mb=mb_hi<<8 | mb_lo;
	LDS  R31,_mb_hi
	LDI  R30,LOW(0)
	LDS  R26,_mb_lo
	LDS  R27,_mb_lo+1
	RCALL SUBOPT_0x10
	STS  _mb,R30
	STS  _mb+1,R31
;mc=mc_hi<<8 | mc_lo;
	LDS  R31,_mc_hi
	LDI  R30,LOW(0)
	LDS  R26,_mc_lo
	LDS  R27,_mc_lo+1
	RCALL SUBOPT_0x10
	STS  _mc,R30
	STS  _mc+1,R31
;md=md_hi<<8 | md_lo;
	LDS  R31,_md_hi
	LDI  R30,LOW(0)
	LDS  R26,_md_lo
	LDS  R27,_md_lo+1
	RCALL SUBOPT_0x10
	STS  _md,R30
	STS  _md+1,R31
;//printf("ac1= %d ac2= %d ac3= %d ac4= %u ac5= %u ac6= %u b1= %d b2= %d mb= %d mc= %d md= %d\r\n",ac1,ac2,ac3,ac4,ac5,ac6,b1,b2,mb,mc,md);
;}
	RET
;
;void read_uncompensated_temp(){
_read_uncompensated_temp:
;char temp_value_hi,temp_value_lo;
;i2c_start();
	RCALL __SAVELOCR2
;	temp_value_hi -> R17
;	temp_value_lo -> R16
	RCALL SUBOPT_0x20
;i2c_write(0xee);
;i2c_write(0xf4);
	LDI  R26,LOW(244)
	RCALL _i2c_write
;i2c_write(0x2e);
	LDI  R26,LOW(46)
	RCALL SUBOPT_0x24
;i2c_stop();
;
;delay_ms(5);
;
;i2c_start();
;i2c_write(0xee);
;i2c_write(0xf6);
	LDI  R26,LOW(246)
	RCALL SUBOPT_0x21
;i2c_start();
;i2c_write(0xef);
;temp_value_hi=i2c_read(1);
	RCALL SUBOPT_0x25
;temp_value_lo=i2c_read(0);
;i2c_stop();
;
;ut =(long int) temp_value_hi <<8 | (long)temp_value_lo;
	STS  _ut,R30
	STS  _ut+1,R31
	STS  _ut+2,R22
	STS  _ut+3,R23
;
;x1 = ((long)ut - ac6) * ac5 >> 15;
	LDS  R30,_ac6
	LDS  R31,_ac6+1
	LDS  R26,_ut
	LDS  R27,_ut+1
	LDS  R24,_ut+2
	LDS  R25,_ut+3
	RCALL SUBOPT_0x26
	RCALL __SUBD21
	LDS  R30,_ac5
	LDS  R31,_ac5+1
	RCALL SUBOPT_0x26
	RCALL SUBOPT_0x27
	LDI  R30,LOW(15)
	RCALL SUBOPT_0x28
;x2 = ((long)mc << 11) / (x1 + md);
	LDS  R26,_mc
	LDS  R27,_mc+1
	RCALL SUBOPT_0x29
	LDI  R30,LOW(11)
	RCALL __LSLD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDS  R30,_md
	LDS  R31,_md+1
	RCALL SUBOPT_0x2A
	RCALL SUBOPT_0x2B
	RCALL __ADDD12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL __DIVD21
	RCALL SUBOPT_0x2C
;b5 = x1 + x2;
	STS  _b5,R30
	STS  _b5+1,R31
	STS  _b5+2,R22
	STS  _b5+3,R23
;}
	RCALL __LOADLOCR2P
	RET
;
;void read_uncompensated_pressure(){
_read_uncompensated_pressure:
;char pres_value_hi,pres_value_lo;
;long p;
;
;i2c_start();
	SBIW R28,4
	RCALL __SAVELOCR2
;	pres_value_hi -> R17
;	pres_value_lo -> R16
;	p -> Y+2
	RCALL SUBOPT_0x20
;i2c_write(0xee);
;i2c_write(0xf4);
	LDI  R26,LOW(244)
	RCALL _i2c_write
;i2c_write(0x34);
	LDI  R26,LOW(52)
	RCALL SUBOPT_0x24
;i2c_stop();
;
;delay_ms(5);
;
;i2c_start();
;i2c_write(0xee);
;i2c_write(0xf6);
	LDI  R26,LOW(246)
	RCALL SUBOPT_0x21
;i2c_start();
;i2c_write(0xef);
;pres_value_hi=i2c_read(1); //f6
	RCALL SUBOPT_0x25
;pres_value_lo=i2c_read(0); //f7
;i2c_stop();
;
;up= (long)pres_value_hi <<8 | (long)pres_value_lo; // | (long)pres_value_x)>>8;
	STS  _up,R30
	STS  _up+1,R31
	STS  _up+2,R22
	STS  _up+3,R23
;	b6 = b5 - 4000;
	LDS  R30,_b5
	LDS  R31,_b5+1
	LDS  R22,_b5+2
	LDS  R23,_b5+3
	__SUBD1N 4000
	STS  _b6,R30
	STS  _b6+1,R31
	STS  _b6+2,R22
	STS  _b6+3,R23
;	x1 = (b2* (b6 * b6) >> 12) >> 11;
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x2E
	RCALL __MULD12
	MOVW R26,R12
	RCALL SUBOPT_0x29
	RCALL SUBOPT_0x27
	LDI  R30,LOW(12)
	RCALL __ASRD12
	RCALL SUBOPT_0x13
	LDI  R30,LOW(11)
	RCALL SUBOPT_0x28
;	x2 = (ac2 * b6) >> 11;
	RCALL SUBOPT_0x2D
	MOVW R26,R6
	RCALL SUBOPT_0x29
	RCALL SUBOPT_0x27
	LDI  R30,LOW(11)
	RCALL __ASRD12
	RCALL SUBOPT_0x2C
;	x3 = x1 + x2;
	RCALL SUBOPT_0x2F
;	b3 = (((((long)ac1) * 4 + x3) << 0) + 2) >> 2;
	MOVW R26,R4
	RCALL SUBOPT_0x29
	__GETD1N 0x4
	RCALL __MULD12
	LDS  R26,_x3
	LDS  R27,_x3+1
	LDS  R24,_x3+2
	LDS  R25,_x3+3
	RCALL __ADDD21
	MOVW R30,R26
	MOVW R22,R24
	RCALL SUBOPT_0x30
	STS  _b3,R30
	STS  _b3+1,R31
	STS  _b3+2,R22
	STS  _b3+3,R23
;	x1 = (ac3 * b6) >> 13;
	RCALL SUBOPT_0x2D
	MOVW R26,R8
	RCALL SUBOPT_0x29
	RCALL SUBOPT_0x27
	LDI  R30,LOW(13)
	RCALL SUBOPT_0x28
;	x2 = (b1 * ((b6 * b6) >> 12)) >> 16;
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x27
	LDI  R30,LOW(12)
	RCALL __ASRD12
	MOVW R26,R10
	RCALL SUBOPT_0x29
	RCALL __MULD12
	RCALL __ASRD16
	RCALL SUBOPT_0x2C
;	x3 = ((x1 + x2) + 2) >> 2;
	RCALL SUBOPT_0x30
	RCALL SUBOPT_0x2F
;	b4 = (ac4 * (unsigned long)(x3 + 32768)) >> 15;
	LDS  R30,_x3
	LDS  R31,_x3+1
	LDS  R22,_x3+2
	LDS  R23,_x3+3
	__ADDD1N 32768
	LDS  R26,_ac4
	LDS  R27,_ac4+1
	CLR  R24
	CLR  R25
	RCALL __MULD12U
	RCALL SUBOPT_0x13
	LDI  R30,LOW(15)
	RCALL __LSRD12
	STS  _b4,R30
	STS  _b4+1,R31
	STS  _b4+2,R22
	STS  _b4+3,R23
;	b7 = ((unsigned long)up - b3) * (50000 >> 0);
	LDS  R26,_b3
	LDS  R27,_b3+1
	LDS  R24,_b3+2
	LDS  R25,_b3+3
	LDS  R30,_up
	LDS  R31,_up+1
	LDS  R22,_up+2
	LDS  R23,_up+3
	RCALL __SUBD12
	__GETD2N 0xC350
	RCALL __MULD12U
	STS  _b7,R30
	STS  _b7+1,R31
	STS  _b7+2,R22
	STS  _b7+3,R23
;	p = b7 < 0x80000000 ? (b7 << 1) / b4 : (b7 / b4) << 1;
	RCALL SUBOPT_0x31
	__CPD2N 0x80000000
	BRSH _0x6D
	LDS  R30,_b7
	LDS  R31,_b7+1
	LDS  R22,_b7+2
	LDS  R23,_b7+3
	RCALL __LSLD1
	MOVW R26,R30
	MOVW R24,R22
	RCALL SUBOPT_0x32
	RCALL __DIVD21U
	RJMP _0x6E
_0x6D:
	RCALL SUBOPT_0x32
	RCALL SUBOPT_0x31
	RCALL __DIVD21U
	RCALL __LSLD1
_0x6E:
	__PUTD1S 2
;	x1 = (p >> 8) * (p >> 8);
	RCALL SUBOPT_0x33
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x33
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL __MULD12
	RCALL SUBOPT_0x34
;	x1 = (x1 * 3038) >> 16;
	LDS  R30,_x1
	LDS  R31,_x1+1
	LDS  R22,_x1+2
	LDS  R23,_x1+3
	__GETD2N 0xBDE
	RCALL __MULD12
	RCALL __ASRD16
	RCALL SUBOPT_0x34
;	x2 = (-7357 * p) >> 16;
	__GETD1S 2
	__GETD2N 0xFFFFE343
	RCALL __MULD12
	RCALL __ASRD16
	RCALL SUBOPT_0x2C
;	pressure = p + ((x1 + x2 + 3791) >> 4);
	__ADDD1N 3791
	RCALL SUBOPT_0x13
	LDI  R30,LOW(4)
	RCALL __ASRD12
	__GETD2S 2
	RCALL __ADDD12
	STS  _pressure,R30
	STS  _pressure+1,R31
	STS  _pressure+2,R22
	STS  _pressure+3,R23
;}
	RCALL __LOADLOCR2
_0x20E0003:
	ADIW R28,6
	RET
;
;//float suhubmp() {
;//	float temperature;
;//    read_uncompensated_temp();
;//	temperature = ((b5 + 8)>>4);
;//	//temperature = temperature *10;
;//	return temperature;
;//}
;
;long int tekananbmp(){
_tekananbmp:
;    read_uncompensated_pressure();
	RCALL _read_uncompensated_pressure
;    return pressure;
	LDS  R30,_pressure
	LDS  R31,_pressure+1
	LDS  R22,_pressure+2
	LDS  R23,_pressure+3
	RET
;}
;
;#asm
   .equ __i2c_port=0x15 ;PORTC
   .equ __sda_bit=4
   .equ __scl_bit=5
; 0000 0010 #endasm
;#include <i2c.h>
;
;#define antena PORTD.7
;
;
;//variable--------------------------------------------------
;
;    //enumerasi dan variabel pendukung----------------------
;    enum{main_menu,kirim_respon_bangun,ambil_data,mode_sleep_1,mode_sleep_2,sinkron,ambil_data_delay,ambil_data_truput,packet_data_rate,tes};
;    unsigned char slot,state,i,timer_rto;
;    bit flag_ambil_data;
;    bit respon_bangun_ack;
;    bit flag_kirim_respon;
;    bit rto;
;    unsigned int curah_hujan;
;    //------------------------------------------------------
;
;    //encoder dan kecepatan angin---------------------------
;    unsigned int encoder,kecepatan_angin;
;    bit ambil_data_kecepatan;
;    //------------------------------------------------------
;
;    //SHT11 suhu dan kelembapan-----------------------------
;    float data_suhu,data_kelembapan;
;    //int suhu_bmp085;
;    //------------------------------------------------------
;
;    //BMP085 TEKANAN----------------------------------------
;    long int data_tekanan;
;    //------------------------------------------------------
;
;    //HMC5883L Kompas---------------------------------------
;    unsigned int data_kompas;
;    //------------------------------------------------------
;
;    //RTC waktu---------------------------------------------
;    unsigned char jam,menit,detik;
;    unsigned char tanggal,bulan,tahun;
;    unsigned char jam_sinkron,menit_sinkron,detik_sinkron,tanggal_sinkron,bulan_sinkron,tahun_sinkron;
;    bit flag_sinkron;
;    //------------------------------------------------------
;
;    //Sleep mode--------------------------------------------
;    unsigned char jam_alarm,menit_alarm;
;    bit flag_sleep_mode;
;    //------------------------------------------------------
;
;    //parameter telekomunikasi------------------------------
;    bit flag_start_delay_timer;
;    bit ack;
;    bit flag_start_hitung_truput;
;    bit flag_hitung_pdr;
;    unsigned char data_received_sukses;
;    unsigned int delay;
;    float delay_timer;
;    float troughput;
;    unsigned int data_received_kirim;
;    unsigned int delay_timer_kirim;
;    unsigned int troughput_kirim;
;    //------------------------------------------------------
;
;
;//----------------------------------------------------------
;
;//functions-------------------------------------------------
;
;unsigned int read_adc(unsigned char adc_input){
; 0000 0053 unsigned int read_adc(unsigned char adc_input){
_read_adc:
; 0000 0054 ADMUX=adc_input | (0x40 & 0xff);
	ST   -Y,R26
;	adc_input -> Y+0
	LD   R30,Y
	ORI  R30,0x40
	OUT  0x7,R30
; 0000 0055 delay_us(10);
	__DELAY_USB 6
; 0000 0056 ADCSRA|=0x40;
	SBI  0x6,6
; 0000 0057 while ((ADCSRA & 0x10)==0);
_0x70:
	SBIS 0x6,4
	RJMP _0x70
; 0000 0058 ADCSRA|=0x10;
	SBI  0x6,4
; 0000 0059 return ADCW;
	IN   R30,0x4
	IN   R31,0x4+1
	RJMP _0x20E0002
; 0000 005A }
;
;
;
;interrupt [USART_RXC] void usart_rx_isr(void){
; 0000 005E interrupt [12] void usart_rx_isr(void){
_usart_rx_isr:
	RCALL SUBOPT_0x35
; 0000 005F unsigned char data;
; 0000 0060 data=UDR;
	ST   -Y,R17
;	data -> R17
	IN   R17,12
; 0000 0061 
; 0000 0062 switch(slot){
	LDS  R30,_slot
	RCALL SUBOPT_0x22
; 0000 0063 
; 0000 0064 //Header file------------------------------------------------------------------
; 0000 0065     case 0:
	SBIW R30,0
	BRNE _0x76
; 0000 0066     if(data==255)slot=1; //start
	CPI  R17,255
	BRNE _0x77
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x36
; 0000 0067     break;
_0x77:
	RJMP _0x75
; 0000 0068 
; 0000 0069     case 1:
_0x76:
	RCALL SUBOPT_0xE
	BRNE _0x78
; 0000 006A     if      (data==255) slot=1;
	CPI  R17,255
	BRNE _0x79
	LDI  R30,LOW(1)
	RJMP _0xE7
; 0000 006B     else if (data=='a'){slot=0;flag_ambil_data=1;}
_0x79:
	CPI  R17,97
	BRNE _0x7B
	LDI  R30,LOW(0)
	RCALL SUBOPT_0x37
	BLD  R2,0
; 0000 006C     else if (data=='b') slot=2; //sinkronisasi slot 2-7
	RJMP _0x7C
_0x7B:
	CPI  R17,98
	BRNE _0x7D
	LDI  R30,LOW(2)
	RJMP _0xE7
; 0000 006D     else if (data=='c'){slot=8;flag_start_delay_timer=1;} //delay slot 8
_0x7D:
	CPI  R17,99
	BRNE _0x7F
	LDI  R30,LOW(8)
	RCALL SUBOPT_0x37
	BLD  R2,7
; 0000 006E     else if (data=='d') slot=9; //mode tidur slot 9
	RJMP _0x80
_0x7F:
	CPI  R17,100
	BRNE _0x81
	LDI  R30,LOW(9)
	RJMP _0xE7
; 0000 006F     else if (data=='e'){flag_kirim_respon=1;respon_bangun_ack=1;} //respon ack klo tau udah bangun
_0x81:
	CPI  R17,101
	BRNE _0x83
	SET
	BLD  R2,2
	BLD  R2,1
; 0000 0070     else if (data=='f'){slot=8;flag_start_hitung_truput=1;}
	RJMP _0x84
_0x83:
	CPI  R17,102
	BRNE _0x85
	LDI  R30,LOW(8)
	RCALL SUBOPT_0x37
	BLD  R3,1
; 0000 0071     else if (data=='g'){slot=8;flag_hitung_pdr=1;}
	RJMP _0x86
_0x85:
	CPI  R17,103
	BRNE _0x87
	LDI  R30,LOW(8)
	RCALL SUBOPT_0x37
	BLD  R3,2
; 0000 0072     else if (data=='h'){printf("OK\n");slot=0;} //cek status
	RJMP _0x88
_0x87:
	CPI  R17,104
	BRNE _0x89
	RCALL SUBOPT_0x38
	LDI  R30,LOW(0)
_0xE7:
	STS  _slot,R30
; 0000 0073     break;
_0x89:
_0x88:
_0x86:
_0x84:
_0x80:
_0x7C:
	RJMP _0x75
; 0000 0074 //----------------------------------------------------------------------------
; 0000 0075 
; 0000 0076 
; 0000 0077 //sinkronisasi waktu slot 2-7-------------------------------------------------
; 0000 0078     {
; 0000 0079     case 2:
_0x78:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x8A
; 0000 007A     if      (data==255)slot=1;
	CPI  R17,255
	BRNE _0x8B
	LDI  R30,LOW(1)
	RJMP _0xE8
; 0000 007B     else               {jam_sinkron=data;slot=3;} //sinkronisasi jam
_0x8B:
	STS  _jam_sinkron,R17
	LDI  R30,LOW(3)
_0xE8:
	STS  _slot,R30
; 0000 007C     break;
	RJMP _0x75
; 0000 007D 
; 0000 007E     case 3:
_0x8A:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x8D
; 0000 007F     if      (data==255)slot=1;
	CPI  R17,255
	BRNE _0x8E
	LDI  R30,LOW(1)
	RJMP _0xE9
; 0000 0080     else               {menit_sinkron=data;slot=4;} //sinkronisasi menit
_0x8E:
	STS  _menit_sinkron,R17
	LDI  R30,LOW(4)
_0xE9:
	STS  _slot,R30
; 0000 0081     break;
	RJMP _0x75
; 0000 0082 
; 0000 0083     case 4:
_0x8D:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x90
; 0000 0084     if      (data==255)slot=1;
	CPI  R17,255
	BRNE _0x91
	LDI  R30,LOW(1)
	RJMP _0xEA
; 0000 0085     else               {detik_sinkron=data;slot=5;} //sinkronisasi detik
_0x91:
	STS  _detik_sinkron,R17
	LDI  R30,LOW(5)
_0xEA:
	STS  _slot,R30
; 0000 0086     break;
	RJMP _0x75
; 0000 0087 
; 0000 0088     case 5:
_0x90:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x93
; 0000 0089     if      (data==255)slot=1;
	CPI  R17,255
	BRNE _0x94
	LDI  R30,LOW(1)
	RJMP _0xEB
; 0000 008A     else               {tanggal_sinkron=data;slot=6;} //sinkronisasi tanggal
_0x94:
	STS  _tanggal_sinkron,R17
	LDI  R30,LOW(6)
_0xEB:
	STS  _slot,R30
; 0000 008B     break;
	RJMP _0x75
; 0000 008C 
; 0000 008D     case 6:
_0x93:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x96
; 0000 008E     if      (data==255)slot=1;
	CPI  R17,255
	BRNE _0x97
	LDI  R30,LOW(1)
	RJMP _0xEC
; 0000 008F     else               {bulan_sinkron=data;slot=7;} //sinkronisasi bulan
_0x97:
	STS  _bulan_sinkron,R17
	LDI  R30,LOW(7)
_0xEC:
	STS  _slot,R30
; 0000 0090     break;
	RJMP _0x75
; 0000 0091 
; 0000 0092     case 7:
_0x96:
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BRNE _0x99
; 0000 0093     if      (data==255)slot=1;
	CPI  R17,255
	BRNE _0x9A
	LDI  R30,LOW(1)
	RJMP _0xED
; 0000 0094     else               {tahun_sinkron=data;flag_sinkron=1;slot=0;} //sinkronisasi tahun
_0x9A:
	STS  _tahun_sinkron,R17
	SET
	BLD  R2,5
	LDI  R30,LOW(0)
_0xED:
	STS  _slot,R30
; 0000 0095     break;
	RJMP _0x75
; 0000 0096     }
; 0000 0097 //----------------------------------------------------------------------------
; 0000 0098 
; 0000 0099 //program delay slot 8------------------------------------------------------
; 0000 009A     {
; 0000 009B     case 8:
_0x99:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x9C
; 0000 009C     if      (data==255) slot=1;
	CPI  R17,255
	BRNE _0x9D
	LDI  R30,LOW(1)
	RJMP _0xEE
; 0000 009D     else if (data=='K'){
_0x9D:
	CPI  R17,75
	BRNE _0x9F
; 0000 009E                         ack=1;
	SET
	BLD  R3,0
; 0000 009F                         if(flag_hitung_pdr==1)slot=8;
	SBRS R3,2
	RJMP _0xA0
	LDI  R30,LOW(8)
	RJMP _0xEE
; 0000 00A0                         else                  slot=0;
_0xA0:
	LDI  R30,LOW(0)
_0xEE:
	STS  _slot,R30
; 0000 00A1                         } //program utama stop timer dan kirim data delay
; 0000 00A2     break;
_0x9F:
	RJMP _0x75
; 0000 00A3     }
; 0000 00A4 //-----------------------------------------------------------------------------
; 0000 00A5 
; 0000 00A6 //program mode sleep-----------------------------------------------------------
; 0000 00A7     {
; 0000 00A8     case 9:
_0x9C:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0xA2
; 0000 00A9     if      (data==255) slot=1;
	CPI  R17,255
	BRNE _0xA3
	LDI  R30,LOW(1)
	RJMP _0xEF
; 0000 00AA     else               {jam_alarm=data;slot=10;}
_0xA3:
	STS  _jam_alarm,R17
	LDI  R30,LOW(10)
_0xEF:
	STS  _slot,R30
; 0000 00AB     break;
	RJMP _0x75
; 0000 00AC 
; 0000 00AD     case 10:
_0xA2:
	CPI  R30,LOW(0xA)
	LDI  R26,HIGH(0xA)
	CPC  R31,R26
	BRNE _0x75
; 0000 00AE     if      (data==255) slot=1;
	CPI  R17,255
	BRNE _0xA6
	LDI  R30,LOW(1)
	RJMP _0xF0
; 0000 00AF     else               {menit_alarm=data;flag_sleep_mode=1;slot=0;}
_0xA6:
	STS  _menit_alarm,R17
	SET
	BLD  R2,6
	LDI  R30,LOW(0)
_0xF0:
	STS  _slot,R30
; 0000 00B0     break;
; 0000 00B1     }
; 0000 00B2 //-----------------------------------------------------------------------------
; 0000 00B3 
; 0000 00B4 }
_0x75:
; 0000 00B5 }
	LD   R17,Y+
	RJMP _0xF1
;
;interrupt [EXT_INT0] void ext_int0_isr(void){ //interrupt buat bangun
; 0000 00B7 interrupt [2] void ext_int0_isr(void){
_ext_int0_isr:
	RCALL SUBOPT_0x35
; 0000 00B8 GICR=0x00;
	RCALL SUBOPT_0x39
; 0000 00B9 GIFR=0x00;
	OUT  0x3A,R30
; 0000 00BA sleep_disable();
	RCALL _sleep_disable
; 0000 00BB antena=1; //antena nyala
	SBI  0x12,7
; 0000 00BC alarm_mati();
	RCALL _alarm_mati
; 0000 00BD state=kirim_respon_bangun;
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x3A
; 0000 00BE 
; 0000 00BF }
_0xF1:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
;
;interrupt [EXT_INT1] void ext_int1_isr(void){
; 0000 00C1 interrupt [3] void ext_int1_isr(void){
_ext_int1_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 00C2 encoder++;
	LDI  R26,LOW(_encoder)
	LDI  R27,HIGH(_encoder)
	RCALL SUBOPT_0x3B
; 0000 00C3 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;
;interrupt [TIM1_COMPA] void timer1_compa_isr(void){
; 0000 00C5 interrupt [7] void timer1_compa_isr(void){
_timer1_compa_isr:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 00C6 kecepatan_angin=encoder;
	LDS  R30,_encoder
	LDS  R31,_encoder+1
	STS  _kecepatan_angin,R30
	STS  _kecepatan_angin+1,R31
; 0000 00C7 encoder=0;
	RCALL SUBOPT_0x3C
; 0000 00C8 ambil_data_kecepatan=1;
	SET
	BLD  R2,4
; 0000 00C9 
; 0000 00CA }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
;
;interrupt [TIM1_OVF] void timer1_ovf_isr(void){
; 0000 00CC interrupt [9] void timer1_ovf_isr(void){
_timer1_ovf_isr:
	ST   -Y,R30
	IN   R30,SREG
	ST   -Y,R30
; 0000 00CD timer_rto++;
	LDS  R30,_timer_rto
	SUBI R30,-LOW(1)
	RCALL SUBOPT_0x3D
; 0000 00CE }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R30,Y+
	RETI
;
;
;void main(void){
; 0000 00D1 void main(void){
_main:
; 0000 00D2 unsigned char minus=0;
; 0000 00D3 
; 0000 00D4 // USART initialization
; 0000 00D5 // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 00D6 // USART Receiver: On
; 0000 00D7 // USART Transmitter: On
; 0000 00D8 // USART Mode: Asynchronous
; 0000 00D9 // USART Baud Rate: 9600
; 0000 00DA UCSRA=0x00;
;	minus -> R17
	LDI  R17,0
	LDI  R30,LOW(0)
	OUT  0xB,R30
; 0000 00DB UCSRB=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
; 0000 00DC UCSRC=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0000 00DD UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0000 00DE UBRRL=0x0b;
	LDI  R30,LOW(11)
	OUT  0x9,R30
; 0000 00DF 
; 0000 00E0 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 00E1 
; 0000 00E2 DDRC.3=1;
	SBI  0x14,3
; 0000 00E3 
; 0000 00E4 //power antena
; 0000 00E5 DDRD.7=1;
	SBI  0x11,7
; 0000 00E6 antena=1;
	SBI  0x12,7
; 0000 00E7 
; 0000 00E8 i2c_init();
	RCALL _i2c_init
; 0000 00E9 delay_ms(10);
	LDI  R26,LOW(10)
	RCALL SUBOPT_0x3E
; 0000 00EA read_calibration_bmp085();
	RCALL _read_calibration_bmp085
; 0000 00EB 
; 0000 00EC set_rtc();
	RCALL _set_rtc
; 0000 00ED 
; 0000 00EE PORTD.2=1;
	SBI  0x12,2
; 0000 00EF PORTD.3=1;
	SBI  0x12,3
; 0000 00F0 alarm_mati();
	RCALL _alarm_mati
; 0000 00F1 
; 0000 00F2 TCCR1B=0x07;
	LDI  R30,LOW(7)
	OUT  0x2E,R30
; 0000 00F3 
; 0000 00F4 #asm("sei")
	sei
; 0000 00F5 state=main_menu;
	RCALL SUBOPT_0x3F
; 0000 00F6 while (1){
_0xB4:
; 0000 00F7 switch(state){
	LDS  R30,_state
	RCALL SUBOPT_0x22
; 0000 00F8 
; 0000 00F9     case main_menu:{
	SBIW R30,0
	BRNE _0xBA
; 0000 00FA     if(flag_ambil_data==1)          state=ambil_data;
	SBRS R2,0
	RJMP _0xBB
	LDI  R30,LOW(2)
	RCALL SUBOPT_0x3A
; 0000 00FB     if(flag_sleep_mode==1)          state=mode_sleep_1;
_0xBB:
	SBRS R2,6
	RJMP _0xBC
	LDI  R30,LOW(3)
	RCALL SUBOPT_0x3A
; 0000 00FC     if(flag_sinkron==1)             state=sinkron;
_0xBC:
	SBRS R2,5
	RJMP _0xBD
	LDI  R30,LOW(5)
	RCALL SUBOPT_0x3A
; 0000 00FD     if(flag_start_delay_timer==1)   state=ambil_data_delay;
_0xBD:
	SBRS R2,7
	RJMP _0xBE
	LDI  R30,LOW(6)
	RCALL SUBOPT_0x3A
; 0000 00FE     if(flag_start_hitung_truput==1) state=ambil_data_truput;
_0xBE:
	SBRS R3,1
	RJMP _0xBF
	LDI  R30,LOW(7)
	RCALL SUBOPT_0x3A
; 0000 00FF     if(flag_kirim_respon==1)        state=kirim_respon_bangun;
_0xBF:
	SBRS R2,2
	RJMP _0xC0
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x3A
; 0000 0100     if(flag_start_hitung_truput==1) state=ambil_data_truput;
_0xC0:
	SBRS R3,1
	RJMP _0xC1
	LDI  R30,LOW(7)
	RCALL SUBOPT_0x3A
; 0000 0101     if(flag_hitung_pdr==1)          state=packet_data_rate;
_0xC1:
	SBRS R3,2
	RJMP _0xC2
	LDI  R30,LOW(8)
	RCALL SUBOPT_0x3A
; 0000 0102     }break;
_0xC2:
	RJMP _0xB9
; 0000 0103 
; 0000 0104     case ambil_data:{
_0xBA:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0xC3
; 0000 0105     curah_hujan=TCNT1;                                    //ambil data curah hujan
	IN   R30,0x2C
	IN   R31,0x2C+1
	STS  _curah_hujan,R30
	STS  _curah_hujan+1,R31
; 0000 0106     TCCR1B=0x0D;
	LDI  R30,LOW(13)
	OUT  0x2E,R30
; 0000 0107     OCR1AH=0x07;
	LDI  R30,LOW(7)
	OUT  0x2B,R30
; 0000 0108     OCR1AL=0x07;
	OUT  0x2A,R30
; 0000 0109     TIMSK=0x10;
	LDI  R30,LOW(16)
	OUT  0x39,R30
; 0000 010A     GICR=0x80;
	LDI  R30,LOW(128)
	OUT  0x3B,R30
; 0000 010B     MCUCR=0x08;
	LDI  R30,LOW(8)
	OUT  0x35,R30
; 0000 010C     GIFR=0x80;
	LDI  R30,LOW(128)
	OUT  0x3A,R30
; 0000 010D     encoder=0;
	RCALL SUBOPT_0x3C
; 0000 010E     TCNT1=0;
	RCALL SUBOPT_0x40
; 0000 010F     ambil_data_kecepatan=0;while(!ambil_data_kecepatan);  //ambil data kecepatan angin
	CLT
	BLD  R2,4
_0xC4:
	SBRS R2,4
	RJMP _0xC4
; 0000 0110     //printf("data_kecepatan\r\n");
; 0000 0111     jam_brp(&jam,&menit,&detik);                          //ambil data waktu
	LDI  R30,LOW(_jam)
	LDI  R31,HIGH(_jam)
	RCALL SUBOPT_0x1D
	LDI  R30,LOW(_menit)
	LDI  R31,HIGH(_menit)
	RCALL SUBOPT_0x1D
	LDI  R26,LOW(_detik)
	LDI  R27,HIGH(_detik)
	RCALL _jam_brp
; 0000 0112     //printf("data_jam\r\n");
; 0000 0113     tgl_brp(&tanggal,&bulan,&tahun);
	LDI  R30,LOW(_tanggal)
	LDI  R31,HIGH(_tanggal)
	RCALL SUBOPT_0x1D
	LDI  R30,LOW(_bulan)
	LDI  R31,HIGH(_bulan)
	RCALL SUBOPT_0x1D
	LDI  R26,LOW(_tahun)
	LDI  R27,HIGH(_tahun)
	RCALL _tgl_brp
; 0000 0114     //printf("data_tanggal\r\n");
; 0000 0115     baca_sht11(&data_kelembapan,&data_suhu);              //ambil data suhu dan kelembapan
	LDI  R30,LOW(_data_kelembapan)
	LDI  R31,HIGH(_data_kelembapan)
	RCALL SUBOPT_0x1D
	LDI  R26,LOW(_data_suhu)
	LDI  R27,HIGH(_data_suhu)
	RCALL _baca_sht11
; 0000 0116     //printf("data sht\r\n");
; 0000 0117 
; 0000 0118     read_uncompensated_temp();
	RCALL _read_uncompensated_temp
; 0000 0119     read_uncompensated_pressure();
	RCALL _read_uncompensated_pressure
; 0000 011A     //suhu_bmp085=temperature_bmp085();
; 0000 011B     //printf("data_suhubmp085\r\n");
; 0000 011C     data_tekanan=tekananbmp();                                  //ambil data tekanan
	RCALL _tekananbmp
	STS  _data_tekanan,R30
	STS  _data_tekanan+1,R31
	STS  _data_tekanan+2,R22
	STS  _data_tekanan+3,R23
; 0000 011D     //printf("data_pressurebmp085\r\n");
; 0000 011E 
; 0000 011F     delay_ms(1);
	LDI  R26,LOW(1)
	RCALL SUBOPT_0x3E
; 0000 0120     ADMUX=0x40 & 0xff;
	LDI  R30,LOW(64)
	OUT  0x7,R30
; 0000 0121     ADCSRA=0x85;
	LDI  R30,LOW(133)
	OUT  0x6,R30
; 0000 0122     data_kompas=read_adc(0);                                   //ambil data arah mata angin
	LDI  R26,LOW(0)
	RCALL _read_adc
	STS  _data_kompas,R30
	STS  _data_kompas+1,R31
; 0000 0123     ADMUX=0x00;
	LDI  R30,LOW(0)
	OUT  0x7,R30
; 0000 0124     ADCSRA=0x00;
	OUT  0x6,R30
; 0000 0125     //printf("data_kompas\r\n");
; 0000 0126     flag_ambil_data=0;
	CLT
	BLD  R2,0
; 0000 0127     TCCR1B=0x07;
	LDI  R30,LOW(7)
	OUT  0x2E,R30
; 0000 0128     TCNT1=0;
	RCALL SUBOPT_0x40
; 0000 0129     OCR1AH=0x00;
	LDI  R30,LOW(0)
	OUT  0x2B,R30
; 0000 012A     OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 012B     TIMSK=0x00;
	OUT  0x39,R30
; 0000 012C     GICR=0x00;
	RCALL SUBOPT_0x39
; 0000 012D     MCUCR=0x00;
	OUT  0x35,R30
; 0000 012E     GIFR=0x00;
	LDI  R30,LOW(0)
	OUT  0x3A,R30
; 0000 012F     printf("A%dB%dC%dD%dE%dF%dG%ldH%dI%dJ%dK%dZ\n",jam,menit,kecepatan_angin,(int)data_kelembapan,(int)data_suhu,data_kompas,data_tekanan,tanggal,bulan,tahun,curah_hujan);
	__POINTW1FN _0x0,4
	RCALL SUBOPT_0x1D
	LDS  R30,_jam
	RCALL SUBOPT_0x41
	LDS  R30,_menit
	RCALL SUBOPT_0x41
	LDS  R30,_kecepatan_angin
	LDS  R31,_kecepatan_angin+1
	RCALL SUBOPT_0x42
	LDS  R30,_data_kelembapan
	LDS  R31,_data_kelembapan+1
	LDS  R22,_data_kelembapan+2
	LDS  R23,_data_kelembapan+3
	RCALL __CFD1
	RCALL SUBOPT_0x2B
	RCALL __PUTPARD1
	LDS  R30,_data_suhu
	LDS  R31,_data_suhu+1
	LDS  R22,_data_suhu+2
	LDS  R23,_data_suhu+3
	RCALL __CFD1
	RCALL SUBOPT_0x2B
	RCALL __PUTPARD1
	LDS  R30,_data_kompas
	LDS  R31,_data_kompas+1
	RCALL SUBOPT_0x42
	LDS  R30,_data_tekanan
	LDS  R31,_data_tekanan+1
	LDS  R22,_data_tekanan+2
	LDS  R23,_data_tekanan+3
	RCALL __PUTPARD1
	LDS  R30,_tanggal
	RCALL SUBOPT_0x41
	LDS  R30,_bulan
	RCALL SUBOPT_0x41
	LDS  R30,_tahun
	RCALL SUBOPT_0x41
	LDS  R30,_curah_hujan
	LDS  R31,_curah_hujan+1
	RCALL SUBOPT_0x42
	LDI  R24,44
	RCALL _printf
	ADIW R28,46
; 0000 0130     curah_hujan=0;
	LDI  R30,LOW(0)
	STS  _curah_hujan,R30
	STS  _curah_hujan+1,R30
; 0000 0131     state=main_menu;
	RCALL SUBOPT_0x3F
; 0000 0132     minus++;
	SUBI R17,-1
; 0000 0133     }break;
	RJMP _0xB9
; 0000 0134 
; 0000 0135     case sinkron:{
_0xC3:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0xC7
; 0000 0136     set_waktu(jam_sinkron,menit_sinkron,detik_sinkron);
	LDS  R30,_jam_sinkron
	ST   -Y,R30
	LDS  R30,_menit_sinkron
	ST   -Y,R30
	LDS  R26,_detik_sinkron
	RCALL _set_waktu
; 0000 0137     set_tgl(tanggal_sinkron,bulan_sinkron,tahun_sinkron);
	LDS  R30,_tanggal_sinkron
	ST   -Y,R30
	LDS  R30,_bulan_sinkron
	ST   -Y,R30
	LDS  R26,_tahun_sinkron
	RCALL _set_tgl
; 0000 0138     printf("OK\n");
	RCALL SUBOPT_0x38
; 0000 0139     flag_sinkron=0;
	CLT
	BLD  R2,5
; 0000 013A     state=main_menu;
	RCALL SUBOPT_0x3F
; 0000 013B     }break;
	RJMP _0xB9
; 0000 013C 
; 0000 013D     case ambil_data_delay:{
_0xC7:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0xC8
; 0000 013E     delay=0;
	RCALL SUBOPT_0x43
; 0000 013F     TCCR1B=0x01;
; 0000 0140     TIMSK=0x04;
; 0000 0141     timer_rto=0;
; 0000 0142     TCNT1=0;
; 0000 0143     ack=0;
	RCALL SUBOPT_0x44
; 0000 0144     printf("D123456789012345678901234567890\n");
	RCALL SUBOPT_0x45
; 0000 0145     while(!ack && timer_rto<122);
_0xC9:
	SBRC R3,0
	RJMP _0xCC
	RCALL SUBOPT_0x46
	BRLO _0xCD
_0xCC:
	RJMP _0xCB
_0xCD:
	RJMP _0xC9
_0xCB:
; 0000 0146     delay_timer=(float)TCNT1*0.00025;
	RCALL SUBOPT_0x47
; 0000 0147     delay_timer_kirim=(int)delay_timer;
	LDS  R30,_delay_timer
	LDS  R31,_delay_timer+1
	LDS  R22,_delay_timer+2
	LDS  R23,_delay_timer+3
	RCALL __CFD1
	RCALL SUBOPT_0x48
; 0000 0148     if(delay_timer_kirim<1)delay_timer_kirim=1;
	LDS  R26,_delay_timer_kirim
	LDS  R27,_delay_timer_kirim+1
	SBIW R26,1
	BRSH _0xCE
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RCALL SUBOPT_0x48
; 0000 0149     printf("L%dZ\n",delay_timer_kirim);
_0xCE:
	__POINTW1FN _0x0,74
	RCALL SUBOPT_0x1D
	LDS  R30,_delay_timer_kirim
	LDS  R31,_delay_timer_kirim+1
	RCALL SUBOPT_0x42
	RCALL SUBOPT_0x49
; 0000 014A     TCCR1B=0x0B;
; 0000 014B     ack=0;
	RCALL SUBOPT_0x44
; 0000 014C     flag_start_delay_timer=0;
	CLT
	BLD  R2,7
; 0000 014D     state=main_menu;
	RCALL SUBOPT_0x3F
; 0000 014E     }break;
	RJMP _0xB9
; 0000 014F 
; 0000 0150     case ambil_data_truput:{
_0xC8:
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0xCF
; 0000 0151     delay=0;
	RCALL SUBOPT_0x43
; 0000 0152     TCCR1B=0x01;
; 0000 0153     TIMSK=0x04;
; 0000 0154     timer_rto=0;
; 0000 0155     TCNT1=0;
; 0000 0156     printf("D123456789012345678901234567890\n");
	RCALL SUBOPT_0x45
; 0000 0157     while(!ack && timer_rto<122);
_0xD0:
	SBRC R3,0
	RJMP _0xD3
	RCALL SUBOPT_0x46
	BRLO _0xD4
_0xD3:
	RJMP _0xD2
_0xD4:
	RJMP _0xD0
_0xD2:
; 0000 0158     delay_timer=(float)TCNT1*0.00025;
	RCALL SUBOPT_0x47
; 0000 0159     troughput=32/(delay_timer/1000);
	LDS  R26,_delay_timer
	LDS  R27,_delay_timer+1
	LDS  R24,_delay_timer+2
	LDS  R25,_delay_timer+3
	__GETD1N 0x447A0000
	RCALL __DIVF21
	__GETD2N 0x42000000
	RCALL __DIVF21
	STS  _troughput,R30
	STS  _troughput+1,R31
	STS  _troughput+2,R22
	STS  _troughput+3,R23
; 0000 015A     troughput_kirim=(int)troughput;
	RCALL __CFD1
	STS  _troughput_kirim,R30
	STS  _troughput_kirim+1,R31
; 0000 015B     printf("T%dZ\n",troughput_kirim);
	__POINTW1FN _0x0,80
	RCALL SUBOPT_0x1D
	LDS  R30,_troughput_kirim
	LDS  R31,_troughput_kirim+1
	RCALL SUBOPT_0x42
	RCALL SUBOPT_0x49
; 0000 015C     TCCR1B=0x0B;
; 0000 015D     TIMSK=0x10;
	LDI  R30,LOW(16)
	OUT  0x39,R30
; 0000 015E     ack=0;
	RCALL SUBOPT_0x44
; 0000 015F     flag_start_hitung_truput=0;
	CLT
	BLD  R3,1
; 0000 0160     state=main_menu;
	RCALL SUBOPT_0x3F
; 0000 0161     }break;
	RJMP _0xB9
; 0000 0162 
; 0000 0163     case packet_data_rate:{
_0xCF:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0xD5
; 0000 0164     delay=0;
	RCALL SUBOPT_0x43
; 0000 0165     TCCR1B=0x01;
; 0000 0166     TIMSK=0x04;
; 0000 0167     timer_rto=0;
; 0000 0168     TCNT1=0;
; 0000 0169     data_received_sukses=0;
	LDI  R30,LOW(0)
	STS  _data_received_sukses,R30
; 0000 016A     for(i=0;i<11;i++){
	STS  _i,R30
_0xD7:
	LDS  R26,_i
	CPI  R26,LOW(0xB)
	BRSH _0xD8
; 0000 016B         printf("D123456789012345678901234567890\n");
	RCALL SUBOPT_0x45
; 0000 016C         while(!ack){
_0xD9:
	SBRC R3,0
	RJMP _0xDB
; 0000 016D             if(timer_rto>121){rto=1;break;}
	RCALL SUBOPT_0x46
	BRLO _0xDC
	SET
	BLD  R2,3
	RJMP _0xDB
; 0000 016E         }
_0xDC:
	RJMP _0xD9
_0xDB:
; 0000 016F     if(rto==1)rto=0;
	SBRS R2,3
	RJMP _0xDD
	CLT
	BLD  R2,3
; 0000 0170     else      data_received_sukses++;
	RJMP _0xDE
_0xDD:
	LDS  R30,_data_received_sukses
	SUBI R30,-LOW(1)
	STS  _data_received_sukses,R30
; 0000 0171     ack=0;
_0xDE:
	RCALL SUBOPT_0x44
; 0000 0172     timer_rto=0;
	LDI  R30,LOW(0)
	RCALL SUBOPT_0x3D
; 0000 0173     }
	LDS  R30,_i
	SUBI R30,-LOW(1)
	STS  _i,R30
	RJMP _0xD7
_0xD8:
; 0000 0174     data_received_kirim=data_received_sukses*10;
	LDS  R26,_data_received_sukses
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	STS  _data_received_kirim,R30
	STS  _data_received_kirim+1,R31
; 0000 0175     printf("P%dZ\n",data_received_kirim);
	__POINTW1FN _0x0,86
	RCALL SUBOPT_0x1D
	LDS  R30,_data_received_kirim
	LDS  R31,_data_received_kirim+1
	RCALL SUBOPT_0x42
	RCALL SUBOPT_0x49
; 0000 0176     TCCR1B=0x0B;
; 0000 0177     TIMSK=0x10;
	LDI  R30,LOW(16)
	OUT  0x39,R30
; 0000 0178     ack=0;
	RCALL SUBOPT_0x44
; 0000 0179     flag_hitung_pdr=0;
	CLT
	BLD  R3,2
; 0000 017A     slot=0;
	LDI  R30,LOW(0)
	RCALL SUBOPT_0x36
; 0000 017B     state=main_menu;
	RCALL SUBOPT_0x3F
; 0000 017C     }break;
	RJMP _0xB9
; 0000 017D 
; 0000 017E     case kirim_respon_bangun:{
_0xD5:
	RCALL SUBOPT_0xE
	BRNE _0xDF
; 0000 017F     printf("W\n");
	__POINTW1FN _0x0,92
	RCALL SUBOPT_0x4A
; 0000 0180     delay_ms(100);
	LDI  R26,LOW(100)
	RCALL SUBOPT_0x3E
; 0000 0181     if(respon_bangun_ack){flag_kirim_respon=0;respon_bangun_ack=0;state=main_menu;}
	SBRS R2,1
	RJMP _0xE0
	CLT
	BLD  R2,2
	BLD  R2,1
	RCALL SUBOPT_0x3F
; 0000 0182     }break;
_0xE0:
	RJMP _0xB9
; 0000 0183 
; 0000 0184     case mode_sleep_1:{
_0xDF:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0xE1
; 0000 0185     set_alarm(jam_alarm,menit_alarm);
	LDS  R30,_jam_alarm
	ST   -Y,R30
	LDS  R26,_menit_alarm
	RCALL _set_alarm
; 0000 0186     printf("S\n");
	__POINTW1FN _0x0,95
	RCALL SUBOPT_0x4A
; 0000 0187     antena=0;
	CBI  0x12,7
; 0000 0188     flag_sleep_mode=0;
	CLT
	BLD  R2,6
; 0000 0189     GICR=0x00;
	RCALL SUBOPT_0x39
; 0000 018A     GIFR=0x00;
	OUT  0x3A,R30
; 0000 018B     MCUCR=0x00;
	LDI  R30,LOW(0)
	OUT  0x35,R30
; 0000 018C     state=mode_sleep_2;
	LDI  R30,LOW(4)
	RCALL SUBOPT_0x3A
; 0000 018D     }break;
	RJMP _0xB9
; 0000 018E 
; 0000 018F     case mode_sleep_2:{
_0xE1:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0xE4
; 0000 0190     GICR=0x40;
	LDI  R30,LOW(64)
	OUT  0x3B,R30
; 0000 0191     GIFR=0x40;
	OUT  0x3A,R30
; 0000 0192     sleep_enable();
	RCALL _sleep_enable
; 0000 0193     idle();
	RCALL _idle
; 0000 0194     //printf("hoho haha\r\n");
; 0000 0195     }break;
	RJMP _0xB9
; 0000 0196 
; 0000 0197     case tes:{
_0xE4:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0xB9
; 0000 0198 //    suhubmp();
; 0000 0199 //    printf("Tekanan=%luPa ",tekananbmp());
; 0000 019A //    baca_sht11(&data_kelembapan,&data_suhu);              //ambil data suhu dan kelembapan
; 0000 019B //    printf("Kelembapan=%d%c Suhu=%dC \r\n",(int)data_kelembapan,37,(int)(data_suhu*10));
; 0000 019C     printf("01234567890abcdefghijklmnopqrstuvwxyz\r\n");
	__POINTW1FN _0x0,98
	RCALL SUBOPT_0x4A
; 0000 019D //    curah_hujan=TCNT1;                                    //ambil data curah hujan
; 0000 019E     //data_kompas=read_adc(0);
; 0000 019F     //ambil_data_kecepatan=0;while(!ambil_data_kecepatan);  //ambil data kecepatan angin
; 0000 01A0     //printf("kecepatan = %d arah angin= %d\r\n",kecepatan_angin,data_kompas);
; 0000 01A1     delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RCALL _delay_ms
; 0000 01A2     }break;
; 0000 01A3     }
_0xB9:
; 0000 01A4 }
	RJMP _0xB4
; 0000 01A5 }
_0xE6:
	RJMP _0xE6
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_putchar:
	ST   -Y,R26
putchar0:
     sbis usr,udre
     rjmp putchar0
     ld   r30,y
     out  udr,r30
_0x20E0002:
	ADIW R28,1
	RET
_put_usart_G100:
	RCALL SUBOPT_0x5
	LDD  R26,Y+2
	RCALL _putchar
	LD   R26,Y
	LDD  R27,Y+1
	RCALL SUBOPT_0x3B
_0x20E0001:
	ADIW R28,3
	RET
__print_G100:
	RCALL SUBOPT_0x5
	SBIW R28,12
	RCALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2000016:
	LDD  R30,Y+24
	LDD  R31,Y+24+1
	ADIW R30,1
	STD  Y+24,R30
	STD  Y+24+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2000018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x200001C
	CPI  R18,37
	BRNE _0x200001D
	LDI  R17,LOW(1)
	RJMP _0x200001E
_0x200001D:
	RCALL SUBOPT_0x4B
_0x200001E:
	RJMP _0x200001B
_0x200001C:
	CPI  R30,LOW(0x1)
	BRNE _0x200001F
	CPI  R18,37
	BRNE _0x2000020
	RCALL SUBOPT_0x4B
	RJMP _0x20000E4
_0x2000020:
	LDI  R17,LOW(2)
	LDI  R30,LOW(0)
	STD  Y+17,R30
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2000021
	LDI  R16,LOW(1)
	RJMP _0x200001B
_0x2000021:
	CPI  R18,43
	BRNE _0x2000022
	LDI  R30,LOW(43)
	STD  Y+17,R30
	RJMP _0x200001B
_0x2000022:
	CPI  R18,32
	BRNE _0x2000023
	LDI  R30,LOW(32)
	STD  Y+17,R30
	RJMP _0x200001B
_0x2000023:
	RJMP _0x2000024
_0x200001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2000025
_0x2000024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2000026
	ORI  R16,LOW(128)
	RJMP _0x200001B
_0x2000026:
	RJMP _0x2000027
_0x2000025:
	CPI  R30,LOW(0x3)
	BRNE _0x2000028
_0x2000027:
	CPI  R18,48
	BRLO _0x200002A
	CPI  R18,58
	BRLO _0x200002B
_0x200002A:
	RJMP _0x2000029
_0x200002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x200001B
_0x2000029:
	LDI  R20,LOW(0)
	CPI  R18,46
	BRNE _0x200002C
	LDI  R17,LOW(4)
	RJMP _0x200001B
_0x200002C:
	RJMP _0x200002D
_0x2000028:
	CPI  R30,LOW(0x4)
	BRNE _0x200002F
	CPI  R18,48
	BRLO _0x2000031
	CPI  R18,58
	BRLO _0x2000032
_0x2000031:
	RJMP _0x2000030
_0x2000032:
	LDI  R26,LOW(10)
	MUL  R20,R26
	MOV  R20,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0x200001B
_0x2000030:
_0x200002D:
	CPI  R18,108
	BRNE _0x2000033
	ORI  R16,LOW(2)
	LDI  R17,LOW(5)
	RJMP _0x200001B
_0x2000033:
	RJMP _0x2000034
_0x200002F:
	CPI  R30,LOW(0x5)
	BREQ PC+2
	RJMP _0x200001B
_0x2000034:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x2000039
	RCALL SUBOPT_0x4C
	RCALL SUBOPT_0x4D
	RCALL SUBOPT_0x4C
	LDD  R26,Z+4
	ST   -Y,R26
	RCALL SUBOPT_0x4E
	RJMP _0x200003A
_0x2000039:
	CPI  R30,LOW(0x73)
	BRNE _0x200003C
	RCALL SUBOPT_0x4F
	RCALL SUBOPT_0x50
	RCALL _strlen
	MOV  R17,R30
	RJMP _0x200003D
_0x200003C:
	CPI  R30,LOW(0x70)
	BRNE _0x200003F
	RCALL SUBOPT_0x4F
	RCALL SUBOPT_0x50
	RCALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x200003D:
	ANDI R16,LOW(127)
	CPI  R20,0
	BREQ _0x2000041
	CP   R20,R17
	BRLO _0x2000042
_0x2000041:
	RJMP _0x2000040
_0x2000042:
	MOV  R17,R20
_0x2000040:
	LDI  R20,LOW(0)
	LDI  R30,LOW(0)
	STD  Y+16,R30
	LDI  R19,LOW(0)
	RJMP _0x2000043
_0x200003F:
	CPI  R30,LOW(0x64)
	BREQ _0x2000046
	CPI  R30,LOW(0x69)
	BRNE _0x2000047
_0x2000046:
	ORI  R16,LOW(4)
	RJMP _0x2000048
_0x2000047:
	CPI  R30,LOW(0x75)
	BRNE _0x2000049
_0x2000048:
	LDI  R30,LOW(10)
	STD  Y+16,R30
	SBRS R16,1
	RJMP _0x200004A
	__GETD1N 0x3B9ACA00
	RCALL SUBOPT_0x15
	LDI  R17,LOW(10)
	RJMP _0x200004B
_0x200004A:
	__GETD1N 0x2710
	RCALL SUBOPT_0x15
	LDI  R17,LOW(5)
	RJMP _0x200004B
_0x2000049:
	CPI  R30,LOW(0x58)
	BRNE _0x200004D
	ORI  R16,LOW(8)
	RJMP _0x200004E
_0x200004D:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x200008C
_0x200004E:
	LDI  R30,LOW(16)
	STD  Y+16,R30
	SBRS R16,1
	RJMP _0x2000050
	__GETD1N 0x10000000
	RCALL SUBOPT_0x15
	LDI  R17,LOW(8)
	RJMP _0x200004B
_0x2000050:
	__GETD1N 0x1000
	RCALL SUBOPT_0x15
	LDI  R17,LOW(4)
_0x200004B:
	CPI  R20,0
	BREQ _0x2000051
	ANDI R16,LOW(127)
	RJMP _0x2000052
_0x2000051:
	LDI  R20,LOW(1)
_0x2000052:
	SBRS R16,1
	RJMP _0x2000053
	RCALL SUBOPT_0x4F
	RCALL SUBOPT_0x51
	RCALL __GETD1P
	RJMP _0x20000E5
_0x2000053:
	SBRS R16,2
	RJMP _0x2000055
	RCALL SUBOPT_0x4F
	RCALL SUBOPT_0x51
	RCALL __GETW1P
	RCALL SUBOPT_0x2B
	RJMP _0x20000E5
_0x2000055:
	RCALL SUBOPT_0x4F
	RCALL SUBOPT_0x51
	RCALL __GETW1P
	RCALL SUBOPT_0x26
_0x20000E5:
	__PUTD1S 12
	SBRS R16,2
	RJMP _0x2000057
	LDD  R26,Y+15
	TST  R26
	BRPL _0x2000058
	__GETD1S 12
	RCALL __ANEGD1
	RCALL SUBOPT_0x52
	LDI  R30,LOW(45)
	STD  Y+17,R30
_0x2000058:
	LDD  R30,Y+17
	CPI  R30,0
	BREQ _0x2000059
	SUBI R17,-LOW(1)
	SUBI R20,-LOW(1)
	RJMP _0x200005A
_0x2000059:
	ANDI R16,LOW(251)
_0x200005A:
_0x2000057:
	MOV  R19,R20
_0x2000043:
	SBRC R16,0
	RJMP _0x200005B
_0x200005C:
	CP   R17,R21
	BRSH _0x200005F
	CP   R19,R21
	BRLO _0x2000060
_0x200005F:
	RJMP _0x200005E
_0x2000060:
	SBRS R16,7
	RJMP _0x2000061
	SBRS R16,2
	RJMP _0x2000062
	ANDI R16,LOW(251)
	LDD  R18,Y+17
	SUBI R17,LOW(1)
	RJMP _0x2000063
_0x2000062:
	LDI  R18,LOW(48)
_0x2000063:
	RJMP _0x2000064
_0x2000061:
	LDI  R18,LOW(32)
_0x2000064:
	RCALL SUBOPT_0x4B
	SUBI R21,LOW(1)
	RJMP _0x200005C
_0x200005E:
_0x200005B:
_0x2000065:
	CP   R17,R20
	BRSH _0x2000067
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x2000068
	RCALL SUBOPT_0x53
	CPI  R21,0
	BREQ _0x2000069
	SUBI R21,LOW(1)
_0x2000069:
	SUBI R17,LOW(1)
	SUBI R20,LOW(1)
_0x2000068:
	LDI  R30,LOW(48)
	ST   -Y,R30
	RCALL SUBOPT_0x4E
	CPI  R21,0
	BREQ _0x200006A
	SUBI R21,LOW(1)
_0x200006A:
	SUBI R20,LOW(1)
	RJMP _0x2000065
_0x2000067:
	MOV  R19,R17
	LDD  R30,Y+16
	CPI  R30,0
	BRNE _0x200006B
_0x200006C:
	CPI  R19,0
	BREQ _0x200006E
	SBRS R16,3
	RJMP _0x200006F
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2000070
_0x200006F:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2000070:
	RCALL SUBOPT_0x4B
	CPI  R21,0
	BREQ _0x2000071
	SUBI R21,LOW(1)
_0x2000071:
	SUBI R19,LOW(1)
	RJMP _0x200006C
_0x200006E:
	RJMP _0x2000072
_0x200006B:
_0x2000074:
	RCALL SUBOPT_0x54
	RCALL __DIVD21U
	MOV  R18,R30
	CPI  R18,10
	BRLO _0x2000076
	SBRS R16,3
	RJMP _0x2000077
	SUBI R18,-LOW(55)
	RJMP _0x2000078
_0x2000077:
	SUBI R18,-LOW(87)
_0x2000078:
	RJMP _0x2000079
_0x2000076:
	SUBI R18,-LOW(48)
_0x2000079:
	SBRC R16,4
	RJMP _0x200007B
	CPI  R18,49
	BRSH _0x200007D
	RCALL SUBOPT_0x17
	__CPD2N 0x1
	BRNE _0x200007C
_0x200007D:
	RJMP _0x200007F
_0x200007C:
	CP   R20,R19
	BRSH _0x20000E6
	CP   R21,R19
	BRLO _0x2000082
	SBRS R16,0
	RJMP _0x2000083
_0x2000082:
	RJMP _0x2000081
_0x2000083:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2000084
_0x20000E6:
	LDI  R18,LOW(48)
_0x200007F:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x2000085
	RCALL SUBOPT_0x53
	CPI  R21,0
	BREQ _0x2000086
	SUBI R21,LOW(1)
_0x2000086:
_0x2000085:
_0x2000084:
_0x200007B:
	RCALL SUBOPT_0x4B
	CPI  R21,0
	BREQ _0x2000087
	SUBI R21,LOW(1)
_0x2000087:
_0x2000081:
	SUBI R19,LOW(1)
	RCALL SUBOPT_0x54
	RCALL __MODD21U
	RCALL SUBOPT_0x52
	LDD  R30,Y+16
	RCALL SUBOPT_0x17
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __DIVD21U
	RCALL SUBOPT_0x15
	RCALL SUBOPT_0x1F
	RCALL __CPD10
	BRNE _0x2000074
_0x2000072:
	SBRS R16,0
	RJMP _0x2000088
_0x2000089:
	CPI  R21,0
	BREQ _0x200008B
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	RCALL SUBOPT_0x4E
	RJMP _0x2000089
_0x200008B:
_0x2000088:
_0x200008C:
_0x200003A:
_0x20000E4:
	LDI  R17,LOW(0)
_0x200001B:
	RJMP _0x2000016
_0x2000018:
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	RCALL __GETW1P
	RCALL __LOADLOCR6
	ADIW R28,26
	RET
_printf:
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	RCALL __SAVELOCR2
	MOVW R26,R28
	ADIW R26,4
	RCALL __ADDW2R15
	MOVW R16,R26
	LDI  R30,LOW(0)
	STD  Y+4,R30
	STD  Y+4+1,R30
	STD  Y+6,R30
	STD  Y+6+1,R30
	MOVW R26,R28
	ADIW R26,8
	RCALL __ADDW2R15
	RCALL __GETW1P
	RCALL SUBOPT_0x1D
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_usart_G100)
	LDI  R31,HIGH(_put_usart_G100)
	RCALL SUBOPT_0x1D
	MOVW R26,R28
	ADIW R26,8
	RCALL __print_G100
	RCALL __LOADLOCR2
	ADIW R28,8
	POP  R15
	RET

	.CSEG

	.DSEG

	.CSEG

	.CSEG
_bcd2bin:
	ST   -Y,R26
    ld   r30,y
    swap r30
    andi r30,0xf
    mov  r26,r30
    lsl  r26
    lsl  r26
    add  r30,r26
    lsl  r30
    ld   r26,y+
    andi r26,0xf
    add  r30,r26
    ret
_bin2bcd:
	ST   -Y,R26
    ld   r26,y+
    clr  r30
bin2bcd0:
    subi r26,10
    brmi bin2bcd1
    subi r30,-16
    rjmp bin2bcd0
bin2bcd1:
    subi r26,-10
    add  r30,r26
    ret
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_sleep_enable:
   in   r30,power_ctrl_reg
   sbr  r30,__se_bit
   out  power_ctrl_reg,r30
	RET
_sleep_disable:
   in   r30,power_ctrl_reg
   cbr  r30,__se_bit
   out  power_ctrl_reg,r30
	RET
_idle:
   in   r30,power_ctrl_reg
   cbr  r30,__sm_mask
   out  power_ctrl_reg,r30
   in   r30,sreg
   sei
   sleep
   out  sreg,r30
	RET

	.CSEG

	.CSEG

	.CSEG
_strlen:
	RCALL SUBOPT_0x5
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
_strlenf:
	RCALL SUBOPT_0x5
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret

	.DSEG
_nilaisuhu:
	.BYTE 0x4
_mb:
	.BYTE 0x2
_mc:
	.BYTE 0x2
_md:
	.BYTE 0x2
_ac4:
	.BYTE 0x2
_ac5:
	.BYTE 0x2
_ac6:
	.BYTE 0x2
_x1:
	.BYTE 0x4
_x2:
	.BYTE 0x4
_b5:
	.BYTE 0x4
_b3:
	.BYTE 0x4
_x3:
	.BYTE 0x4
_b6:
	.BYTE 0x4
_b7:
	.BYTE 0x4
_b4:
	.BYTE 0x4
_up:
	.BYTE 0x4
_ut:
	.BYTE 0x4
_pressure:
	.BYTE 0x4
_ac1_hi:
	.BYTE 0x2
_ac1_lo:
	.BYTE 0x2
_ac2_hi:
	.BYTE 0x2
_ac2_lo:
	.BYTE 0x2
_ac3_hi:
	.BYTE 0x2
_ac3_lo:
	.BYTE 0x2
_ac4_hi:
	.BYTE 0x2
_ac4_lo:
	.BYTE 0x2
_ac5_hi:
	.BYTE 0x2
_ac5_lo:
	.BYTE 0x2
_ac6_hi:
	.BYTE 0x2
_ac6_lo:
	.BYTE 0x2
_b1_hi:
	.BYTE 0x2
_b1_lo:
	.BYTE 0x2
_b2_hi:
	.BYTE 0x2
_b2_lo:
	.BYTE 0x2
_mb_hi:
	.BYTE 0x2
_mb_lo:
	.BYTE 0x2
_mc_hi:
	.BYTE 0x2
_mc_lo:
	.BYTE 0x2
_md_hi:
	.BYTE 0x2
_md_lo:
	.BYTE 0x2
_slot:
	.BYTE 0x1
_state:
	.BYTE 0x1
_i:
	.BYTE 0x1
_timer_rto:
	.BYTE 0x1
_curah_hujan:
	.BYTE 0x2
_encoder:
	.BYTE 0x2
_kecepatan_angin:
	.BYTE 0x2
_data_suhu:
	.BYTE 0x4
_data_kelembapan:
	.BYTE 0x4
_data_tekanan:
	.BYTE 0x4
_data_kompas:
	.BYTE 0x2
_jam:
	.BYTE 0x1
_menit:
	.BYTE 0x1
_detik:
	.BYTE 0x1
_tanggal:
	.BYTE 0x1
_bulan:
	.BYTE 0x1
_tahun:
	.BYTE 0x1
_jam_sinkron:
	.BYTE 0x1
_menit_sinkron:
	.BYTE 0x1
_detik_sinkron:
	.BYTE 0x1
_tanggal_sinkron:
	.BYTE 0x1
_bulan_sinkron:
	.BYTE 0x1
_tahun_sinkron:
	.BYTE 0x1
_jam_alarm:
	.BYTE 0x1
_menit_alarm:
	.BYTE 0x1
_data_received_sukses:
	.BYTE 0x1
_delay:
	.BYTE 0x2
_delay_timer:
	.BYTE 0x4
_troughput:
	.BYTE 0x4
_data_received_kirim:
	.BYTE 0x2
_delay_timer_kirim:
	.BYTE 0x2
_troughput_kirim:
	.BYTE 0x2
__seed_G101:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x0:
	RCALL _i2c_start
	LDI  R26,LOW(208)
	RJMP _i2c_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1:
	RCALL _i2c_write
	LD   R26,Y
	RJMP _bin2bcd

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x2:
	MOV  R26,R30
	RJMP _i2c_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x3:
	RCALL _i2c_write
	RCALL _i2c_start
	LDI  R26,LOW(209)
	RCALL _i2c_write
	LDI  R26,LOW(1)
	RCALL _i2c_read
	MOV  R26,R30
	RJMP _bcd2bin

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x4:
	ST   X,R30
	LDI  R26,LOW(1)
	RCALL _i2c_read
	MOV  R26,R30
	RCALL _bcd2bin
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ST   X,R30
	LDI  R26,LOW(0)
	RCALL _i2c_read
	MOV  R26,R30
	RJMP _bcd2bin

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x5:
	ST   -Y,R27
	ST   -Y,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0x6:
	SBI  0x15,3
	__DELAY_USB 1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x7:
	MOV  R26,R17
	LDI  R27,0
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RCALL __DIVW21
	MOV  R17,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x8:
	__DELAY_USB 1
	CBI  0x15,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9:
	CBI  0x15,3
	__DELAY_USB 1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xA:
	LDI  R26,LOW(1)
	RJMP _baca_SHT

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xB:
	__GETWRN 18,19,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xC:
	LDD  R30,Y+4
	LDI  R31,0
	SBIW R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xD:
	RCALL _tulis_SHT
	LDI  R31,0
	__ADDWRR 16,17,30,31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xE:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF:
	MOV  R18,R30
	CLR  R19
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x10:
	OR   R30,R26
	OR   R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x11:
	__GETW1MN _nilaisuhu,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x12:
	__GETD2N 0x3C23D70A
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x13:
	MOVW R26,R30
	MOVW R24,R22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x14:
	__GETD1S 14
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x15:
	__PUTD1S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x16:
	RCALL __GETD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x17:
	__GETD2S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x18:
	__PUTD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x19:
	__GETD2S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1A:
	__GETD1N 0x42C80000
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1B:
	__GETD1N 0x3DCCCCCD
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1C:
	RCALL __PUTDP1
	__GETD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 22 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x1D:
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1E:
	CLR  R22
	CLR  R23
	RCALL __CDF1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x1F:
	__GETD1S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x20:
	RCALL _i2c_start
	LDI  R26,LOW(238)
	RJMP _i2c_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x21:
	RCALL _i2c_write
	RCALL _i2c_start
	LDI  R26,LOW(239)
	RCALL _i2c_write
	LDI  R26,LOW(1)
	RJMP _i2c_read

;OPTIMIZER ADDED SUBROUTINE, CALLED 28 TIMES, CODE SIZE REDUCTION:52 WORDS
SUBOPT_0x22:
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 20 TIMES, CODE SIZE REDUCTION:36 WORDS
SUBOPT_0x23:
	LDI  R26,LOW(1)
	RCALL _i2c_read
	RJMP SUBOPT_0x22

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x24:
	RCALL _i2c_write
	RCALL _i2c_stop
	LDI  R26,LOW(5)
	LDI  R27,0
	RCALL _delay_ms
	RJMP SUBOPT_0x20

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x25:
	MOV  R17,R30
	LDI  R26,LOW(0)
	RCALL _i2c_read
	MOV  R16,R30
	RCALL _i2c_stop
	MOV  R30,R17
	RCALL SUBOPT_0x22
	RCALL __CWD1
	RCALL SUBOPT_0x13
	LDI  R30,LOW(8)
	RCALL __LSLD12
	RCALL SUBOPT_0x13
	MOV  R30,R16
	RCALL SUBOPT_0x22
	RCALL __CWD1
	RCALL __ORD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x26:
	CLR  R22
	CLR  R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x27:
	RCALL __MULD12
	RJMP SUBOPT_0x13

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x28:
	RCALL __ASRD12
	STS  _x1,R30
	STS  _x1+1,R31
	STS  _x1+2,R22
	STS  _x1+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x29:
	RCALL __CWD2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:26 WORDS
SUBOPT_0x2A:
	LDS  R26,_x1
	LDS  R27,_x1+1
	LDS  R24,_x1+2
	LDS  R25,_x1+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2B:
	RCALL __CWD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:49 WORDS
SUBOPT_0x2C:
	STS  _x2,R30
	STS  _x2+1,R31
	STS  _x2+2,R22
	STS  _x2+3,R23
	RCALL SUBOPT_0x2A
	RCALL __ADDD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x2D:
	LDS  R30,_b6
	LDS  R31,_b6+1
	LDS  R22,_b6+2
	LDS  R23,_b6+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2E:
	LDS  R26,_b6
	LDS  R27,_b6+1
	LDS  R24,_b6+2
	LDS  R25,_b6+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2F:
	STS  _x3,R30
	STS  _x3+1,R31
	STS  _x3+2,R22
	STS  _x3+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x30:
	__ADDD1N 2
	RCALL __ASRD1
	RCALL __ASRD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x31:
	LDS  R26,_b7
	LDS  R27,_b7+1
	LDS  R24,_b7+2
	LDS  R25,_b7+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x32:
	LDS  R30,_b4
	LDS  R31,_b4+1
	LDS  R22,_b4+2
	LDS  R23,_b4+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x33:
	__GETD2S 2
	LDI  R30,LOW(8)
	RCALL __ASRD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x34:
	STS  _x1,R30
	STS  _x1+1,R31
	STS  _x1+2,R22
	STS  _x1+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x35:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x36:
	STS  _slot,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x37:
	RCALL SUBOPT_0x36
	SET
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x38:
	__POINTW1FN _0x0,0
	RCALL SUBOPT_0x1D
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x39:
	LDI  R30,LOW(0)
	OUT  0x3B,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 17 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x3A:
	STS  _state,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x3B:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x3C:
	LDI  R30,LOW(0)
	STS  _encoder,R30
	STS  _encoder+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x3D:
	STS  _timer_rto,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x3E:
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x3F:
	LDI  R30,LOW(0)
	RJMP SUBOPT_0x3A

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x40:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x41:
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x42:
	RCALL SUBOPT_0x26
	RCALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:20 WORDS
SUBOPT_0x43:
	LDI  R30,LOW(0)
	STS  _delay,R30
	STS  _delay+1,R30
	LDI  R30,LOW(1)
	OUT  0x2E,R30
	LDI  R30,LOW(4)
	OUT  0x39,R30
	LDI  R30,LOW(0)
	RCALL SUBOPT_0x3D
	RJMP SUBOPT_0x40

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x44:
	CLT
	BLD  R3,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x45:
	__POINTW1FN _0x0,41
	RCALL SUBOPT_0x1D
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x46:
	LDS  R26,_timer_rto
	CPI  R26,LOW(0x7A)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x47:
	IN   R30,0x2C
	IN   R31,0x2C+1
	RCALL SUBOPT_0x1E
	__GETD2N 0x3983126F
	RCALL __MULF12
	STS  _delay_timer,R30
	STS  _delay_timer+1,R31
	STS  _delay_timer+2,R22
	STS  _delay_timer+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x48:
	STS  _delay_timer_kirim,R30
	STS  _delay_timer_kirim+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x49:
	LDI  R24,4
	RCALL _printf
	ADIW R28,6
	LDI  R30,LOW(11)
	OUT  0x2E,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x4A:
	RCALL SUBOPT_0x1D
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x4B:
	ST   -Y,R18
	LDD  R26,Y+19
	LDD  R27,Y+19+1
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x4C:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x4D:
	SBIW R30,4
	STD  Y+22,R30
	STD  Y+22+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x4E:
	LDD  R26,Y+19
	LDD  R27,Y+19+1
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x4F:
	RCALL SUBOPT_0x4C
	RJMP SUBOPT_0x4D

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x50:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,4
	RCALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x51:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x52:
	__PUTD1S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x53:
	ANDI R16,LOW(251)
	LDD  R30,Y+17
	ST   -Y,R30
	RJMP SUBOPT_0x4E

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x54:
	RCALL SUBOPT_0x1F
	__GETD2S 12
	RET


	.CSEG
	.equ __i2c_dir=__i2c_port-1
	.equ __i2c_pin=__i2c_port-2

_i2c_init:
	cbi  __i2c_port,__scl_bit
	cbi  __i2c_port,__sda_bit
	sbi  __i2c_dir,__scl_bit
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_delay2
_i2c_start:
	cbi  __i2c_dir,__sda_bit
	cbi  __i2c_dir,__scl_bit
	clr  r30
	nop
	sbis __i2c_pin,__sda_bit
	ret
	sbis __i2c_pin,__scl_bit
	ret
	rcall __i2c_delay1
	sbi  __i2c_dir,__sda_bit
	rcall __i2c_delay1
	sbi  __i2c_dir,__scl_bit
	ldi  r30,1
__i2c_delay1:
	ldi  r22,3
	rjmp __i2c_delay2l
_i2c_stop:
	sbi  __i2c_dir,__sda_bit
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__sda_bit
__i2c_delay2:
	ldi  r22,6
__i2c_delay2l:
	dec  r22
	brne __i2c_delay2l
	ret
_i2c_read:
	ldi  r23,8
__i2c_read0:
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
__i2c_read3:
	sbis __i2c_pin,__scl_bit
	rjmp __i2c_read3
	rcall __i2c_delay1
	clc
	sbic __i2c_pin,__sda_bit
	sec
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	rol  r30
	dec  r23
	brne __i2c_read0
	mov  r23,r26
	tst  r23
	brne __i2c_read1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_read2
__i2c_read1:
	sbi  __i2c_dir,__sda_bit
__i2c_read2:
	rcall __i2c_delay1
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_delay1

_i2c_write:
	ldi  r23,8
__i2c_write0:
	lsl  r26
	brcc __i2c_write1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_write2
__i2c_write1:
	sbi  __i2c_dir,__sda_bit
__i2c_write2:
	rcall __i2c_delay2
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
__i2c_write3:
	sbis __i2c_pin,__scl_bit
	rjmp __i2c_write3
	rcall __i2c_delay1
	sbi  __i2c_dir,__scl_bit
	dec  r23
	brne __i2c_write0
	cbi  __i2c_dir,__sda_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	ldi  r30,1
	sbic __i2c_pin,__sda_bit
	clr  r30
	sbi  __i2c_dir,__scl_bit
	rjmp __i2c_delay1

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x1CD
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__SWAPACC:
	PUSH R20
	MOVW R20,R30
	MOVW R30,R26
	MOVW R26,R20
	MOVW R20,R22
	MOVW R22,R24
	MOVW R24,R20
	MOV  R20,R0
	MOV  R0,R1
	MOV  R1,R20
	POP  R20
	RET

__UADD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	RET

__NEGMAN1:
	COM  R30
	COM  R31
	COM  R22
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	RET

__SUBF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129
	LDI  R21,0x80
	EOR  R1,R21

	RJMP __ADDF120

__ADDF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129

__ADDF120:
	CPI  R23,0x80
	BREQ __ADDF128
__ADDF121:
	MOV  R21,R23
	SUB  R21,R25
	BRVS __ADDF1211
	BRPL __ADDF122
	RCALL __SWAPACC
	RJMP __ADDF121
__ADDF122:
	CPI  R21,24
	BRLO __ADDF123
	CLR  R26
	CLR  R27
	CLR  R24
__ADDF123:
	CPI  R21,8
	BRLO __ADDF124
	MOV  R26,R27
	MOV  R27,R24
	CLR  R24
	SUBI R21,8
	RJMP __ADDF123
__ADDF124:
	TST  R21
	BREQ __ADDF126
__ADDF125:
	LSR  R24
	ROR  R27
	ROR  R26
	DEC  R21
	BRNE __ADDF125
__ADDF126:
	MOV  R21,R0
	EOR  R21,R1
	BRMI __ADDF127
	RCALL __UADD12
	BRCC __ADDF129
	ROR  R22
	ROR  R31
	ROR  R30
	INC  R23
	BRVC __ADDF129
	RJMP __MAXRES
__ADDF128:
	RCALL __SWAPACC
__ADDF129:
	RCALL __REPACK
	POP  R21
	RET
__ADDF1211:
	BRCC __ADDF128
	RJMP __ADDF129
__ADDF127:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	BREQ __ZERORES
	BRCC __ADDF1210
	COM  R0
	RCALL __NEGMAN1
__ADDF1210:
	TST  R22
	BRMI __ADDF129
	LSL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVC __ADDF1210

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __DIVF219
	RJMP __MINRES
__DIVF219:
	RJMP __MAXRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R17
	CLR  R18
	CLR  R19
	CLR  R20
	CLR  R21
	LDI  R25,32
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R20,R17
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R20,R17
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R21
	ROL  R18
	ROL  R19
	ROL  R1
	ROL  R26
	ROL  R27
	ROL  R24
	ROL  R20
	DEC  R25
	BRNE __DIVF212
	MOVW R30,R18
	MOV  R22,R1
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	TST  R22
	BRMI __DIVF215
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__CMPF12:
	TST  R25
	BRMI __CMPF120
	TST  R23
	BRMI __CMPF121
	CP   R25,R23
	BRLO __CMPF122
	BRNE __CMPF121
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	BRLO __CMPF122
	BREQ __CMPF123
__CMPF121:
	CLZ
	CLC
	RET
__CMPF122:
	CLZ
	SEC
	RET
__CMPF123:
	SEZ
	CLC
	RET
__CMPF120:
	TST  R23
	BRPL __CMPF122
	CP   R25,R23
	BRLO __CMPF121
	BRNE __CMPF122
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	BRLO __CMPF122
	BREQ __CMPF123
	RJMP __CMPF121

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ADDD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	ADC  R23,R25
	RET

__ADDD21:
	ADD  R26,R30
	ADC  R27,R31
	ADC  R24,R22
	ADC  R25,R23
	RET

__SUBD12:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	SBC  R23,R25
	RET

__SUBD21:
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R25,R23
	RET

__ORD12:
	OR   R30,R26
	OR   R31,R27
	OR   R22,R24
	OR   R23,R25
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__LSLD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __LSLD12R
__LSLD12L:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R0
	BRNE __LSLD12L
__LSLD12R:
	RET

__ASRD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __ASRD12R
__ASRD12L:
	ASR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R0
	BRNE __ASRD12L
__ASRD12R:
	RET

__LSRD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __LSRD12R
__LSRD12L:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R0
	BRNE __LSRD12L
__LSRD12R:
	RET

__ASRD1:
	ASR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	RET

__LSLD1:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	RET

__ASRD16:
	MOV  R30,R22
	MOV  R31,R23
	CLR  R22
	SBRC R31,7
	SER  R22
	MOV  R23,R22
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__CWD2:
	MOV  R24,R27
	ADD  R24,R24
	SBC  R24,R24
	MOV  R25,R24
	RET

__MULD12U:
	MUL  R23,R26
	MOV  R23,R0
	MUL  R22,R27
	ADD  R23,R0
	MUL  R31,R24
	ADD  R23,R0
	MUL  R30,R25
	ADD  R23,R0
	MUL  R22,R26
	MOV  R22,R0
	ADD  R23,R1
	MUL  R31,R27
	ADD  R22,R0
	ADC  R23,R1
	MUL  R30,R24
	ADD  R22,R0
	ADC  R23,R1
	CLR  R24
	MUL  R31,R26
	MOV  R31,R0
	ADD  R22,R1
	ADC  R23,R24
	MUL  R30,R27
	ADD  R31,R0
	ADC  R22,R1
	ADC  R23,R24
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	ADC  R22,R24
	ADC  R23,R24
	RET

__MULD12:
	RCALL __CHKSIGND
	RCALL __MULD12U
	BRTC __MULD121
	RCALL __ANEGD1
__MULD121:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	CLR  R20
	CLR  R21
	LDI  R19,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R20
	ROL  R21
	SUB  R0,R30
	SBC  R1,R31
	SBC  R20,R22
	SBC  R21,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R20,R22
	ADC  R21,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R19
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOVW R24,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__DIVD21:
	RCALL __CHKSIGND
	RCALL __DIVD21U
	BRTC __DIVD211
	RCALL __ANEGD1
__DIVD211:
	RET

__MODD21U:
	RCALL __DIVD21U
	MOVW R30,R26
	MOVW R22,R24
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__CHKSIGND:
	CLT
	SBRS R23,7
	RJMP __CHKSD1
	RCALL __ANEGD1
	SET
__CHKSD1:
	SBRS R25,7
	RJMP __CHKSD2
	CLR  R0
	COM  R26
	COM  R27
	COM  R24
	COM  R25
	ADIW R26,1
	ADC  R24,R0
	ADC  R25,R0
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSD2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETD1P:
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X
	SBIW R26,3
	RET

__PUTDP1:
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	RET

__GETD1S0:
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R22,Y+2
	LDD  R23,Y+3
	RET

__PUTD1S0:
	ST   Y,R30
	STD  Y+1,R31
	STD  Y+2,R22
	STD  Y+3,R23
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__CPD10:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__LOADLOCR2P:
	LD   R16,Y+
	LD   R17,Y+
	RET

;END OF CODE MARKER
__END_OF_CODE:
