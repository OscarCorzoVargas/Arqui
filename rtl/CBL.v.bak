module CBL (
	//////////// OUTPUTS //////////
	CBL_OUT,
	//////////// INPUTS //////////
   bit13,
   ALU_COND,
	PSR_OUT
);
//=======================================================
//  PARAMETER declarations
//=======================================================
parameter DATAWIDTH_ALU_SELECT = 4;
parameter DATAWIDTH_ALU_SELECTION = 2;
parameter DATAWIDTH_ALU_SELECTIONS = 3;
//=======================================================
//  PORT declarations
//=======================================================
	output reg		[DATAWIDTH_ALU_SELECTION-1:0]	CBL_OUT;
	input          bit13;
	input          [DATAWIDTH_ALU_SELECTIONS-1:0] ALU_COND;
	input          [DATAWIDTH_ALU_SELECT-1:0] PSR_OUT;
always @(*)
begin
	case(ALU_COND)
	3'b000:CBL_OUT = 2'b00;
	3'b001:begin
	if(PSR_OUT[0]==1'b1)
	CBL_OUT = 2'b01;
	else 
	CBL_OUT = 2'b00;
	end
	3'b010:begin
	if(PSR_OUT[1]==1'b1)
	CBL_OUT = 2'b01;
	else 
	CBL_OUT = 2'b00;
	end
	3'b011:begin
	if(PSR_OUT[2]==1'b1)
	CBL_OUT = 2'b01;
	else 
	CBL_OUT = 2'b00;
	end
	3'b100:begin
	if(PSR_OUT[3]==1'b1)
	CBL_OUT = 2'b01;
	else 
	CBL_OUT = 2'b00;
	end
	3'b101:begin
	if(bit13==1'b1)
	CBL_OUT = 2'b01;
	else 
	CBL_OUT = 2'b00;
	end
	3'b110:CBL_OUT = 2'b01;
	3'b111:CBL_OUT = 2'b10;
	default:CBL_OUT = 2'b00;
	endcase
end
endmodule 
