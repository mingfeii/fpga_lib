//this module is compatible with spartan-6 mig none axi mode 
module user_rd_ctrl
#(
    parameter INIT_ADDR = 0,
              MAX_ADDR = 2048,
              AW = 30,
              DW = 32
)
    input                        sclk,
    input                        rst_n,
    input                        rd_start,

    input       [5:0]            rd_cmd_bl,
    input       [6:0]            c3_p3_rd_count,
    //spartan-6的mig端口 p2是写端口
    output logic                 c3_p3_rd_en,
    output logic                 c3_p3_cmd_en,
    output logic [5:0]           c3_p3_cmd_bl,
    output logic [AW-1:0]        c3_p3_cmd_byte_addr,

    output logic                 user_rd_end //写结束
);

logic [6:0] data_cnt;
//data_en
always_ff@(posedge sclk)
    if (~rst_n)
        data_cnt <= 0;
    else if (c3_p3_rd_en==1)
        data_cnt <= data_cnt + 'd1;
    else data_cnt <= 'd0;

//c3_p3_rd_en
always_ff@(posedge sclk)
    if (~rst_n)
        c3_p3_rd_en <= 'b0;
    else if (data_cnt==c3_p3_cmd_bl)
        c3_p3_rd_en <= 'b0
    else if (c3_p3_rd_count==c3_p3_cmd_bl + 'd1)
     c3_p3_rd_en <= 'b1;


//c3_p3_cmd_en
always_ff@(posedge sclk)
    if (~rst_n)
        c3_p3_cmd_en <= 'b0;
    else 
        c3_p3_cmd_en <= rd_start;
 
//c3_p3_cmd_bl
 always_ff@(posedge sclk)
    if (~rst_n)
        c3_p3_cmd_bl <= 'd0;
    else if (rd_start)
        c3_p3_cmd_bl <= rd_cmd_bl;
    else 
        c3_p3_cmd_bl <= 'd0;

//c3_p3_cmd_byte_addr
always_ff@(posedge sclk)
    if (~rst_n)
        c3_p3_cmd_byte_addr <= INIT_ADDR;
    else if (c3_p3_cmd_byte_addr == MAX_ADDR)
        c3_p3_cmd_byte_addr <= INIT_ADDR;
    else if (c3_p3_cmd_en==1)
        c3_p3_cmd_byte_addr <= c3_p3_cmd_byte_addr + (c3_p3_cmd_bl+1) << 2;
    else 
        c3_p3_cmd_byte_addr <= 'd0;


//user_rd_end
always_ff@(posedge sclk)
    if (~rst_n)
        user_rd_end <= 'b0;
    else if (data_cnt==c3_p3_cmd_bl)
        user_rd_end <= 'b1;
    else 
        user_rd_end <= 'b0;





endmodule