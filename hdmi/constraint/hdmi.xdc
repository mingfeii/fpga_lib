
set_property IOSTANDARD LVCMOS33 [get_ports sclk]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]
set_property PACKAGE_PIN G22 [get_ports sclk]
set_property PACKAGE_PIN D26 [get_ports rst_n]
set_property PACKAGE_PIN AE22 [get_ports HDMI_OUT_EN1]
set_property IOSTANDARD LVCMOS33 [get_ports HDMI_OUT_EN1]
set_property PACKAGE_PIN AB21 [get_ports clk_ser_p]
set_property PACKAGE_PIN AF24 [get_ports g_ser_p]
set_property PACKAGE_PIN AE23 [get_ports b_ser_p]
set_property PACKAGE_PIN AC23 [get_ports r_ser_p]

set_property SLEW FAST [get_ports HDMI_OUT_EN1]

set_property IOSTANDARD TMDS_33 [get_ports g_ser_p]
set_property IOSTANDARD TMDS_33 [get_ports b_ser_p]
set_property IOSTANDARD TMDS_33 [get_ports r_ser_p]
set_property IOSTANDARD TMDS_33 [get_ports clk_ser_p]
