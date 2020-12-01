ROOT_PATH ?= /home/s/sim_cam_lvds
STEREO_LIB_1 ?= $(ROOT_PATH)/xsis/StereoBM/common/rtl 
STEREO_LIB_2 ?= $(ROOT_PATH)/xsis/StereoBM/stereo/rtl 
STEREO_LIB_3 ?= $(ROOT_PATH)/xsis/StereoBM/mem/rtl 
STEREO_LIB_4 ?= $(ROOT_PATH)/xsis/StereoBM/rvh/rtl 
STEREO_LIB_5 ?= $(ROOT_PATH)/xsis/StereoBM/alu/rtl 

DVP_OPT := -full64 -debug_all -sverilog +libext+.v+.sv \
			+define+FSDB -P $(FSDB_HOME)/novas.tab $(FSDB_HOME)/pli.a +vcs+finish+300ms

COMP_OPT := -full64 -debug_all -sverilog +libext+.v+.sv -l compile.log \
	+incdir+$(STEREO_LIB_1) \
	+incdir+$(STEREO_LIB_2) \
	+incdir+$(STEREO_LIB_3) \
	+incdir+$(STEREO_LIB_4) \
	+incdir+$(STEREO_LIB_5) \
	+define+FSDB +lint=TFIPC +lint=PCWM  -P $(FSDB_HOME)/novas.tab $(FSDB_HOME)/pli.a
cam :
	@echo -------------------------------------------------
	vcs $(COMP_OPT) \
	tb_lvds_cam_rx2camif.sv \
	-f rtl.f 

lvds :
	vcs $(COMP_OPT) \
	tb_lvds_cam_rx2camif.sv \
	-f rtl.f 


dvp :
	@echo -------------------------------------------------
	vcs $(DVP_OPT) \
	   tb_dvp.sv \
	   test_pattern.sv

verdi_lvds :
	@echo --------------------------------------------------
	verdi -sv \
	tb_lvds_cam_rx2camif.sv \
	-f rtl.f \
	-v altera_mf.v \
	-ssf lvds.fsdb &

verdi_cam :
	@echo -------------------------------------------------
	verdi -sv \
	tb.sv \
	test_pattern.sv \
	-f rtl.f \
	-v altera_mf.v \
	-ssf camif.fsdb &

verdi_dvp :
	@echo -------------------------------------------------
	verdi -sv \
	tb_dvp.sv \
	test_pattern.sv \
	-ssf dvp.fsdb &

sim	:
	./simv -l simv.log
clean:
	rm -rf csrc simv* *.fsdb ucli.key  *.log  *.dump
