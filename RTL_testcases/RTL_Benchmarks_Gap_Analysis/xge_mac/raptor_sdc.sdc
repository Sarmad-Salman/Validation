create_clock -period 4 clk_156m25
set_input_delay 0.1 -clock clk_156m25 [get_ports {*}]
set_output_delay 0.1 -clock clk_156m25 [get_ports {*}]
create_clock -period 2.5 clk_xgmii_rx
set_input_delay 0.1 -clock clk_xgmii_rx [get_ports {*}]
set_output_delay 0.1 -clock clk_xgmii_rx [get_ports {*}]
create_clock -period 2.5 clk_xgmii_tx
set_input_delay 0.1 -clock clk_xgmii_tx [get_ports {*}]
set_output_delay 0.1 -clock clk_xgmii_tx [get_ports {*}]
create_clock -period 2.5 wb_clk_i
set_input_delay 0.1 -clock wb_clk_i [get_ports {*}]
set_output_delay 0.1 -clock wb_clk_i [get_ports {*}]