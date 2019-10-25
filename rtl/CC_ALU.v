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
module CC_ALU #(parameter DATAWIDTH_BUS=8, parameter DATAWIDTH_ALU_SELECTION=4)(
	//////////// OUTPUTS //////////
	CC_ALU_overflow_OutLow,
	CC_ALU_carry_OutLow,
	CC_ALU_negative_OutLow,
	CC_ALU_zero_OutLow,
	CC_ALU_data_OutBUS,
	Set_Conditions_Code,
	//////////// INPUTS //////////
	CC_ALU_dataA_InBUS,
	CC_ALU_dataB_InBUS,
	CC_ALU_selection_InBUS
	
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output 			CC_ALU_overflow_OutLow;
output 			CC_ALU_carry_OutLow;
output 			CC_ALU_negative_OutLow;
output 			CC_ALU_zero_OutLow;
output         Set_Conditions_Code;
output reg		[DATAWIDTH_BUS-1:0] CC_ALU_data_OutBUS;
input			[DATAWIDTH_BUS-1:0] CC_ALU_dataA_InBUS;
input			[DATAWIDTH_BUS-1:0] CC_ALU_dataB_InBUS;
input			[DATAWIDTH_ALU_SELECTION-1:0] CC_ALU_selection_InBUS;
//=======================================================
//  REG/WIRE declarations
//=======================================================
wire caover,cout;
wire [DATAWIDTH_BUS-2:0] addition0; // Variable usada para la operación suma y para determinar las flags
wire addition1;		// Variable usada para la operación suma y para determinar las flags
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always@(*)
begin
	case (CC_ALU_selection_InBUS)	
		4'b0000:  CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS - CC_ALU_dataB_InBUS;	//SUBCC
		4'b0001:  CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS | CC_ALU_dataB_InBUS;	//ORCC
		4'b0010:  CC_ALU_data_OutBUS = ~(CC_ALU_dataA_InBUS | CC_ALU_dataB_InBUS); //NORCC	
		4'b0011:  CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS + CC_ALU_dataB_InBUS;	//ADDCC
//		4'b0100:  CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS ^ CC_ALU_dataB_InBUS;	//XOR

		4'b0101:  CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS & CC_ALU_dataB_InBUS;	//AND
		4'b0110:  CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS | CC_ALU_dataB_InBUS;	//OR
		4'b0111:  CC_ALU_data_OutBUS = ~(CC_ALU_dataA_InBUS | CC_ALU_dataB_InBUS); //NOR	
		4'b1000:  CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS + CC_ALU_dataB_InBUS;	//ADD

		4'b1001:  CC_ALU_data_OutBUS = {CC_ALU_dataA_InBUS[DATAWIDTH_BUS-3:0], 2'b00};	//LSHIFT2
		4'b1010:  CC_ALU_data_OutBUS = {CC_ALU_dataA_InBUS[DATAWIDTH_BUS-11:0], 10'b0000000000};	//LSHIFT10
		4'b1011:  CC_ALU_data_OutBUS = {19'b0000000000000000000,CC_ALU_dataA_InBUS[DATAWIDTH_BUS-20:0]}; //SIMM13
		4'b1100:  begin
				if(CC_ALU_dataA_InBUS[12]==1) begin //SEXT13 
						CC_ALU_data_OutBUS = {19'b1111111111111111111, CC_ALU_dataA_InBUS[12:0]};
					end
				else
					begin
						CC_ALU_data_OutBUS = {19'b0000000000000000000, CC_ALU_dataA_InBUS[12:0]};
					end
			 end
		4'b1101: CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS + 1'b1;				//INCREMENT A 1
		4'b1110: CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS + 3'b100;				//INCREMENT A 4
		4'b1111: CC_ALU_data_OutBUS = {CC_ALU_dataA_InBUS[31], CC_ALU_dataA_InBUS[31], CC_ALU_dataA_InBUS[31], CC_ALU_dataA_InBUS[31], CC_ALU_dataA_InBUS[31], CC_ALU_dataA_InBUS[DATAWIDTH_BUS-1:5]};	//RSHIFT5

		default :  CC_ALU_data_OutBUS = CC_ALU_dataA_InBUS; // channel 0 is selected
	endcase
end
//=======================================================
//  Outputs
//=======================================================
/*Flags*/
assign {caover,addition0[DATAWIDTH_BUS-2:0]}=CC_ALU_dataA_InBUS[DATAWIDTH_BUS-2:0] + CC_ALU_dataB_InBUS[DATAWIDTH_BUS-2:0]; 	// Determinación de carry del bit número 7
assign {cout,addition1}= CC_ALU_dataA_InBUS[DATAWIDTH_BUS-1] + CC_ALU_dataB_InBUS[DATAWIDTH_BUS-1] + caover;	// Determinación de la flag Carry y la suma de busA y busB
assign CC_ALU_zero_OutLow=(CC_ALU_data_OutBUS==8'b00000000) ? 1'b0 : 1'b1;	// Determinación de la flag Zero
assign CC_ALU_carry_OutLow = ~cout;
assign CC_ALU_overflow_OutLow = ~ (caover ^ cout);		// Determinación de la flag Ov a partir de la flag Carry y el carry del bit 7
assign CC_ALU_negative_OutLow = ~ (CC_ALU_data_OutBUS[DATAWIDTH_BUS-1]);
assign Set_Conditions_Code = (CC_ALU_selection_InBUS[3:2]==2'b00) ? 1'b0 : 1'b1;

endmodule
