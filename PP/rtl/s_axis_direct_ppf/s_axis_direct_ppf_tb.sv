// 对带axis接口的直接型ppf的顶层测试文件

`timescale 1ns/1ps

module s_axis_direct_ppf_tb;

logic clk, rstn;
logic[31:0] din;
logic tvalid, tlast, tready;
logic signed[63:0] ch0_dout, ch1_dout, ch2_dout, ch3_dout, ch4_dout, ch5_dout, ch6_dout, ch7_dout;

s_axis_direct_ppf #(
    .TDATA_WIDTH(32)
) DUT (
    .ACLK   (clk),
    .ARESETn(rstn),
    .TDATA  (din),
    .TVALID (tvalid),
    .TLAST  (tlast),
    .TREADY (tready),
    .channel0_data_o(ch0_dout),
    .channel1_data_o(ch1_dout),
    .channel2_data_o(ch2_dout),
    .channel3_data_o(ch3_dout),
    .channel4_data_o(ch4_dout),
    .channel5_data_o(ch5_dout),
    .channel6_data_o(ch6_dout),
    .channel7_data_o(ch7_dout)
);

initial begin
    clk = 0;
    rstn = 0;
    din = 0;
    tvalid = 0;
    tlast = 0;

    #200;
    rstn = 1;
end

initial begin
    forever begin
        #10;
        clk = ~clk;
    end
end

localparam SIGNAL_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/s_axis_direct_ppf/QS_proj/src/signal_hex.txt";

//========================================
// read signal data into register and driving
localparam SIN_DATA_NUM = 128;
logic[31:0] sim_din[0:SIN_DATA_NUM-1];
int index;
initial begin
    index = 0;
    
    $readmemh(SIGNAL_FILEPATH, sim_din, 0, SIN_DATA_NUM-1);

    #5000;
    repeat(SIN_DATA_NUM) begin
        @(posedge clk);
        tvalid <= 1;
        din <= sim_din[index];
        index ++;
    end
    @(posedge clk) tvalid <= 0;
    #1000;
end

endmodule: s_axis_direct_ppf_tb