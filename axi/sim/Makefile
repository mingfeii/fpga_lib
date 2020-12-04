
EXAMPLE := -full64 -debug_all -sverilog +libext+.v+.sv -l compile.log \
 +lint=TFIPC +lint=PCWM  -P $(FSDB_HOME)/novas.tab $(FSDB_HOME)/pli.a

example :
	@echo -------------------------------------------------
	vcs $(EXAMPLE) \
	-f example.f 



verdi_example :
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
