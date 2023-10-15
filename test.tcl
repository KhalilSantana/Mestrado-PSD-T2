vcom *.vhd
vsim Wristwatch_tb
# add wave w_S

add wave -position 0  sim:/wristwatch_tb/u_Wristwatch/u_Controller/i_CLK
add wave -position 1  sim:/wristwatch_tb/w_RST
add wave -position end  sim:/wristwatch_tb/u_Wristwatch/u_Controller/current_state
add wave -position end  sim:/wristwatch_tb/u_Wristwatch/u_Controller/next_state
add wave -position end  sim:/wristwatch_tb/u_Wristwatch/w_S
add wave -radix ascii sim:/wristwatch_tb/u_Wristwatch/o_Display
add wave sim:/wristwatch_tb/u_Wristwatch/i_B_n

run 100 ps