module s6_ddr3_ctrl_top(
    input wire sclk,
    input wire rst_n,
    input wire wr_data_en,
    input wire [31:0] wr_data,
    inout  [15:0]                                    mcb3_dram_dq,
    output wire [13:0]                                    mcb3_dram_a,
    output wire [2:0]                                     mcb3_dram_ba,
    output wire                                          mcb3_dram_ras_n,
    output wire                                          mcb3_dram_cas_n,
    output wire                                          mcb3_dram_we_n,
    output wire                                          mcb3_dram_odt,
    output wire                                          mcb3_dram_reset_n,
    output wire                                          mcb3_dram_cke,
    output wire                                          mcb3_dram_dm,
    inout                                            mcb3_dram_udqs,
    inout                                            mcb3_dram_udqs_n,
    inout                                            mcb3_rzq,
    inout                                            mcb3_zio,
    output  wire                                         mcb3_dram_udm,
    inout                                            mcb3_dram_dqs,
    inout                                            mcb3_dram_dqs_n,
    output wire                                          mcb3_dram_ck,
    output wire                                          mcb3_dram_ck_n
);

     wire   c3_p2_cmd_en    ;
     wire[2:0]    c3_p2_cmd_instr   ;
     wire[5:0]    c3_p2_cmd_bl    ;
     wire[29:0]   c3_p2_cmd_byte_addr ;
     wire   c3_p2_cmd_empty   ;
     wire   c3_p2_cmd_full    ;
     wire   c3_p2_wr_en   ;
     wire[3:0]    c3_p2_wr_mask   ;
     wire[31:0]   c3_p2_wr_data   ;
     wire   c3_p2_wr_full   ;
     wire   c3_p2_wr_empty    ;
     wire [6:0]   c3_p2_wr_count    ;
     wire   c3_p2_wr_underrun ;
     wire   c3_p2_wr_error    ;
                                           
     wire   c3_p3_cmd_en    ;
     wire[2:0]    c3_p3_cmd_instr   ;
     wire[5:0]    c3_p3_cmd_bl    ;
     wire[29:0]   c3_p3_cmd_byte_addr ;
     wire   c3_p3_cmd_empty   ;
     wire   c3_p3_cmd_full    ;
                                             
     wire   c3_p3_rd_en   ;
     wire [31:0]  c3_p3_rd_data   ;
     wire   c3_p3_rd_full   ;
     wire   c3_p3_rd_empty    ;
     wire [6:0]   c3_p3_rd_count    ;
     wire   c3_p3_rd_overflow ;
     wire   c3_p3_rd_error    ;
     
     wire   user_wr_end   ;
     wire   c3_calib_done   ;
wire  clk_100MHz;
wire  clk_333MHz;











user_wr_ctrl 
#(
    .INIT_WR_BYTE_ADDR(0),
    .MAX_INIT_WR_BYTE_ADDR(1024)
  )
user_wr_ctrl_inst  (
    .clk(clk_100MHz), 
    .rst_n(c3_calib_done), 
    .wr_data_en(wr_data_en), 
    .p2_wr_empty(c3_p2_wr_empty), 
    .p2_wr_en(c3_p2_wr_en), 
    .p2_wr_data(c3_p2_wr_data), 
    .wr_data(wr_data),
    .p2_wr_mask(c3_p2_wr_mask), 
    .p2_cmd_en(c3_p2_cmd_en), 
    .p2_cmd_bl(c3_p2_cmd_bl), 
    .p2_cmd_byte_addr(c3_p2_cmd_byte_addr), 
    .user_wr_end(user_wr_end)
    );

user_rd_ctrl 
# ( .INIT_RD_BYTE_ADDR(0),
    .MAX_INIT_RD_BYTE_ADDR(1024)
  )
user_rd_ctrl_inst
(
    .rd_clk(clk_100MHz), 
    .rst_n(c3_calib_done), 
    .rd_cmd_en(user_wr_end), 
    .cmd_bl(63), 
    .p3_rd_count(c3_p3_rd_count), 
    .p3_rd_en(c3_p3_rd_en), 
    .p3_cmd_en(c3_p3_cmd_en), 
    .p3_cmd_bl(c3_p3_cmd_bl), 
    .p3_cmd_byte_addr(c3_p3_cmd_byte_addr), 
    .user_rd_end(user_rd_end)
    );


//pll
clk_wiz_v3_6  clk_wiz_v3_6_inst
(// Clock in ports
.CLK_IN1(sclk),      // IN
// Clock out ports
.CLK_OUT1(clk_100MHz),     // OUT
.CLK_OUT2(clk_333MHz));    // OUT


//#更改参数
mig_39_2 # (
    .C3_P0_MASK_SIZE(4),
    .C3_P0_DATA_PORT_SIZE(32),
    .C3_P1_MASK_SIZE(4),
    .C3_P1_DATA_PORT_SIZE(32),
    .DEBUG_EN(0),
    .C3_MEMCLK_PERIOD(3000),
    .C3_CALIB_SOFT_IP("TRUE"),
    .C3_SIMULATION("FALSE"),
    .C3_RST_ACT_LOW(1),
    .C3_INPUT_CLK_TYPE("SINGLE_ENDED"),
    .C3_MEM_ADDR_ORDER("ROW_BANK_COLUMN"),
    .C3_NUM_DQ_PINS(16),
    .C3_MEM_ADDR_WIDTH(14),
    .C3_MEM_BANKADDR_WIDTH(3)
)
u_mig_39_2 (

    .c3_sys_clk           (clk_333MHz),
  .c3_sys_rst_i           (rst_n),

  .mcb3_dram_dq           (mcb3_dram_dq),
  .mcb3_dram_a            (mcb3_dram_a),
  .mcb3_dram_ba           (mcb3_dram_ba),
  .mcb3_dram_ras_n        (mcb3_dram_ras_n),
  .mcb3_dram_cas_n        (mcb3_dram_cas_n),
  .mcb3_dram_we_n         (mcb3_dram_we_n),
  .mcb3_dram_odt          (mcb3_dram_odt),
  .mcb3_dram_cke          (mcb3_dram_cke),
  .mcb3_dram_ck           (mcb3_dram_ck),
  .mcb3_dram_ck_n         (mcb3_dram_ck_n),
  .mcb3_dram_dqs          (mcb3_dram_dqs),
  .mcb3_dram_dqs_n        (mcb3_dram_dqs_n),
  .mcb3_dram_udqs         (mcb3_dram_udqs),    // for X16 parts
  .mcb3_dram_udqs_n       (mcb3_dram_udqs_n),  // for X16 parts
  .mcb3_dram_udm          (mcb3_dram_udm),     // for X16 parts
  .mcb3_dram_dm           (mcb3_dram_dm),
  .mcb3_dram_reset_n      (mcb3_dram_reset_n),
  .c3_clk0		        (c3_clk0),
  .c3_rst0		        (c3_rst0),



  .c3_calib_done    (c3_calib_done),
     .mcb3_rzq               (mcb3_rzq),

     .mcb3_zio               (mcb3_zio),

     .c3_p2_cmd_clk                          (c3_p2_cmd_clk),
   .c3_p2_cmd_en                           (c3_p2_cmd_en),
   .c3_p2_cmd_instr                        (3'b000),
   .c3_p2_cmd_bl                           (c3_p2_cmd_bl),
   .c3_p2_cmd_byte_addr                    (c3_p2_cmd_byte_addr),
   .c3_p2_cmd_empty                        (c3_p2_cmd_empty),
   .c3_p2_cmd_full                         (c3_p2_cmd_full),
   .c3_p2_wr_clk                           (clk_100MHz), //1
   .c3_p2_wr_en                            (c3_p2_wr_en), //2
   .c3_p2_wr_mask                          (c3_p2_wr_mask),
   .c3_p2_wr_data                          (c3_p2_wr_data),
   .c3_p2_wr_full                          (c3_p2_wr_full),
   .c3_p2_wr_empty                         (c3_p2_wr_empty),
   .c3_p2_wr_count                         (c3_p2_wr_count),
   .c3_p2_wr_underrun                      (c3_p2_wr_underrun),
   .c3_p2_wr_error                         (c3_p2_wr_error),
   .c3_p3_cmd_clk                          (clk_100MHz),
   .c3_p3_cmd_en                           (c3_p3_cmd_en),
   .c3_p3_cmd_instr                        (1),
   .c3_p3_cmd_bl                           (c3_p3_cmd_bl),
   .c3_p3_cmd_byte_addr                    (c3_p3_cmd_byte_addr),
   .c3_p3_cmd_empty                        (c3_p3_cmd_empty),
   .c3_p3_cmd_full                         (c3_p3_cmd_full),
   .c3_p3_rd_clk                           (clk_100MHz),
   .c3_p3_rd_en                            (c3_p3_rd_en),
   .c3_p3_rd_data                          (c3_p3_rd_data),
   .c3_p3_rd_full                          (c3_p3_rd_full),
   .c3_p3_rd_empty                         (c3_p3_rd_empty),
   .c3_p3_rd_count                         (c3_p3_rd_count),
   .c3_p3_rd_overflow                      (c3_p3_rd_overflow),
   .c3_p3_rd_error                         (c3_p3_rd_error)
);
endmodule
