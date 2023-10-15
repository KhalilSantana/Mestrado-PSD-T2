vcom *.vhd
vsim Circ5_tb
add wave *
add wave -position end  sim:/circ5_tb/u_Circ5/current_state
add wave -position end  sim:/circ5_tb/u_Circ5/next_state
run 20 ps