// 带axis接口的直接型多相滤波器

module s_axis_direct_ppf #(
    parameter TDATA_WIDTH = 32
) (
// axi-stream 接口
    input  wire                  ACLK           , // axis时钟
    input  wire                  ARESETn        , // axis全局复位，低电平有效
    input  wire[TDATA_WIDTH-1:0] TDATA          , // 传入数据，前半部分为实部，后半部分为虚部
    input  wire                  TVALID         , // 数据有效
    input  wire                  TLAST          , // 最后一个数据
    output wire                  TREADY         , // 准备接收数据
    output wire[63:0]            channel0_data_o,
    output wire[63:0]            channel1_data_o,
    output wire[63:0]            channel2_data_o,
    output wire[63:0]            channel3_data_o,
    output wire[63:0]            channel4_data_o,
    output wire[63:0]            channel5_data_o,
    output wire[63:0]            channel6_data_o,
    output wire[63:0]            channel7_data_o
);

localparam FIR0_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/s_axis_direct_ppf/QS_proj/src/ch0_h_hex.txt";
localparam FIR1_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/s_axis_direct_ppf/QS_proj/src/ch1_h_hex.txt";
localparam FIR2_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/s_axis_direct_ppf/QS_proj/src/ch2_h_hex.txt";
localparam FIR3_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/s_axis_direct_ppf/QS_proj/src/ch3_h_hex.txt";
localparam FIR4_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/s_axis_direct_ppf/QS_proj/src/ch4_h_hex.txt";
localparam FIR5_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/s_axis_direct_ppf/QS_proj/src/ch5_h_hex.txt";
localparam FIR6_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/s_axis_direct_ppf/QS_proj/src/ch6_h_hex.txt";
localparam FIR7_FILEPATH = "D:/Code/Proj/filter_FPGA/PP/rtl/s_axis_direct_ppf/QS_proj/src/ch7_h_hex.txt";

wire freq_divider__div_clk_o;
wire s_axis_wrapper__ch0_valid_o;
wire[TDATA_WIDTH-1:0] s_axis_wrapper__ch0_o;
wire s_axis_wrapper__ch1_valid_o;
wire[TDATA_WIDTH-1:0] s_axis_wrapper__ch1_o;
wire s_axis_wrapper__ch2_valid_o;
wire[TDATA_WIDTH-1:0] s_axis_wrapper__ch2_o;
wire s_axis_wrapper__ch3_valid_o;
wire[TDATA_WIDTH-1:0] s_axis_wrapper__ch3_o;
wire s_axis_wrapper__ch4_valid_o;
wire[TDATA_WIDTH-1:0] s_axis_wrapper__ch4_o;
wire s_axis_wrapper__ch5_valid_o;
wire[TDATA_WIDTH-1:0] s_axis_wrapper__ch5_o;
wire s_axis_wrapper__ch6_valid_o;
wire[TDATA_WIDTH-1:0] s_axis_wrapper__ch6_o;
wire s_axis_wrapper__ch7_valid_o;
wire[TDATA_WIDTH-1:0] s_axis_wrapper__ch7_o;

wire[63:0] ch0_fir_dout;
wire[63:0] ch1_fir_dout;
wire[63:0] ch2_fir_dout;
wire[63:0] ch3_fir_dout;
wire[63:0] ch4_fir_dout;
wire[63:0] ch5_fir_dout;
wire[63:0] ch6_fir_dout;
wire[63:0] ch7_fir_dout;

wire to_dff;
reg dff1, dff2, dff3, dff4, dff5, dff6; // 延时寄存器（Delay Flip-Flop）

//--------------------------------------------------
// instantiation

// axis接口转换
s_axis_wrapper #(
    .TDATA_WIDTH(TDATA_WIDTH)
) axis_wrapper (
    .ACLK       (ACLK),
    .ARESETn    (ARESETn),
    .TDATA      (TDATA),
    .TVALID     (TVALID),
    .TLAST      (TLAST),
    .TREADY     (TREADY),
    .ch0_valid_o(s_axis_wrapper__ch0_valid_o),
    .ch0_o      (s_axis_wrapper__ch0_o),
    .ch1_valid_o(s_axis_wrapper__ch1_valid_o),
    .ch1_o      (s_axis_wrapper__ch1_o),
    .ch2_valid_o(s_axis_wrapper__ch2_valid_o),
    .ch2_o      (s_axis_wrapper__ch2_o),
    .ch3_valid_o(s_axis_wrapper__ch3_valid_o),
    .ch3_o      (s_axis_wrapper__ch3_o),
    .ch4_valid_o(s_axis_wrapper__ch4_valid_o),
    .ch4_o      (s_axis_wrapper__ch4_o),
    .ch5_valid_o(s_axis_wrapper__ch5_valid_o),
    .ch5_o      (s_axis_wrapper__ch5_o),
    .ch6_valid_o(s_axis_wrapper__ch6_valid_o),
    .ch6_o      (s_axis_wrapper__ch6_o),
    .ch7_valid_o(s_axis_wrapper__ch7_valid_o),
    .ch7_o      (s_axis_wrapper__ch7_o) 
);

// 分频器
freq_divider #(
    .DIV_RATIO(4)
) divider (
    .clk_i    (ACLK),
    .rstn_i   (ARESETn),
    .div_clk_o(to_dff)
);

// 延时器，目的是使得时钟上升沿与DFT矩阵的输入信号沿对齐
// 注：存在一定的时序问题，需要检查卷积部分模块进行对应修改
always @(posedge ACLK) begin
    dff1 <= to_dff;
    dff2 <= dff1;
    dff3 <= dff2;
    dff4 <= dff3;
    dff5 <= dff4;
    dff6 <= dff5;
end

assign freq_divider__div_clk_o = dff6;

// fir滤波器
filtering #(
    .DIN_WIDTH  (16),
    .COEFF_FILE (FIR7_FILEPATH), // 滤波器系数文件的路径
    .COEFF_WIDTH(16), // 滤波器系数宽度
    .COEFF_NUM  (4), // 滤波器系数个数
    .DOUT_WIDTH (32)
) channel0_fir (
    .clk_i       (freq_divider__div_clk_o),
    .rstn_i      (ARESETn),
    .data_valid_i(s_axis_wrapper__ch0_valid_o),
    .data_real_i (s_axis_wrapper__ch0_o[31:16]),
    .data_imag_i (s_axis_wrapper__ch0_o[15:0]),
    .data_real_o (ch0_fir_dout[63:32]),
    .data_imag_o (ch0_fir_dout[31:0])
);

filtering #(
    .DIN_WIDTH  (16),
    .COEFF_FILE (FIR6_FILEPATH), // 滤波器系数文件的路径
    .COEFF_WIDTH(16), // 滤波器系数宽度
    .COEFF_NUM  (4), // 滤波器系数个数
    .DOUT_WIDTH (32)
) channel1_fir (
    .clk_i       (freq_divider__div_clk_o),
    .rstn_i      (ARESETn),
    .data_valid_i(s_axis_wrapper__ch1_valid_o),
    .data_real_i (s_axis_wrapper__ch1_o[31:16]),
    .data_imag_i (s_axis_wrapper__ch1_o[15:0]),
    .data_real_o (ch1_fir_dout[63:32]),
    .data_imag_o (ch1_fir_dout[31:0])
);

filtering #(
    .DIN_WIDTH  (16),
    .COEFF_FILE (FIR5_FILEPATH), // 滤波器系数文件的路径
    .COEFF_WIDTH(16), // 滤波器系数宽度
    .COEFF_NUM  (4), // 滤波器系数个数
    .DOUT_WIDTH (32)
) channel2_fir (
    .clk_i       (freq_divider__div_clk_o),
    .rstn_i      (ARESETn),
    .data_valid_i(s_axis_wrapper__ch2_valid_o),
    .data_real_i (s_axis_wrapper__ch2_o[31:16]),
    .data_imag_i (s_axis_wrapper__ch2_o[15:0]),
    .data_real_o (ch2_fir_dout[63:32]),
    .data_imag_o (ch2_fir_dout[31:0])
);

filtering #(
    .DIN_WIDTH  (16),
    .COEFF_FILE (FIR4_FILEPATH), // 滤波器系数文件的路径
    .COEFF_WIDTH(16), // 滤波器系数宽度
    .COEFF_NUM  (4), // 滤波器系数个数
    .DOUT_WIDTH (32)
) channel3_fir (
    .clk_i       (freq_divider__div_clk_o),
    .rstn_i      (ARESETn),
    .data_valid_i(s_axis_wrapper__ch3_valid_o),
    .data_real_i (s_axis_wrapper__ch3_o[31:16]),
    .data_imag_i (s_axis_wrapper__ch3_o[15:0]),
    .data_real_o (ch3_fir_dout[63:32]),
    .data_imag_o (ch3_fir_dout[31:0])
);

filtering #(
    .DIN_WIDTH  (16),
    .COEFF_FILE (FIR3_FILEPATH), // 滤波器系数文件的路径
    .COEFF_WIDTH(16), // 滤波器系数宽度
    .COEFF_NUM  (4), // 滤波器系数个数
    .DOUT_WIDTH (32)
) channel4_fir (
    .clk_i       (freq_divider__div_clk_o),
    .rstn_i      (ARESETn),
    .data_valid_i(s_axis_wrapper__ch4_valid_o),
    .data_real_i (s_axis_wrapper__ch4_o[31:16]),
    .data_imag_i (s_axis_wrapper__ch4_o[15:0]),
    .data_real_o (ch4_fir_dout[63:32]),
    .data_imag_o (ch4_fir_dout[31:0])
);

filtering #(
    .DIN_WIDTH  (16),
    .COEFF_FILE (FIR2_FILEPATH), // 滤波器系数文件的路径
    .COEFF_WIDTH(16), // 滤波器系数宽度
    .COEFF_NUM  (4), // 滤波器系数个数
    .DOUT_WIDTH (32)
) channel5_fir (
    .clk_i       (freq_divider__div_clk_o),
    .rstn_i      (ARESETn),
    .data_valid_i(s_axis_wrapper__ch5_valid_o),
    .data_real_i (s_axis_wrapper__ch5_o[31:16]),
    .data_imag_i (s_axis_wrapper__ch5_o[15:0]),
    .data_real_o (ch5_fir_dout[63:32]),
    .data_imag_o (ch5_fir_dout[31:0])
);

filtering #(
    .DIN_WIDTH  (16),
    .COEFF_FILE (FIR1_FILEPATH), // 滤波器系数文件的路径
    .COEFF_WIDTH(16), // 滤波器系数宽度
    .COEFF_NUM  (4), // 滤波器系数个数
    .DOUT_WIDTH (32)
) channel6_fir (
    .clk_i       (freq_divider__div_clk_o),
    .rstn_i      (ARESETn),
    .data_valid_i(s_axis_wrapper__ch6_valid_o),
    .data_real_i (s_axis_wrapper__ch6_o[31:16]),
    .data_imag_i (s_axis_wrapper__ch6_o[15:0]),
    .data_real_o (ch6_fir_dout[63:32]),
    .data_imag_o (ch6_fir_dout[31:0])
);

filtering #(
    .DIN_WIDTH  (16),
    .COEFF_FILE (FIR0_FILEPATH), // 滤波器系数文件的路径
    .COEFF_WIDTH(16), // 滤波器系数宽度
    .COEFF_NUM  (4), // 滤波器系数个数
    .DOUT_WIDTH (32)
) channel7_fir (
    .clk_i       (freq_divider__div_clk_o),
    .rstn_i      (ARESETn),
    .data_valid_i(s_axis_wrapper__ch7_valid_o),
    .data_real_i (s_axis_wrapper__ch7_o[31:16]),
    .data_imag_i (s_axis_wrapper__ch7_o[15:0]),
    .data_real_o (ch7_fir_dout[63:32]),
    .data_imag_o (ch7_fir_dout[31:0])
);

// DFT系数矩阵
dft_mtx dft_mtx_inst (
    .clk_i          (freq_divider__div_clk_o),
    .channel0_data_i(ch7_fir_dout),
    .channel1_data_i(ch6_fir_dout),
    .channel2_data_i(ch5_fir_dout),
    .channel3_data_i(ch4_fir_dout),
    .channel4_data_i(ch3_fir_dout),
    .channel5_data_i(ch2_fir_dout),
    .channel6_data_i(ch1_fir_dout),
    .channel7_data_i(ch0_fir_dout),
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