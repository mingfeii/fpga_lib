//this module is compatible with spartan-6 mig none axi mode 
module user_wr_ctrl
#(
    parameter INIT_ADDR = 0,
              MAX_ADDR = 2048,
              AW = 30,
              DW = 32
)
    input                        sclk,
    input                        rst_n,
    input                        wr_data_en,
    input      [DW-1:0]          wr_data,
    input                        c3_p2_wr_empty,
    //spartan-6的mig端口 p2是写端口
    output logic                 c3_p2_wr_en,
    output logic [DW-1:0]        c3_p2_wr_data,
    output logic [3:0]           c3_p2_wr_mask,
    output logic                 c3_p2_cmd_en,
    output logic [5:0]           c3_p2_cmd_bl,
    output logic [AW-1:0]        c3_p2_cmd_byte_addr,

    output logic                 user_wr_end //写结束
);

logic [6:0] data_cnt;
logic c3_p2_wr_enpty_reg;
//data_en
always_ff@(posedge sclk)
    if (~rst_n)
        data_cnt <= 0;
    else if (wr_data_en==1)
        data_cnt <= data_cnt + 'd1;
    else data_cnt <= 'd0;

always_ff@(posedge sclk)
    if (~rst_n)
        c3_p2_wr_en <= 'd0;
    else
     c3_p2_wr_en <= wr_data_en;

always_ff@(posedge sclk)
    if (~rst_n)
        c3_p2_wr_data <= 0;
    else 
        c3_p2_wr_data <= wr_data;

//no mask now 
assign c3_p2_wr_mask = 0;

//c3_p2_cmd_en
always_ff@(posedge sclk)
    if (~rst_n)
        c3_p2_cmd_en <= 'b0;
    else if (wr_data_en==0 && c3_p2_wr_en==1)
        c3_p2_cmd_en <= 'b1;
    else 
        c3_p2_cmd_en <= 'b0;
 
//c3_p2_cmd_bl
 always_ff@(posedge sclk)
    if (~rst_n)
        c3_p2_cmd_bl <= 'd0;
    else if (wr_data_en==0 && c3_p2_wr_en==1)
        c3_p2_cmd_bl <= data_cnt - 'd1;
    else 
        c3_p2_cmd_bl <= 'd0;

//c3_p2_cmd_byte_addr
always_ff@(posedge sclk)
    if (~rst_n)
        c3_p2_cmd_byte_addr <= INIT_ADDR;
    else if (c3_p2_cmd_byte_addr == MAX_ADDR)
        c3_p2_cmd_byte_addr <= INIT_ADDR;
    else if (c3_p2_cmd_en==1)
        c3_p2_cmd_byte_addr <= c3_p2_cmd_byte_addr + (c3_p2_cmd_bl+1) << 2;
    else 
        c3_p2_cmd_byte_addr <= 'd0;

//c3_p2_wr_enpty_reg
always_ff@(posedge sclk)
    if (~rst_n)
        c3_p2_wr_enpty_reg <= 'b1;
    else 
        c3_p2_wr_enpty_reg <= c3_p2_wr_enpty;

//user_wr_end
always_ff@(posedge sclk)
    if (~rst_n)
        user_wr_end <= 'b0;
    else if (c3_p2_wr_enpty_reg==0 && c3_p2_wr_enpty==1)
        user_wr_end <= 'b1;
    else 
        user_wr_end <= 'b0;



endmodule