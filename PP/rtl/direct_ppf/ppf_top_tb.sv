
// 对直接型ppf的顶层测试文件

`timescale 1ns/1ps

module ppf_top_tb;

logic              clk_i;
logic              rstn_i;
logic              data_valid_i;
logic signed[31:0] channel0_data_i;
logic signed[31:0] channel1_data_i;
logic signed[31:0] channel2_data_i;
logic signed[31:0] channel3_data_i;
logic signed[31:0] channel4_data_i;
logic signed[31:0] channel5_data_i;
logic signed[31:0] channel6_data_i;
logic signed[31:0] channel7_data_i;
logic signed[63:0] channel0_data_o;
logic signed[63:0] channel1_data_o;
logic signed[63:0] channel2_data_o;
logic signed[63:0] channel3_data_o;
logic signed[63:0] channel4_data_o;
logic signed[63:0] channel5_data_o;
logic signed[63:0] channel6_data_o;
logic signed[63:0] channel7_data_o;

ppf_top DUT (
    .clk_i          (clk_i),
    .rstn_i         (rstn_i),
    .data_valid_i   (data_valid_i),
    .channel0_data_i(channel0_data_i),
    .channel1_data_i(channel1_data_i),
    .channel2_data_i(channel2_data_i),
    .channel3_data_i(channel3_data_i),
    .channel4_data_i(channel4_data_i),
    .channel5_data_i(channel5_data_i),
    .channel6_data_i(channel6_data_i),
    .channel7_data_i(channel7_data_i),
    .channel0_data_o(channel0_data_o),
    .channel1_data_o(channel1_data_o),
    .channel2_data_o(channel2_data_o),
    .channel3_data_o(channel3_data_o),
    .channel4_data_o(channel4_data_o),
    .channel5_data_o(channel5_data_o),
    .channel6_data_o(channel6_data_o),
    .channel7_data_o(channel7_data_o)
);

initial begin
    clk_i = 0;
    rstn_i = 0;
    channel0_data_i = 0;
    channel1_data_i = 0;
    channel2_data_i = 0;
    channel3_data_i = 0;
    channel4_data_i = 0;
    channel5_data_i = 0;
    channel6_data_i = 0;
    channel7_data_i = 0;

    #200;
    rstn_i = 1;
end

initial begin
    forever begin
        #10;
        clk_i = ~clk_i;
    end
end

localparam SIGNAL0_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch0_signal_hex.txt";
localparam SIGNAL1_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch1_signal_hex.txt";
localparam SIGNAL2_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch2_signal_hex.txt";
localparam SIGNAL3_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch3_signal_hex.txt";
localparam SIGNAL4_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch4_signal_hex.txt";
localparam SIGNAL5_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch5_signal_hex.txt";
localparam SIGNAL6_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch6_signal_hex.txt";
localparam SIGNAL7_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch7_signal_hex.txt";

//========================================
// read signal data into register and driving
localparam SIN_DATA_NUM = 16;

logic[31:0] sim0_din[0:SIN_DATA_NUM-1];
logic[31:0] sim1_din[0:SIN_DATA_NUM-1];
logic[31:0] sim2_din[0:SIN_DATA_NUM-1];
logic[31:0] sim3_din[0:SIN_DATA_NUM-1];
logic[31:0] sim4_din[0:SIN_DATA_NUM-1];
logic[31:0] sim5_din[0:SIN_DATA_NUM-1];
logic[31:0] sim6_din[0:SIN_DATA_NUM-1];
logic[31:0] sim7_din[0:SIN_DATA_NUM-1];
int index;
logic[31:0] din;
initial begin
    data_valid_i = 0;
    index = 0;
    
    $readmemh(SIGNAL0_FILEPATH, sim0_din, 0, SIN_DATA_NUM-1);
    $readmemh(SIGNAL1_FILEPATH, sim1_din, 0, SIN_DATA_NUM-1);
    $readmemh(SIGNAL2_FILEPATH, sim2_din, 0, SIN_DATA_NUM-1);
    $readmemh(SIGNAL3_FILEPATH, sim3_din, 0, SIN_DATA_NUM-1);
    $readmemh(SIGNAL4_FILEPATH, sim4_din, 0, SIN_DATA_NUM-1);
    $readmemh(SIGNAL5_FILEPATH, sim5_din, 0, SIN_DATA_NUM-1);
    $readmemh(SIGNAL6_FILEPATH, sim6_din, 0, SIN_DATA_NUM-1);
    $readmemh(SIGNAL7_FILEPATH, sim7_din, 0, SIN_DATA_NUM-1);

    #500;
    repeat(SIN_DATA_NUM) begin
        @(posedge clk_i);
        data_valid_i <= 1;
        channel0_data_i <= sim0_din[index];
        channel1_data_i <= sim1_din[index];
        channel2_data_i <= sim2_din[index];
        channel3_data_i <= sim3_din[index];
        channel4_data_i <= sim4_din[index];
        channel5_data_i <= sim5_din[index];
        channel6_data_i <= sim6_din[index];
        channel7_data_i <= sim7_din[index];
        index ++;
    end
end

endmodule: ppf_top_tb