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
module Centro_Control (
	//////////// OUTPUTS //////////
	Centro_Control_Mux_A,
	Centro_Control_Mux_B,
	Centro_Control_Mux_C,
	Centro_Control_Selector_Mux_A,
	Centro_Control_Selector_Mux_B,
	Centro_Control_Selector_Mux_C,
	Centro_Control_RD,
	Centro_Control_WR,
	Centro_Control_ALU,
	//////////// INPUTS //////////
	Centro_Control_ACK,
	Centro_Control_IR,
	Centro_Control_Bit13,
	Centro_Control_ALU_overflow_Low,
	Centro_Control_ALU_carry_Low,
	Centro_Control_ALU_negative_Low,
	Centro_Control_ALU_zero_Low,
	Centro_Control_CLOCK_50,
	Centro_Control_RESET_InHigh,
	Centro_Control_clear_InLow,
	Centro_Control_load_InLow,
	Centro_Control_Conditions_C
);
//=======================================================
//  PARAMETER declarations
//=======================================================
parameter DATAWIDTH_BUS_IR= 32;
parameter DATAWIDTH_BUS_MUX= 6;
parameter DATAWIDTH_ALU= 4;
parameter OUT_CSAI = 11;
parameter DATAWIDTH_COND = 3;
parameter DATAWIDTH_ADRR = 11;
parameter DATAWIDTH_SELECTION_LENG = 2;
parameter DATAWIDTH_MIR = 41;

//=======================================================
//  PORT declarations
//=======================================================

//////////// INPUTS //////////

input 	[DATAWIDTH_BUS_IR-1:0]	Centro_Control_IR;
input 	Centro_Control_ALU_overflow_Low;
input 	Centro_Control_ALU_carry_Low;
input 	Centro_Control_ALU_negative_Low;
input 	Centro_Control_ALU_zero_Low;
input 	Centro_Control_CLOCK_50;
input 	Centro_Control_RESET_InHigh;
input 	Centro_Control_Bit13;
input		Centro_Control_ACK;          //Viene de Main Memory
input 	Centro_Control_clear_InLow;
input 	Centro_Control_load_InLow;
input		Centro_Control_Conditions_C;

//////////// OUTPUTS //////////

output 	[DATAWIDTH_BUS_MUX-1:0]	Centro_Control_Mux_A;
output 	[DATAWIDTH_BUS_MUX-1:0]	Centro_Control_Mux_B;
output 	[DATAWIDTH_BUS_MUX-1:0]	Centro_Control_Mux_C;
output 	[DATAWIDTH_ALU-1:0] Centro_Control_ALU;
output 	Centro_Control_Selector_Mux_A;
output 	Centro_Control_Selector_Mux_B;
output 	Centro_Control_Selector_Mux_C;
output   Centro_Control_WR;
output	Centro_Control_RD;


//=======================================================
//  REG/WIRE declarations
//=======================================================

wire [OUT_CSAI-1:0] OUTBUS_CSAI_CSMUX_CABLE;
wire [OUT_CSAI-1:0] JUMP_ADRR_CSAI_CSMUX_CABLE;
wire [DATAWIDTH_COND-1:0] COND_MIR_CBL_CABLE;
wire [DATAWIDTH_ADRR-1:0] JUMP_ADRR_MIR_CSMUX_CABLE;
wire [DATAWIDTH_SELECTION_LENG-1:0] selector_CBL_CSMUX_CABLE;
wire [DATAWIDTH_ALU-1:0] FLAGS_PSR_CBL_CABLE;
wire [DATAWIDTH_MIR-1:0] ROM_TO_MIR;
//=======================================================
//  Structural coding
//=======================================================

//-------------------------------------------------------
//GENERAL_REGISTERS
CS_CSAI Centro_Control_CS_CSAI (
// port map - connection between master ports and signals/registers   
	.CS_CSAI_data_OutBUS(OUTBUS_CSAI_CSMUX_CABLE),
	.CS_CSAI_JUMP_ADDR(JUMP_ADRR_CSAI_CSMUX_CABLE),
	.CS_CSAI_ACK(Centro_Control_ACK),
	.CS_CSAI_RESET(Centro_Control_RESET_InHigh),
	.CS_CSAI_CLOCK_50(Centro_Control_CLOCK_50)

);

CS_CS_ADDRESS_MUX Centro_Control_CS_ADDRESS_MUX (
// port map - connection between master ports and signals/registers   
	.CS_CS_ADDRESS_MUX_data_OutBUS(JUMP_ADRR_CSAI_CSMUX_CABLE),
	.CS_CS_ADDRESS_MUX_data_CSAI(OUTBUS_CSAI_CSMUX_CABLE),
	.CS_CS_ADDRESS_MUX_data_MIR(JUMP_ADRR_MIR_CSMUX_CABLE),
	.CS_CS_ADDRESS_MUX_data_Scratchpad({Centro_Control_IR[31:30],Centro_Control_IR[24:19]}),
	.CS_CS_ADDRESS_MUX_data_Uno(1),
	.CS_CS_ADDRESS_MUX_data_CeroUno(0),
	.CS_CS_ADDRESS_MUX_data_CeroDos(0),
	.CS_CS_ADDRESS_MUX_selection_InBUS(selector_CBL_CSMUX_CABLE)
);


CS_MIR Centro_Control_CS_MIR (
// port map - connection between master ports and signals/registers   
	.CS_MIR_A_data_OutBUS(Centro_Control_Mux_A),
	.CS_MIR_AMUX_data_Out(Centro_Control_Selector_Mux_A),
	.CS_MIR_B_data_OutBUS(Centro_Control_Mux_B),
	.CS_MIR_BMUX_data_Out(Centro_Control_Selector_Mux_B),
	.CS_MIR_C_data_OutBUS(Centro_Control_Mux_C),
	.CS_MIR_CMUX_data_Out(Centro_Control_Selector_Mux_C),
	.CS_MIR_RD_data_Out(Centro_Control_RD),
	.CS_MIR_WR_data_Out(Centro_Control_WR),
	.CS_MIR_ALU_data_OutBUS(Centro_Control_ALU),
	.CS_MIR_COND_data_OutBUS(COND_MIR_CBL_CABLE),
	.CS_MIR_ADDRESS_data_OutBUS(JUMP_ADRR_MIR_CSMUX_CABLE),
	// ---- Entradas ------------
	.CS_MIR_CLOCK_50(Centro_Control_CLOCK_50),
	.CS_MIR_RESET_InHigh(Centro_Control_RESET_InHigh),
	.CS_MIR_clear_InLow(Centro_Control_clear_InLow),
	.CS_MIR_load_InLow(Centro_Control_load_InLow),
	.CS_MIR_INSTRUCTION_data_InBUS(ROM_TO_MIR)
);

CC_PSR #( .DATAWIDTH_ALU_SELECTION(DATAWIDTH_ALU)) Centro_Control_PSR (
	//------Salidas----------------
	.CC_PSR_OUT(FLAGS_PSR_CBL_CABLE),
	//------Entradas---------------
	.Set_Conditions_C(Centro_Control_Conditions_C),
	.CC_overflow(Centro_Control_ALU_overflow_Low),
	.CC_carry(Centro_Control_ALU_carry_Low),
	.CC_negative(Centro_Control_ALU_negative_Low),
	.CC_zero(Centro_Control_ALU_zero_Low),
	.CC_PSR_CLOCK_50(Centro_Control_CLOCK_50)
);

//CS_MIR #(.ROM_BUS_In(OUT_CSAI), .ROM_BUS_Out(DATAWIDTH_MIR)) Centro_Control_ROM (
//	// port map - connection between master ports and signals/registers
//	// ---- Salidas -------------
//	.ROM_DataBUS_Out(ROM_TO_MIR),
//	// ---- Entradas ------------
//	.ROM_DataBUS_In(JUMP_ADRR_CSAI_CSMUX_CABLE)
//);

endmodule


