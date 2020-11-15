module hdmi_ctrl(
input	wire		sclk		,
input	wire		rst_n		,
output   wire        HDMI_OUT_EN1,

output	wire		r_ser_p		,
output	wire		r_ser_n		,
output	wire		g_ser_p		,
output	wire		g_ser_n		,
output	wire		b_ser_p		,
output	wire		b_ser_n		,
output	wire		clk_ser_p	,
output	wire		clk_ser_n	
//output	wire		hdmi_en
);

wire		clk_1x	;
wire		clk_5x	;
wire		h_sync		;	
wire		v_sync		;	                                       
wire		de		;			                                
wire[7:0]	r		;	
wire[7:0]	g		;	
wire[7:0]	b		;	
wire[9:0]	r_10bit		;	
wire[9:0]	g_10bit		;	
wire[9:0]	b_10bit		;	


wire locked;

  clk_wiz_0 clk0
   (
    // Clock out ports
    .clk_1x(clk_1x),     // output clk_1x
    .clk_5x(clk_5x),     // output clk_5x
    // Status and control signals
    .locked(locked),       // output locked
   // Clock in ports
    .sclk(sclk));      // input sclk

assign  HDMI_OUT_EN1 = 1'b1;

//vga实例化
vga	vga_inst(
.vga_clk	(clk_1x	),
.s_rst_n	(rst_n		),
.pi_rgb_data	(24'hffffff	),

.h_sync		(h_sync		),	
.v_sync		(v_sync		),

.de		(de		),//有效区域
.po_start_flag	(),//一场图像的开始时刻

.r		(r		),
.g		(g		),
.b		(b		)
);


//encode
encode	encode_r (
.clkin	(clk_1x	),// pixel clock input
.rstin	(~rst_n		),// async. reset input (active high)
.din	(r		),// data inputs: expect registered
.c0	(0		),// c0 input
.c1	(0		),// c1 input
.de	(de		),// de input
.dout	(r_10bit	)// data outputs
);
encode	encode_g (
.clkin	(clk_1x	),// pixel clock input
.rstin	(~rst_n		),// async. reset input (active high)
.din	(g		),// data inputs: expect registered
.c0	(0		),// c0 input
.c1	(0		),// c1 input
.de	(de		),// de input
.dout	(g_10bit	)// data outputs
);
encode	encode_b (
.clkin	(clk_1x	),// pixel clock input
.rstin	(~rst_n		),// async. reset input (active high)
.din	(b		),// data inputs: expect registered
.c0	(h_sync		),// c0 input
.c1	(v_sync		),// c1 input
.de	(de		),// de input
.dout	(b_10bit	)// data outputs
);

//par2ser
par2ser	par2ser_r(
.clk	(clk_1x	),
.clk_5x	(clk_5x	),
.rst_n	(rst_n		),
.i_dat_10bit(r_10bit	),

.ser_p	(r_ser_p	),	
.ser_n	(r_ser_n	)
);
par2ser	par2ser_g(
.clk	(clk_1x	),
.clk_5x	(clk_5x	),
.rst_n	(rst_n		),
.i_dat_10bit(g_10bit	),

.ser_p	(g_ser_p	),	
.ser_n	(g_ser_n	)
);
par2ser	par2ser_b(
.clk	(clk_1x	),
.clk_5x	(clk_5x	),
.rst_n	(rst_n		),
.i_dat_10bit(b_10bit	),

.ser_p	(b_ser_p	),	
.ser_n	(b_ser_n	)
);
par2ser	par2ser_clk(
.clk	(clk_1x	),
.clk_5x	(clk_5x	),
.rst_n	(rst_n		),
.i_dat_10bit(992		),

.ser_p	(clk_ser_p	),	
.ser_n	(clk_ser_n	)
);

//assign	hdmi_en	=	1;

endmodule


