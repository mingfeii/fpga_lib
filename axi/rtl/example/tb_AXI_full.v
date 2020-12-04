`timescale 1ns / 1ps

module tb_AXI_full();
    //system simulation clk
    reg sys_clk_i;
   //system simulation reset
    reg sys_rst_n;

    reg m00_axi_init_axi_txn;
    wire m00_axi_txn_done,m00_axi_error;

parameter  C_AXI_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
  C_AXI_BURST_LEN  = 16,
  C_AXI_ID_WIDTH   = 1,
  C_AXI_ADDR_WIDTH = 32,
  C_AXI_DATA_WIDTH = 32,
  C_AXI_USER_WIDTH = 0;

    //axi write  signal 
    
    
    
    wire axi_awvalid;
    wire axi_awready;
    wire axi_awlock;
    wire [7 : 0] axi_awlen;//len
    wire [2 : 0] axi_awsize;//width
    wire [1 : 0] axi_awburst;
    wire [3 : 0] axi_awcache;
    wire [2 : 0] axi_awprot;
    wire [3 : 0] axi_awqos;
    wire [C_AXI_ID_WIDTH - 1 : 0] axi_awid;
    wire [C_AXI_ADDR_WIDTH-1 : 0] axi_awaddr;//addr
    wire [C_AXI_USER_WIDTH-1 : 0] axi_awuser;

    //axi write data 
    wire axi_wvalid;
    wire axi_wready;
    wire axi_wlast;
    wire [C_AXI_DATA_WIDTH-1  : 0] axi_wdata;
    wire [C_AXI_DATA_WIDTH/8-1: 0] axi_wstrb;
    wire [C_AXI_USER_WIDTH -1 : 0] axi_wuser;

    //ack signal
    wire axi_bvalid;
    wire axi_bready;
    wire [1 : 0] axi_bresp;
    wire [C_AXI_ID_WIDTH - 1: 0] axi_bid;
    wire [C_AXI_USER_WIDTH-1: 0] axi_buser;


    //axi read 
    
    
    wire axi_arvalid;
    wire axi_arready;
    wire axi_arlock;
    wire [7 : 0] axi_arlen;
    wire [2 : 0] axi_arsize;
    wire [1 : 0] axi_arburst;
    wire [3 : 0] axi_arcache;
    wire [2 : 0] axi_arprot;
    wire [3 : 0] axi_arqos;
    wire [C_AXI_ID_WIDTH - 1 : 0] axi_arid;
    wire [C_AXI_ADDR_WIDTH-1 : 0] axi_araddr;
    wire [C_AXI_USER_WIDTH-1 : 0] axi_aruser;

    //read 
    wire axi_rvalid;
    wire axi_rready;
    wire axi_rlast;
    wire [1 : 0] axi_rresp;
    wire [C_AXI_ID_WIDTH - 1 : 0] axi_rid;
    wire [C_AXI_DATA_WIDTH-1 : 0] axi_rdata;
    wire [C_AXI_USER_WIDTH-1 : 0] axi_ruser;

    initial begin
        sys_clk_i = 0;
        sys_rst_n = 0;
        m00_axi_init_axi_txn = 0;
        # 100 sys_rst_n = 1;
        #40 m00_axi_init_axi_txn = 1;
        #40 m00_axi_init_axi_txn = 0;
        #10000 $finish;
    end


initial begin
    $display("############ SIMULATION STARTS ################");
    $timeformat(-9, 0, " ns", 12);
    $display(" === FSDB ON ====");
    $fsdbDumpfile("example.fsdb");
    $fsdbDumpvars();
    $fsdbDumpMDA();
end



    always #10 sys_clk_i = ~sys_clk_i;
    
    axi_full_v1 u_axi_full_v1(
		.m00_axi_init_axi_txn(m00_axi_init_axi_txn),
		.m00_axi_txn_done(m00_axi_txn_done),
		.m00_axi_error(m00_axi_error),
		.m00_axi_aclk(sys_clk_i),
		.m00_axi_aresetn(sys_rst_n),
        .m00_axi_awid(axi_awid),
        .m00_axi_awaddr(axi_awaddr),
        .m00_axi_awlen(axi_awlen),
        .m00_axi_awsize(axi_awsize),
        .m00_axi_awburst(axi_awburst),
        .m00_axi_awlock(axi_awlock),
        .m00_axi_awcache(axi_awcache),
        .m00_axi_awprot(axi_awprot),
        .m00_axi_awqos(axi_awqos),
        .m00_axi_awuser(axi_awuser),
        .m00_axi_awvalid(axi_awvalid),
        .m00_axi_awready(axi_awready),

        .m00_axi_wdata(axi_wdata),
        .m00_axi_wstrb(axi_wstrb),
        .m00_axi_wlast(axi_wlast),
        .m00_axi_wuser(axi_wuser),
        .m00_axi_wvalid(axi_wvalid),
        .m00_axi_wready(axi_wready),

        .m00_axi_bid(axi_bid),
        .m00_axi_bresp(axi_bresp),
        .m00_axi_buser(axi_buser),
        .m00_axi_bvalid(axi_bvalid),
        .m00_axi_bready(axi_bready),

        .m00_axi_arid(axi_arid),
        .m00_axi_araddr(axi_araddr),
        .m00_axi_arlen(axi_arlen),
        .m00_axi_arsize(axi_arsize),
        .m00_axi_arburst(axi_arburst),
        .m00_axi_arlock(axi_arlock),
        .m00_axi_arcache(axi_arcache),
        .m00_axi_arprot(axi_arprot),
        .m00_axi_arqos(axi_arqos),
        .m00_axi_aruser(axi_aruser),
        .m00_axi_arvalid(axi_arvalid),
        .m00_axi_arready(axi_arready),

        .m00_axi_rid(axi_rid),
        .m00_axi_rdata(axi_rdata),
        .m00_axi_rresp(axi_rresp),
        .m00_axi_rlast(axi_rlast),
        .m00_axi_ruser(axi_ruser),
        .m00_axi_rvalid(axi_rvalid),
        .m00_axi_rready(axi_rready),


        .s00_axi_aclk(sys_clk_i),
        .s00_axi_aresetn(sys_rst_n),

        .s00_axi_awid(axi_awid),
        .s00_axi_awaddr(axi_awaddr),
        .s00_axi_awlen(axi_awlen),
        .s00_axi_awsize(axi_awsize),
        .s00_axi_awburst(axi_awburst),
        .s00_axi_awlock(axi_awlock),
        .s00_axi_awcache(axi_awcache),
        .s00_axi_awprot(axi_awprot),
        .s00_axi_awqos(axi_awqos),
        .s00_axi_awuser(axi_awuser),
        .s00_axi_awvalid(axi_awvalid),
        .s00_axi_awready(axi_awready),

        .s00_axi_wdata(axi_wdata),
        .s00_axi_wstrb(axi_wstrb),
        .s00_axi_wlast(axi_wlast),
        .s00_axi_wuser(axi_wuser),
        .s00_axi_wvalid(axi_wvalid),
        .s00_axi_wready(axi_wready),

        .s00_axi_bid(axi_bid),
        .s00_axi_bresp(axi_bresp),
        .s00_axi_buser(axi_buser),
        .s00_axi_bvalid(axi_bvalid),
        .s00_axi_bready(axi_bready),

        .s00_axi_arid(axi_arid),
        .s00_axi_araddr(axi_araddr),
        .s00_axi_arlen(axi_arlen),
        .s00_axi_arsize(axi_arsize),
        .s00_axi_arburst(axi_arburst),
        .s00_axi_arlock(axi_arlock),
        .s00_axi_arcache(axi_arcache),
        .s00_axi_arprot(axi_arprot),
        .s00_axi_arqos(axi_arqos),
        .s00_axi_aruser(axi_aruser),
        .s00_axi_arvalid(axi_arvalid),
        .s00_axi_arready(axi_arready),

        .s00_axi_rid(axi_rid),
        .s00_axi_rdata(axi_rdata),
        .s00_axi_rresp(axi_rresp),
        .s00_axi_rlast(axi_rlast),
        .s00_axi_ruser(axi_ruser),
        .s00_axi_rvalid(axi_rvalid),
        .s00_axi_rready(axi_rready)
    );

endmodule
