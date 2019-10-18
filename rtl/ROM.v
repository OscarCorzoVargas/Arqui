module ROM #(parameter ROM_BUS_In=11, parameter ROM_BUS_Out=41)(
	//////////// OUTPUTS //////////
	ROM_DataBUS_Out,
	//////////// INPUTS //////////
	ROM_DataBUS_In
	
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
	output reg	[ROM_BUS_Out-1:0] ROM_DataBUS_Out;
	input			[ROM_BUS_In-1:0] ROM_DataBUS_In;

//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
	always@(*)
	begin
	case (ROM_DataBUS_In)	
	// Example to more outputs: WaitStart: begin sResetCounter = 0; sCuenteUP = 0; end
		11'b00000000000: ROM_DataBUS_Out = 41'b000110 0 000110 0 000111 010 0101 000 00000000000;
		11'b00000000001: ROM_DataBUS_Out = 41'b000000 0 000000 0 000000 000 0101 111 00000000000;
		
		
		//Storage instructions
		11'b11100010000: ROM_DataBUS_Out = 41'b000000 1 000000 1 001000 000 1000 101 11100000001;
		11'b11100010001: ROM_DataBUS_Out = 41'b000111 0 000000 0 000111 000 1111 110 00000101000;
		11'b00000101000: ROM_DataBUS_Out = 41'b000111 0	000000 0	000111 000 1111 000 00000000000;
		11'b00000101001: ROM_DataBUS_Out = 41'b000111 0	000000 0	000111 000 1111 000 00000000000;
		11'b00000101010: ROM_DataBUS_Out = 41'b000111 0	000000 0	100101 000 1111 000 00000000000;
		11'b00000101011: ROM_DataBUS_Out = 41'b100101 0	000000 0	100101 000 1111 000 00000000000;
		11'b00000101100: ROM_DataBUS_Out = 41'b100001 0 000000 1	000000 001 0101 110 11111111111;
		11'b11100010010: ROM_DataBUS_Out = 41'b100101 0 000000 0	100001 000 1100 000 00000000000;
		11'b11100010011: ROM_DataBUS_Out = 41'b000000 1	100001 0	100001 000 1000 110 11100010001;
		
		//ADDCC instructions
		11'b11001000000: ROM_DataBUS_Out = 41'b000000 0 000000 0 000000 000 0101 101 11001000010;
		11'b11001000001: ROM_DataBUS_Out = 41'b000000 1 000000 1	000000 100 0011 110 11111111111;
		11'b11001000010: ROM_DataBUS_Out = 41'b100101 0 000000 0	100001 000 1100 000 00000000000;
		11'b11001000011: ROM_DataBUS_Out = 41'b000000 1 100001 0	000000 100 0011 110 11111111111;
		
		//Branch instructions
		11'b10001000000: ‬ROM_DataBUS_Out = 41'b000000 0 000000 0 000000 000 0101 110 00000000010;
		11'b00000000010: ‬ROM_DataBUS_Out = 41'b000111 0 000000 0 001000 000 1010 000 00000000000;
		11'b00000000011: ‬ROM_DataBUS_Out = 41'b001000 0 000000 0 001000 000 1111 000 00000000000; 
		11'b00000000100: ‬ROM_DataBUS_Out = 41'b001000 0 000000 0 001000 000 1111 000 00000000000; 
		11'b00000000101: ‬ROM_DataBUS_Out = 41'b000111 0 000000 0 000111 000 1111 000 00000000000; 
		11'b00000000110: ‬ROM_DataBUS_Out = 41'b000111 0 000000 0 000111 000 1111 000 00000000000; 
		11'b00000000111: ‬ROM_DataBUS_Out = 41'b000111 0 000000 0 000111 000 1111 000 00000000000; 
		11'b00000001000: ‬ROM_DataBUS_Out = 41'b000111 0 100101 0 000111 000 1000 101 00000001100;// preguntar 
		11'b00000001001: ‬ROM_DataBUS_Out = 41'b000111 0 100101 0 000111 000 1000 101 00000001101;// preguntar
		11'b00000001010: ‬ROM_DataBUS_Out = 41'b000111 0 100101 0 000111 000 1000 010 00000001100;// preguntar
		11'b00000001011: ‬ROM_DataBUS_Out = 41'b000000 0 000000 0 000000 000 0101 110 11111111111; 
		11'b00000001100: ‬ROM_DataBUS_Out = 41'b000110 0 001000 0 000110 000 1000 110 00000000000; 
		11'b00000001101: ‬ROM_DataBUS_Out = 41'b000111 0 000111 0 000111 000 1000 101 00000010000; 
		11'b00000001110: ‬ROM_DataBUS_Out = 41'b000000 0 000000 0 000000 000 0101 100 00000001100; 
		11'b00000001111: ‬ROM_DataBUS_Out = 41'b000000 0 000000 0 000000 000 0101 110 11111111111; 
		11'b00000010000: ‬ROM_DataBUS_Out = 41'b000000 0 000000 0 000000 000 0101 101 00000010011; 
		11'b00000010001: ‬ROM_DataBUS_Out = 41'b000000 0 000000 0 000000 000 0101 001 00000001100; 
		11'b00000010010: ‬ROM_DataBUS_Out = 41'b000000 0 000000 0 000000 000 0101 110 11111111111; 
		11'b00000010011: ‬ROM_DataBUS_Out = 41'b000000 0 000000 0 000000 000 0101 011 00000001100; 
		11'b00000010100: ‬ROM_DataBUS_Out = 41'b000000 0 000000 0 000000 000 0101 110 11111111111; 
		11'b11111111111: ROM_DataBUS_Out = 41'b000110 0 000000 0 000110 000 1110 110 00000000000;

		
		//


		default :   ROM_DataBUS_Out = 41'b10000101000010000000110010111011111111111; // channel 0 is selected 
		endcase
	end
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL

endmodule
