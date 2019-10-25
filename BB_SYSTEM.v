/*######################################################################
//#	G0B1T: HDL EXAMPLES. 2018.
//######################################################################
//# Copyright (C) 2018. F.E.Segura-Quijano (FES) fsegura@uniandes.edu.co
//# 
//# This program is free software: you can redistribute it and/or modify
//# it under the terms of the GNU General Public License as published by
//# the Free Software Foundation, version 3 of the License.
//#
//# This program is distributed in the hope that it will be useful,
//# but WITHOUT ANY WARRANTY; without even the implied warranty of
//# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//# GNU General Public License for more details.
//#
//# You should have received a copy of the GNU General Public License
//# along with this program.  If not, see <http://www.gnu.org/licenses/>
//####################################################################*/
//=======================================================
//  MODULE Definition
//=======================================================
module BB_SYSTEM (
//////////// OUTPUTS //////////
	BB_SYSTEM_data_OutBUS,
//////////// INPUTS //////////
	BB_SYSTEM_CLOCK_50,
	BB_SYSTEM_RESET_InHigh
);
//=======================================================
//  PARAMETER declarations
//=======================================================
// uDATAPATH WIDTH BUS.
parameter DATAWIDTH_BUS = 32;
// SHIFTREGISTER CONTROL BUS.
parameter DATAWIDTH_REGSHIFTER_SELECTION = 2;
// DECODER CONTROL INPUT BUS.
parameter DATAWIDTH_DECODER_SELECTION = 4;
// DECODER CONTROL OUTPUT BUS.
parameter DATAWIDTH_DECODER_OUT = 12;
// ALU CONTROL BUS.
parameter DATAWIDTH_ALU_SELECTION = 4;
// MUX CONTROL BUS.
parameter DATAWIDTH_MUX_SELECTION = 4;
// FIXED_REGISTERS INIT DATA.
parameter DATA_REGFIXED_INIT_0 = 8'b00001001;
parameter DATA_REGFIXED_INIT_1 = 8'b00001111;
parameter DATA_BUS_CONTROL = 6;
parameter DATAWIDTH_CENTRO_CONTROL_ALU = 4;
//=======================================================
//  PORT declarations
//=======================================================
output	[DATAWIDTH_BUS-1:0] BB_SYSTEM_data_OutBUS;
input 	BB_SYSTEM_CLOCK_50;
input 	BB_SYSTEM_RESET_InHigh;
//=======================================================
//  REG/WIRE declarations
//=======================================================
// FLAGS
wire uDATAPATH_2_STATEMACHINE_overflow_wireCONTROL;
wire uDATAPATH_2_STATEMACHINE_carry_wireCONTROL;
wire uDATAPATH_2_STATEMACHINE_negative_wireCONTROL;
wire uDATAPATH_2_STATEMACHINE_zero_wireCONTROL;

// DECODER CONTROL BUS: TO SELECT GENERAL_REGISTER TO CLEAR DATA. ¡ONE BY ONE, NOT AT SAME TIME!
wire [DATAWIDTH_DECODER_SELECTION-1:0] STATEMACHINE_2_uDATAPATH_decoderclearselection_wireCONTROL; 

// DECODER CONTROL BUS: TO SELECT GENERAL_REGISTER TO LOAD DATA FROM DATA_BUS_C. ¡ONE BY ONE, NOT AT SAME TIME!
wire [DATAWIDTH_DECODER_SELECTION-1:0] STATEMACHINE_2_uDATAPATH_decoderloadselection_wireCONTROL; 

//ALU CONTROL. TO SELECT ALU OPERATION.
wire [DATAWIDTH_ALU_SELECTION-1:0] STATEMACHINE_2_uDATAPATH_aluselection_wireCONTROL;

// SHIFT_REGISTER CONTROL. TO CLEAR DATA
wire STATEMACHINE_2_uDATAPATH_regSHIFTERclear_wireCONTROL;

// SHIFT_REGISTER CONTROL. TO LOAD DATA
wire STATEMACHINE_2_uDATAPATH_regSHIFTERload_wireCONTROL;

// SHIFT_REGISTER CONTROL. TO SHIFT DATA
wire [DATAWIDTH_REGSHIFTER_SELECTION-1:0] STATEMACHINE_2_uDATAPATH_regSHIFTERshiftselection_wireCONTROL;

// ENTRADAS A LOS MUX DESDE CONTROL
wire [DATA_BUS_CONTROL - 1:0] Bus_Control_A;
wire [DATA_BUS_CONTROL - 1:0] Bus_Control_B;
wire [DATA_BUS_CONTROL - 1:0] Bus_Control_C;

// NUEVAS CONEXIONES
wire Selector_Bus_A_CentroControl_uDATAPATH_Cable;
wire Selector_Bus_B_CentroControl_uDATAPATH_Cable;
wire Selector_Bus_C_CentroControl_uDATAPATH_Cable;
wire [DATAWIDTH_BUS-1:0] IR_uDATAPATH_Centro_Control_Cable;
wire Centro_Control_clear_InLow_Cable;
wire Centro_Control_load_InLow_Cable;
wire [DATAWIDTH_CENTRO_CONTROL_ALU-1:0] ALU_uDATAPATH_Centro_Control_Cable;

// CONEXIONES ENTRE MAIN MEMORY Y CENTRO DE CONTROL
wire ACK_Main_Memory_Centro_Control_Cable;
wire RD_Centro_Control_Main_Memory_Cable;
wire WR_Centro_Control_Main_Memory_Cable;

// CONEXIONES ENTRE MAIN MEMORY Y DATAPATH
wire [DATAWIDTH_BUS-1:0] Main_Memory_To_CC_MUXX_BUS_64_TO_32_Cable;
wire [DATAWIDTH_BUS-1:0] ALU_To_CC_MUXX_BUS_64_TO_32_Cable;
wire [DATAWIDTH_BUS-1:0] CC_MUXX_BUS_64_TO_32_TO_BUSSC_Cable;
wire [DATAWIDTH_BUS-1:0] BUSA_To_Main_Memory_Cable;
wire [DATAWIDTH_BUS-1:0] BUSB_To_Main_Memory_Cable;

// CONEXIÓN QUE HABILITA LAS BANDERAS
wire ALU_To_Centro_Control_Flag_Habilitador_Cable;
//=======================================================
//  Structural coding
//=======================================================
uDATAPATH #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATAWIDTH_DECODER_SELECTION(DATAWIDTH_DECODER_SELECTION), .DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT), .DATAWIDTH_ALU_SELECTION(DATAWIDTH_ALU_SELECTION), .DATAWIDTH_MUX_SELECTION(DATAWIDTH_MUX_SELECTION), .DATA_REGFIXED_INIT_0(DATA_REGFIXED_INIT_0), .DATA_REGFIXED_INIT_1(DATA_REGFIXED_INIT_1), .DATA_BUS_CONTROL(DATA_BUS_CONTROL)) uDATAPATH_u0 (
// port map - connection between master ports and signals/registers   
	.uDATAPATH_data_OutBUS(ALU_To_CC_MUXX_BUS_64_TO_32_Cable),
	.uDATAPATH_overflow_OutLow(uDATAPATH_2_STATEMACHINE_overflow_wireCONTROL),
	.uDATAPATH_carry_OutLow(uDATAPATH_2_STATEMACHINE_carry_wireCONTROL),
	.uDATAPATH_negative_OutLow(uDATAPATH_2_STATEMACHINE_negative_wireCONTROL),
	.uDATAPATH_zero_OutLow(uDATAPATH_2_STATEMACHINE_zero_wireCONTROL),
	.uDATAPATH_Habilitador_PSR(ALU_To_Centro_Control_Flag_Habilitador_Cable),
	.uDATAPATH_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.uDATAPATH_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.uDATAPATH_decoderclearselection_InBUS(STATEMACHINE_2_uDATAPATH_decoderclearselection_wireCONTROL), 
	.uDATAPATH_decoderloadselection_InBUS(STATEMACHINE_2_uDATAPATH_decoderloadselection_wireCONTROL), 
	.uDATAPATH_BUS_A(BUSA_To_Main_Memory_Cable),
	.uDATAPATH_BUS_B(BUSB_To_Main_Memory_Cable),
	
	.uDATAPATH_aluselection_InBUS(ALU_uDATAPATH_Centro_Control_Cable),
	.uDATAPATH_regSHIFTERclear_InLow(STATEMACHINE_2_uDATAPATH_regSHIFTERclear_wireCONTROL),
	.uDATAPATH_regSHIFTERload_InLow(STATEMACHINE_2_uDATAPATH_regSHIFTERload_wireCONTROL),
	.uDATAPATH_regSHIFTERshiftselection_InLow(STATEMACHINE_2_uDATAPATH_regSHIFTERshiftselection_wireCONTROL),
	.uDATAPATH_BUS_CONTROL_A(Bus_Control_A),
	.uDATAPATH_BUS_CONTROL_B(Bus_Control_B),
	.uDATAPATH_BUS_CONTROL_C(Bus_Control_C),
	.uDATAPATH_BUS_SELECTOR_A(Selector_Bus_A_CentroControl_uDATAPATH_Cable),
	.uDATAPATH_BUS_SELECTOR_B(Selector_Bus_B_CentroControl_uDATAPATH_Cable),
	.uDATAPATH_BUS_SELECTOR_C(Selector_Bus_C_CentroControl_uDATAPATH_Cable),
	.uDATAPATH_Registro_IR(IR_uDATAPATH_Centro_Control_Cable),
	.uDATAPATH_BUS_C(CC_MUXX_BUS_64_TO_32_TO_BUSSC_Cable)
	
);

Centro_Control Centro_Control_u0 (
   //--------INPUTS----------------------------
	.Centro_Control_ACK(ACK_Main_Memory_Centro_Control_Cable),
	.Centro_Control_IR(IR_uDATAPATH_Centro_Control_Cable),
	.Centro_Control_Bit13(IR_uDATAPATH_Centro_Control_Cable[13]),
	.Centro_Control_ALU_overflow_Low(uDATAPATH_2_STATEMACHINE_overflow_wireCONTROL),
	.Centro_Control_ALU_carry_Low(uDATAPATH_2_STATEMACHINE_carry_wireCONTROL),
	.Centro_Control_ALU_negative_Low(uDATAPATH_2_STATEMACHINE_negative_wireCONTROL),
	.Centro_Control_ALU_zero_Low(uDATAPATH_2_STATEMACHINE_zero_wireCONTROL),
	.Centro_Control_Conditions_C(ALU_To_Centro_Control_Flag_Habilitador_Cable),
	.Centro_Control_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.Centro_Control_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.Centro_Control_clear_InLow(Centro_Control_clear_InLow_Cable),
	.Centro_Control_load_InLow(Centro_Control_load_InLow_Cable),
	//--------OUTPUTS---------------------------
	.Centro_Control_Mux_A(Bus_Control_A),
	.Centro_Control_Mux_B(Bus_Control_B),
	.Centro_Control_Mux_C(Bus_Control_C),
	.Centro_Control_Selector_Mux_A(Selector_Bus_A_CentroControl_uDATAPATH_Cable),
	.Centro_Control_Selector_Mux_B(Selector_Bus_B_CentroControl_uDATAPATH_Cable),
	.Centro_Control_Selector_Mux_C(Selector_Bus_C_CentroControl_uDATAPATH_Cable),
	.Centro_Control_RD(RD_Centro_Control_Main_Memory_Cable),
	.Centro_Control_WR(WR_Centro_Control_Main_Memory_Cable),
	.Centro_Control_ALU(ALU_uDATAPATH_Centro_Control_Cable)
);

CC_MUXX_BUS_64_TO_32 CC_MUXX_BUS_64_TO_32_u0 (
	//------OUTPUTS--------------------------
	.CC_MUX_data_OutBUS(CC_MUXX_BUS_64_TO_32_TO_BUSSC_Cable),
	//-------INPUTS--------------------------
	.CC_MUX_BUS_64_TO_32_InBUS_Main_Memory(Main_Memory_To_CC_MUXX_BUS_64_TO_32_Cable),
	.CC_MUX_BUS_64_TO_32_ALU(ALU_To_CC_MUXX_BUS_64_TO_32_Cable),
	.CC_MUX_BUS_64_TO_32_RD(RD_Centro_Control_Main_Memory_Cable)
);

MAIN_MEMORY MAIN_MEMORY_u0 (
	//--------INPUTS----------------------------
	.MAIN_MEMORY_data_InBUS(BUSB_To_Main_Memory_Cable),
	.MAIN_MEMORY_ADDRESS_data_InBUS(BUSA_To_Main_Memory_Cable),
	.MAIN_MEMORY_RD_data_In(RD_Centro_Control_Main_Memory_Cable),
	.MAIN_MEMORY_WR_data_In(WR_Centro_Control_Main_Memory_Cable),
	.MAIN_MEMORY_CLOCK_50(BB_SYSTEM_CLOCK_50),
	//--------OUTPUTS---------------------------
	.MAIN_MEMORY_data_OutBUS(Main_Memory_To_CC_MUXX_BUS_64_TO_32_Cable),
	.MAIN_MEMORY_ACK(ACK_Main_Memory_Centro_Control_Cable)
);

endmodule
