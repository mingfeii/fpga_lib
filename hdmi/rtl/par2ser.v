//使用oserdese2 原语实现10bit转成1bit
module par2ser(
input	wire		clk		,//慢时钟
input	wire		clk_5x		,//快时钟
input	wire		rst_n		,//复位，低有效
input	wire[9:0]	i_dat_10bit	,//输入10bit数据


output	wire		ser_p		,//输出1bit差分数据		
output	wire		ser_n	
);


wire		ser_dat		;//转换后串行数据
wire[1:0]	shift_dat	;

reg		SERDESE_rst	;

always@(posedge	clk	or	negedge	rst_n)
if(rst_n==1'b0)
	SERDESE_rst	<=	1'b1;
else
	SERDESE_rst	<=	1'b0;	

//OSERDESE2  master
OSERDESE2 #(
.DATA_RATE_OQ("DDR"),   // DDR, SDR
.DATA_RATE_TQ("DDR"),   // DDR, BUF, SDR
.DATA_WIDTH(10),         // Parallel data width (2-8,10,14)
.INIT_OQ(1'b0),         // Initial value of OQ output (1'b0,1'b1)
.INIT_TQ(1'b0),         // Initial value of TQ output (1'b0,1'b1)
.SERDES_MODE("MASTER"), // MASTER, SLAVE
.SRVAL_OQ(1'b0),        // OQ output value when SR is used (1'b0,1'b1)
.SRVAL_TQ(1'b0),        // TQ output value when SR is used (1'b0,1'b1)
.TBYTE_CTL("FALSE"),    // Enable tristate byte operation (FALSE, TRUE)
.TBYTE_SRC("FALSE"),    // Tristate byte source (FALSE, TRUE)
.TRISTATE_WIDTH(1)      // 3-state converter width (1,4)
)
OSERDESE2_MASTER_inst (
.OFB(),             // 1-bit output: Feedback path for data
.OQ(ser_dat),               // 1-bit output: Data path output
// SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
.SHIFTOUT1(),
.SHIFTOUT2(),
.TBYTEOUT(),   // 1-bit output: Byte group tristate
.TFB(),             // 1-bit output: 3-state control
.TQ(),               // 1-bit output: 3-state control
.CLK(clk_5x),             // 1-bit input: High speed clock
.CLKDIV(clk),       // 1-bit input: Divided clock
// D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
.D1(i_dat_10bit[0]),
.D2(i_dat_10bit[1]),
.D3(i_dat_10bit[2]),
.D4(i_dat_10bit[3]),
.D5(i_dat_10bit[4]),
.D6(i_dat_10bit[5]),
.D7(i_dat_10bit[6]),
.D8(i_dat_10bit[7]),
.OCE(1'b1),             // 1-bit input: Output data clock enable
.RST(SERDESE_rst),             // 1-bit input: Reset
// SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
.SHIFTIN1(shift_dat[0]),
.SHIFTIN2(shift_dat[1]),
// T1 - T4: 1-bit (each) input: Parallel 3-state inputs
.T1(1'b0),
.T2(1'b0),
.T3(1'b0),
.T4(1'b0),
.TBYTEIN(1'b0),     // 1-bit input: Byte group tristate
.TCE(1'b0)              // 1-bit input: 3-state clock enable
);

//OSERDESE2  slave
OSERDESE2 #(
.DATA_RATE_OQ("DDR"),   // DDR, SDR
.DATA_RATE_TQ("DDR"),   // DDR, BUF, SDR
.DATA_WIDTH(10),         // Parallel data width (2-8,10,14)
.INIT_OQ(1'b0),         // Initial value of OQ output (1'b0,1'b1)
.INIT_TQ(1'b0),         // Initial value of TQ output (1'b0,1'b1)
.SERDES_MODE("SLAVE"), // MASTER, SLAVE
.SRVAL_OQ(1'b0),        // OQ output value when SR is used (1'b0,1'b1)
.SRVAL_TQ(1'b0),        // TQ output value when SR is used (1'b0,1'b1)
.TBYTE_CTL("FALSE"),    // Enable tristate byte operation (FALSE, TRUE)
.TBYTE_SRC("FALSE"),    // Tristate byte source (FALSE, TRUE)
.TRISTATE_WIDTH(1)      // 3-state converter width (1,4)
)
OSERDESE2_SLAVE_inst (
.OFB(),             // 1-bit output: Feedback path for data
.OQ(),               // 1-bit output: Data path output
// SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
.SHIFTOUT1(shift_dat[0]),
.SHIFTOUT2(shift_dat[1]),
.TBYTEOUT(),   // 1-bit output: Byte group tristate
.TFB(),             // 1-bit output: 3-state control
.TQ(),               // 1-bit output: 3-state control
.CLK(clk_5x),             // 1-bit input: High speed clock
.CLKDIV(clk),       // 1-bit input: Divided clock
// D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
.D1(1'b0),
.D2(1'b0),
.D3(i_dat_10bit[8]),
.D4(i_dat_10bit[9]),
.D5(1'b0),
.D6(1'b0),
.D7(1'b0),
.D8(1'b0),
.OCE(1'b1),             // 1-bit input: Output data clock enable
.RST(SERDESE_rst),             // 1-bit input: Reset
// SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
.SHIFTIN1(1'b0),
.SHIFTIN2(1'b0),
// T1 - T4: 1-bit (each) input: Parallel 3-state inputs
.T1(1'b0),
.T2(1'b0),
.T3(1'b0),
.T4(1'b0),
.TBYTEIN(1'b0),     // 1-bit input: Byte group tristate
.TCE(1'b0)              // 1-bit input: 3-state clock enable
);

//OBUFDS
OBUFDS #(
.IOSTANDARD("DEFAULT"), // Specify the output I/O standard
.SLEW("SLOW")           // Specify the output slew rate
) OBUFDS_inst (
.O(ser_p),     // Diff_p output (connect directly to top-level port)
.OB(ser_n),   // Diff_n output (connect directly to top-level port)
.I(ser_dat)      // Buffer input 
);

endmodule