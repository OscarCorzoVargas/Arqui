onerror {resume}
quietly WaveActivateNextPane {} 0
delete wave *
add wave -noupdate /TB_SYSTEM/eachvec

add wave  -divider uDATAPATH
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_CLOCK_50
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_RESET_InHigh
add wave  -radix Unsigned /TB_SYSTEM/TB_SYSTEM_data_OutBUS


add wave  -divider MAIN_MEMORY
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/MAIN_MEMORY_u0/MAIN_MEMORY_data_InBUS
#add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/MAIN_MEMORY_u0/MAIN_MEMORY_ADDRESS_data_InBUS
#add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/MAIN_MEMORY_u0/MAIN_MEMORY_RD_data_In
#add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/MAIN_MEMORY_u0/MAIN_MEMORY_WR_data_In
#add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/MAIN_MEMORY_u0/MAIN_MEMORY_CLOCK_50
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/MAIN_MEMORY_u0/MAIN_MEMORY_data_OutBUS
#add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/MAIN_MEMORY_u0/MAIN_MEMORY_ACK

add wave  -divider Mux64T032
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/CC_MUXX_BUS_64_TO_32_u0/CC_MUX_BUS_64_TO_32_InBUS_Main_Memory
#add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/CC_MUXX_BUS_64_TO_32_u0/CC_MUX_BUS_64_TO_32_ALU
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/CC_MUXX_BUS_64_TO_32_u0/CC_MUX_BUS_64_TO_32_RD
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/CC_MUXX_BUS_64_TO_32_u0/CC_MUX_data_OutBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/CC_MUXX_BUS_64_TO_32_u0/CC_MUX_BUS_64_TO_32_ALU

add wave  -divider uDATAPATH
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/uDATAPATH_BUS_C

add wave  -divider PC_COUNTER
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/SC_PC/SC_RegGENERAL_data_InBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/SC_PC/SC_RegGENERAL_data_OutBUS_A
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/SC_PC/SC_RegGENERAL_data_OutBUS_B

add wave  -divider r1_register
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/SC_R1/SC_RegGENERAL_data_InBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/SC_R1/SC_RegGENERAL_data_OutBUS_A
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/SC_R1/SC_RegGENERAL_data_OutBUS_B

add wave  -divider r2_register
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/SC_R2/SC_RegGENERAL_data_InBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/SC_R2/SC_RegGENERAL_data_OutBUS_A
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/SC_R2/SC_RegGENERAL_data_OutBUS_B

add wave  -divider r3_register
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/SC_R3/SC_RegGENERAL_data_InBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/SC_R3/SC_RegGENERAL_data_OutBUS_A
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/SC_R3/SC_RegGENERAL_data_OutBUS_B

add wave  -divider IR_REGISTER
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/SC_IR/SC_RegGENERAL_data_InBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/SC_IR/SC_RegGENERAL_data_OutBUS_A

add wave  -divider temp0_register
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/SC_Temp0/SC_RegGENERAL_data_InBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/SC_Temp0/SC_RegGENERAL_data_OutBUS_A
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/SC_Temp0/SC_RegGENERAL_data_OutBUS_B

add wave  -divider MUX_REG_BUSS_A
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/CC_MUXX_REG_A/CC_MUX_registro_InBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/CC_MUXX_REG_A/CC_MUX_selector_InBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/CC_MUXX_REG_A/CC_MUX_control_InBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/CC_MUXX_REG_A/CC_MUX_data_OutBUS

add wave  -divider MUX_REG_BUSS_C
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/CC_MUXX_REG_C/CC_MUX_registro_InBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/CC_MUXX_REG_C/CC_MUX_selector_InBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/CC_MUXX_REG_C/CC_MUX_control_InBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/CC_MUXX_REG_C/CC_MUX_data_OutBUS


add wave  -divider DECODER_C
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/CC_DECODER_C/CC_DECODER_selection_InBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/CC_DECODER_C/CC_DECODER_datadecoder_OutBUS

add wave  -divider REGISTER_SC_PC
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/SC_PC/SC_RegGENERAL_data_OutBUS_A

add wave  -divider BUS_MUX_A
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/CC_MUXX_BusA/CC_MUX_data6_InBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/CC_MUXX_BusA/CC_MUX_data_OutBUS

add wave  -divider ALU
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/CC_ALU_u0/CC_ALU_dataA_InBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/CC_ALU_u0/CC_ALU_dataB_InBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/CC_ALU_u0/CC_ALU_data_OutBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/uDATAPATH_u0/CC_ALU_u0/CC_ALU_selection_InBUS

add wave  -divider Centro_Control
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/Centro_Control_u0/Centro_Control_CS_ADDRESS_MUX/CS_CS_ADDRESS_MUX_data_Scratchpad
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/Centro_Control_u0/Centro_Control_CS_ADDRESS_MUX/CS_CS_ADDRESS_MUX_data_OutBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/Centro_Control_u0/Centro_Control_ROM/ROM_DataBUS_Out
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/Centro_Control_u0/Centro_Control_ROM/ROM_DataBUS_In

add wave  -divider MIR

add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/Centro_Control_u0/Centro_Control_CS_MIR/CS_MIR_A_data_OutBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/Centro_Control_u0/Centro_Control_CS_MIR/CS_MIR_AMUX_data_Out
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/Centro_Control_u0/Centro_Control_CS_MIR/CS_MIR_B_data_OutBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/Centro_Control_u0/Centro_Control_CS_MIR/CS_MIR_BMUX_data_Out
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/Centro_Control_u0/Centro_Control_CS_MIR/CS_MIR_C_data_OutBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/Centro_Control_u0/Centro_Control_CS_MIR/CS_MIR_CMUX_data_Out
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/Centro_Control_u0/Centro_Control_CS_MIR/CS_MIR_RD_data_Out
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/Centro_Control_u0/Centro_Control_CS_MIR/CS_MIR_WR_data_Out
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/Centro_Control_u0/Centro_Control_CS_MIR/CS_MIR_ALU_data_OutBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/Centro_Control_u0/Centro_Control_CS_MIR/CS_MIR_COND_data_OutBUS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/Centro_Control_u0/Centro_Control_CS_MIR/CS_MIR_ADDRESS_data_OutBUS

restart
run 1ms

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {319999492 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 445
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {59829352 ps} {60892417 ps}


