
// 直接型多相滤波器的实现
// 没有前置的降采样结构，改为8路并行输入

module ppf_top (
    input  wire              clk_i,
    input  wire              rstn_i,
    input  wire              data_valid_i,
    input  wire signed[31:0] channel0_data_i,
    input  wire signed[31:0] channel1_data_i,
    input  wire signed[31:0] channel2_data_i,
    input  wire signed[31:0] channel3_data_i,
    input  wire signed[31:0] channel4_data_i,
    input  wire signed[31:0] channel5_data_i,
    input  wire signed[31:0] channel6_data_i,
    input  wire signed[31:0] channel7_data_i,
    output wire signed[63:0] channel0_data_o,
    output wire signed[63:0] channel1_data_o,
    output wire signed[63:0] channel2_data_o,
    output wire signed[63:0] channel3_data_o,
    output wire signed[63:0] channel4_data_o,
    output wire signed[63:0] channel5_data_o,
    output wire signed[63:0] channel6_data_o,
    output wire signed[63:0] channel7_data_o
);

localparam FIR0_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/direct_ppf/src/ch0_h_hex.txt";
localparam FIR1_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/direct_ppf/src/ch1_h_hex.txt";
localparam FIR2_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/direct_ppf/src/ch2_h_hex.txt";
localparam FIR3_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/direct_ppf/src/ch3_h_hex.txt";
localparam FIR4_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/direct_ppf/src/ch4_h_hex.txt";
localparam FIR5_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/direct_ppf/src/ch5_h_hex.txt";
localparam FIR6_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/direct_ppf/src/ch6_h_hex.txt";
localparam FIR7_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/direct_ppf/src/ch7_h_hex.txt";

wire signed[63:0] ch0_fir_dout;
wire signed[63:0] ch1_fir_dout;
wire signed[63:0] ch2_fir_dout;
wire signed[63:0] ch3_fir_dout;
wire signed[63:0] ch4_fir_dout;
wire signed[63:0] ch5_fir_dout;
wire signed[63:0] ch6_fir_dout;
wire signed[63:0] ch7_fir_dout;

filtering #(
    .DIN_WIDTH  (16),
    .COEFF_FILE (FIR0_FILEPATH), // 滤波器系数文件的路径
    .COEFF_WIDTH(16), // 滤波器系数宽度
    .COEFF_NUM  (4), // 滤波器系数个数
    .DOUT_WIDTH (32)
) channel0_fir (
    .clk_i       (clk_i),
    .rstn_i      (rstn_i),
    .data_valid_i(data_valid_i),
    .data_real_i (channel0_data_i[31:16]),
    .data_imag_i (channel0_data_i[15:0]),
    .data_real_o (ch0_fir_dout[63:32]),
    .data_imag_o (ch0_fir_dout[31:0])
);

filtering #(
    .DIN_WIDTH  (16),
    .COEFF_FILE (FIR1_FILEPATH), // 滤波器系数文件的路径
    .COEFF_WIDTH(16), // 滤波器系数宽度
    .COEFF_NUM  (4), // 滤波器系数个数
    .DOUT_WIDTH (32)
) channel1_fir (
    .clk_i       (clk_i),
    .rstn_i      (rstn_i),
    .data_valid_i(data_valid_i),
    .data_real_i (channel1_data_i[31:16]),
    .data_imag_i (channel1_data_i[15:0]),
    .data_real_o (ch1_fir_dout[63:32]),
    .data_imag_o (ch1_fir_dout[31:0])
);

filtering #(
    .DIN_WIDTH  (16),
    .COEFF_FILE (FIR2_FILEPATH), // 滤波器系数文件的路径
    .COEFF_WIDTH(16), // 滤波器系数宽度
    .COEFF_NUM  (4), // 滤波器系数个数
    .DOUT_WIDTH (32)
) channel2_fir (
    .clk_i       (clk_i),
    .rstn_i      (rstn_i),
    .data_valid_i(data_valid_i),
    .data_real_i (channel2_data_i[31:16]),
    .data_imag_i (channel2_data_i[15:0]),
    .data_real_o (ch2_fir_dout[63:32]),
    .data_imag_o (ch2_fir_dout[31:0])
);

filtering #(
    .DIN_WIDTH  (16),
    .COEFF_FILE (FIR3_FILEPATH), // 滤波器系数文件的路径
    .COEFF_WIDTH(16), // 滤波器系数宽度
    .COEFF_NUM  (4), // 滤波器系数个数
    .DOUT_WIDTH (32)
) channel3_fir (
    .clk_i       (clk_i),
    .rstn_i      (rstn_i),
    .data_valid_i(data_valid_i),
    .data_real_i (channel3_data_i[31:16]),
    .data_imag_i (channel3_data_i[15:0]),
    .data_real_o (ch3_fir_dout[63:32]),
    .data_imag_o (ch3_fir_dout[31:0])
);

filtering #(
    .DIN_WIDTH  (16),
    .COEFF_FILE (FIR4_FILEPATH), // 滤波器系数文件的路径
    .COEFF_WIDTH(16), // 滤波器系数宽度
    .COEFF_NUM  (4), // 滤波器系数个数
    .DOUT_WIDTH (32)
) channel4_fir (
    .clk_i       (clk_i),
    .rstn_i      (rstn_i),
    .data_valid_i(data_valid_i),
    .data_real_i (channel4_data_i[31:16]),
    .data_imag_i (channel4_data_i[15:0]),
    .data_real_o (ch4_fir_dout[63:32]),
    .data_imag_o (ch4_fir_dout[31:0])
);

filtering #(
    .DIN_WIDTH  (16),
    .COEFF_FILE (FIR5_FILEPATH), // 滤波器系数文件的路径
    .COEFF_WIDTH(16), // 滤波器系数宽度
    .COEFF_NUM  (4), // 滤波器系数个数
    .DOUT_WIDTH (32)
) channel5_fir (
    .clk_i       (clk_i),
    .rstn_i      (rstn_i),
    .data_valid_i(data_valid_i),
    .data_real_i (channel5_data_i[31:16]),
    .data_imag_i (channel5_data_i[15:0]),
    .data_real_o (ch5_fir_dout[63:32]),
    .data_imag_o (ch5_fir_dout[31:0])
);

filtering #(
    .DIN_WIDTH  (16),
    .COEFF_FILE (FIR6_FILEPATH), // 滤波器系数文件的路径
    .COEFF_WIDTH(16), // 滤波器系数宽度
    .COEFF_NUM  (4), // 滤波器系数个数
    .DOUT_WIDTH (32)
) channel6_fir (
    .clk_i       (clk_i),
    .rstn_i      (rstn_i),
    .data_valid_i(data_valid_i),
    .data_real_i (channel6_data_i[31:16]),
    .data_imag_i (channel6_data_i[15:0]),
    .data_real_o (ch6_fir_dout[63:32]),
    .data_imag_o (ch6_fir_dout[31:0])
);

filtering #(
    .DIN_WIDTH  (16),
    .COEFF_FILE (FIR7_FILEPATH), // 滤波器系数文件的路径
    .COEFF_WIDTH(16), // 滤波器系数宽度
    .COEFF_NUM  (4), // 滤波器系数个数
    .DOUT_WIDTH (32)
) channel7_fir (
    .clk_i       (clk_i),
    .rstn_i      (rstn_i),
    .data_valid_i(data_valid_i),
    .data_real_i (channel7_data_i[31:16]),
    .data_imag_i (channel7_data_i[15:0]),
    .data_real_o (ch7_fir_dout[63:32]),
    .data_imag_o (ch7_fir_dout[31:0])
);

dft_mtx dft_mtx_inst (
    .clk_i          (clk_i),
    .channel0_data_i(ch0_fir_dout),
    .channel1_data_i(ch1_fir_dout),
    .channel2_data_i(ch2_fir_dout),
    .channel3_data_i(ch3_fir_dout),
    .channel4_data_i(ch4_fir_dout),
    .channel5_data_i(ch5_fir_dout),
    .channel6_data_i(ch6_fir_dout),
    .channel7_data_i(ch7_fir_dout),
    .channel0_data_o(channel0_data_o),
    .channel1_data_o(channel1_data_o),
    .channel2_data_o(channel2_data_o),
    .channel3_data_o(channel3_data_o),
    .channel4_data_o(channel4_data_o),
    .channel5_data_o(channel5_data_o),
    .channel6_data_o(channel6_data_o),
    .channel7_data_o(channel7_data_o)
);

endmodule