module CC_PSR #(parameter DATAWIDTH_ALU_SELECTION=4)(
  //////////// OUTPUTS //////////
	CC_PSR_OUT,
	//////////// INPUTS //////////
  Set_Conditions_C,
   CC_overflow,
	CC_carry,
	CC_negative,
	CC_zero,
	CC_PSR_CLOCK_50	
);

//=======================================================
//  PORT declarations
//=======================================================
	output reg		[DATAWIDTH_ALU_SELECTION-1:0]	CC_PSR_OUT;
	input          CC_overflow;
	input          CC_carry;
	input          CC_negative;
	input          CC_zero;
	input          Set_Conditions_C;
	input          CC_PSR_CLOCK_50;

//=======================================================
//  REG/WIRE declarations
//=======================================================
	reg [DATAWIDTH_ALU_SELECTION-1:0] RegGENERAL_Register;
	reg [DATAWIDTH_ALU_SELECTION-1:0] RegGENERAL_Signal;

	initial RegGENERAL_Register=4'b0000;
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
	always@(*)
	if(Set_Conditions_C==1'b1)
		RegGENERAL_Signal = {CC_overflow,CC_carry,CC_negative,CC_zero};
   else
      RegGENERAL_Signal = RegGENERAL_Register;
		
	always @ ( posedge CC_PSR_CLOCK_50)
		RegGENERAL_Register <= RegGENERAL_Signal;
		
	always @ (*)
		CC_PSR_OUT = RegGENERAL_Register;
		
endmodule 
