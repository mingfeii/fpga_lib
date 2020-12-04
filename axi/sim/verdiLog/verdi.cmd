verdiWindowResize -win $_Verdi_1 "0" "25" "1918" "909"
debImport "-sv" "-f" "example.f"
debLoadSimResult /home/s/rtl_work/fpga_lib/axi/sim/example.fsdb
wvCreateWindow
verdiWindowBeWindow -win $_nWave2
wvResizeWindow -win $_nWave2 0 28 1918 215
wvResizeWindow -win $_nWave2 -1 25 1918 909
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "axi_awvalid" -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "axi_awready" -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
wvZoomAll -win $_nWave2
wvZoomAll -win $_nWave2
srcHBSelect "tb_AXI_full.u_axi_full_v1" -win $_nTrace1
srcSetScope -win $_nTrace1 "tb_AXI_full.u_axi_full_v1" -delim "."
srcHBSelect "tb_AXI_full.u_axi_full_v1" -win $_nTrace1
srcHBSelect "tb_AXI_full.u_axi_full_v1.axi_full_v1_M00_AXI_inst" -win $_nTrace1
srcSetScope -win $_nTrace1 "tb_AXI_full.u_axi_full_v1.axi_full_v1_M00_AXI_inst" \
           -delim "."
srcHBSelect "tb_AXI_full.u_axi_full_v1.axi_full_v1_M00_AXI_inst" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "M_AXI_AWPROT" -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "M_AXI_AWQOS" -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "M_AXI_AWVALID" -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "M_AXI_WLAST" -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "axi_awvalid" -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "init_txn_pulse" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "axi_wdata" -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
wvZoom -win $_nWave2 29767.805443 857312.796757
wvZoom -win $_nWave2 193168.408824 358964.915479
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "axi_araddr" -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
wvSetCursor -win $_nWave2 17860.683266 -snap {("G1" 9)}
wvZoomAll -win $_nWave2
wvZoom -win $_nWave2 309585.176607 1059733.873770
wvZoomAll -win $_nWave2
wvZoom -win $_nWave2 1488390.272148 3887675.390851
wvZoom -win $_nWave2 1749574.755249 2053826.892479
wvZoom -win $_nWave2 1790975.596158 1862325.981553
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "axi_araddr" -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "M_AXI_ARREADY" -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "axi_arvalid" -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "burst_size_bytes" -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G1" 13 )} 
wvSetRadix -win $_nWave2 -format UDec
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomAll -win $_nWave2
wvZoomAll -win $_nWave2
wvZoomAll -win $_nWave2
wvZoom -win $_nWave2 0.000000 2369517.313260
wvZoom -win $_nWave2 119367.693256 1173096.295795
wvZoom -win $_nWave2 459221.098939 844835.735189
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
