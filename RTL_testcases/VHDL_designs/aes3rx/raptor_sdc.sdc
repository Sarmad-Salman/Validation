create_clock -period 2 clk
set_input_delay 0.1 -clock clk [get_ports {*}]
set_output_delay 0.1 -clock clk [get_ports {*}]