
EXAMPLE := -full64 -debug_all -sverilog +libext+.v+.sv -l compile.log \
 +lint=TFIPC +lint=PCWM  -P $(FSDB_HOME)/novas.tab $(FSDB_HOME)/pli.a

example :
	@echo -------------------------------------------------
	vcs $(EXAMPLE) \
	-f example.f 

verdi_example :
	@echo --------------------------------------------------
	verdi -sv \
	-f example.f \
	-ssf example.fsdb &

sim	:
	./simv -l simv.log
clean:
	rm -rf csrc simv* *.fsdb ucli.key  *.log  *.dump
