
// dft 系数矩阵，由Matlab进行量化生成
/*
00007FFF_00000000 00007FFF_00000000 00007FFF_00000000 00007FFF_00000000 00007FFF_00000000 00007FFF_00000000 00007FFF_00000000 00007FFF_00000000 
00007FFF_00000000 00005A81_00005A81 00000000_00007FFF FFFFA57E_00005A81 FFFF8001_00000000 FFFFA57E_FFFFA57E FFFFFFFF_FFFF8001 00005A81_FFFFA57E 
00007FFF_00000000 00000000_00007FFF FFFF8001_00000000 FFFFFFFF_FFFF8001 00007FFF_FFFFFFFF 00000000_00007FFF FFFF8001_00000000 FFFFFFFF_FFFF8001 
00007FFF_00000000 FFFFA57E_00005A81 FFFFFFFF_FFFF8001 00005A81_00005A81 FFFF8001_00000000 00005A81_FFFFA57E 00000000_00007FFF FFFFA57E_FFFFA57E 
00007FFF_00000000 FFFF8001_00000000 00007FFF_FFFFFFFF FFFF8001_00000000 00007FFF_FFFFFFFF FFFF8001_00000000 00007FFF_FFFFFFFF FFFF8001_00000000 
00007FFF_00000000 FFFFA57E_FFFFA57E 00000000_00007FFF 00005A81_FFFFA57E FFFF8001_00000000 00005A81_00005A81 FFFFFFFF_FFFF8001 FFFFA57E_00005A81 
00007FFF_00000000 FFFFFFFF_FFFF8001 FFFF8001_00000000 00000000_00007FFF 00007FFF_FFFFFFFF FFFFFFFF_FFFF8001 FFFF8001_00000000 00000000_00007FFF 
00007FFF_00000000 00005A81_FFFFA57E FFFFFFFF_FFFF8001 FFFFA57E_FFFFA57E FFFF8001_00000000 FFFFA57E_00005A81 00000000_00007FFF 00005A81_00005A81 
*/

module dft_mtx (
    input  wire              clk_i,
    input  wire signed[63:0] channel0_data_i,
    input  wire signed[63:0] channel1_data_i,
    input  wire signed[63:0] channel2_data_i,
    input  wire signed[63:0] channel3_data_i,
    input  wire signed[63:0] channel4_data_i,
    input  wire signed[63:0] channel5_data_i,
    input  wire signed[63:0] channel6_data_i,
    input  wire signed[63:0] channel7_data_i,
    output wire signed[63:0] channel0_data_o,
    output wire signed[63:0] channel1_data_o,
    output wire signed[63:0] channel2_data_o,
    output wire signed[63:0] channel3_data_o,
    output wire signed[63:0] channel4_data_o,
    output wire signed[63:0] channel5_data_o,
    output wire signed[63:0] channel6_data_o,
    output wire signed[63:0] channel7_data_o
);

//========================================
// channel0 signals
wire signed[31:0] ch0_poly0_real;
wire signed[31:0] ch0_poly0_imag;
wire signed[31:0] ch0_poly1_real;
wire signed[31:0] ch0_poly1_imag;
wire signed[31:0] ch0_poly2_real;
wire signed[31:0] ch0_poly2_imag;
wire signed[31:0] ch0_poly3_real;
wire signed[31:0] ch0_poly3_imag;
wire signed[31:0] ch0_poly4_real;
wire signed[31:0] ch0_poly4_imag;
wire signed[31:0] ch0_poly5_real;
wire signed[31:0] ch0_poly5_imag;
wire signed[31:0] ch0_poly6_real;
wire signed[31:0] ch0_poly6_imag;
wire signed[31:0] ch0_poly7_real;
wire signed[31:0] ch0_poly7_imag;
wire signed[31:0] ch0_real;
wire signed[31:0] ch0_imag;

assign ch0_real = ch0_poly0_real + ch0_poly1_real + ch0_poly2_real + ch0_poly3_real + ch0_poly4_real + ch0_poly5_real + ch0_poly6_real + ch0_poly7_real;
assign ch0_imag = ch0_poly0_imag + ch0_poly1_imag + ch0_poly2_imag + ch0_poly3_imag + ch0_poly4_imag + ch0_poly5_imag + ch0_poly6_imag + ch0_poly7_imag;
assign channel0_data_o = {ch0_real, ch0_imag};

//========================================
// channel1 signals
wire signed[31:0] ch1_poly0_real;
wire signed[31:0] ch1_poly0_imag;
wire signed[31:0] ch1_poly1_real;
wire signed[31:0] ch1_poly1_imag;
wire signed[31:0] ch1_poly2_real;
wire signed[31:0] ch1_poly2_imag;
wire signed[31:0] ch1_poly3_real;
wire signed[31:0] ch1_poly3_imag;
wire signed[31:0] ch1_poly4_real;
wire signed[31:0] ch1_poly4_imag;
wire signed[31:0] ch1_poly5_real;
wire signed[31:0] ch1_poly5_imag;
wire signed[31:0] ch1_poly6_real;
wire signed[31:0] ch1_poly6_imag;
wire signed[31:0] ch1_poly7_real;
wire signed[31:0] ch1_poly7_imag;
wire signed[31:0] ch1_real;
wire signed[31:0] ch1_imag;

assign ch1_real = ch1_poly0_real + ch1_poly1_real + ch1_poly2_real + ch1_poly3_real + ch1_poly4_real + ch1_poly5_real + ch1_poly6_real + ch1_poly7_real;
assign ch1_imag = ch1_poly0_imag + ch1_poly1_imag + ch1_poly2_imag + ch1_poly3_imag + ch1_poly4_imag + ch1_poly5_imag + ch1_poly6_imag + ch1_poly7_imag;
assign channel1_data_o = {ch1_real, ch1_imag};

//========================================
// channel2 signals
wire signed[31:0] ch2_poly0_real;
wire signed[31:0] ch2_poly0_imag;
wire signed[31:0] ch2_poly1_real;
wire signed[31:0] ch2_poly1_imag;
wire signed[31:0] ch2_poly2_real;
wire signed[31:0] ch2_poly2_imag;
wire signed[31:0] ch2_poly3_real;
wire signed[31:0] ch2_poly3_imag;
wire signed[31:0] ch2_poly4_real;
wire signed[31:0] ch2_poly4_imag;
wire signed[31:0] ch2_poly5_real;
wire signed[31:0] ch2_poly5_imag;
wire signed[31:0] ch2_poly6_real;
wire signed[31:0] ch2_poly6_imag;
wire signed[31:0] ch2_poly7_real;
wire signed[31:0] ch2_poly7_imag;
wire signed[31:0] ch2_real;
wire signed[31:0] ch2_imag;
assign ch2_real = ch2_poly0_real + ch2_poly1_real + ch2_poly2_real + ch2_poly3_real + ch2_poly4_real + ch2_poly5_real + ch2_poly6_real + ch2_poly7_real;
assign ch2_imag = ch2_poly0_imag + ch2_poly1_imag + ch2_poly2_imag + ch2_poly3_imag + ch2_poly4_imag + ch2_poly5_imag + ch2_poly6_imag + ch2_poly7_imag;
assign channel2_data_o = {ch2_real, ch2_imag};

//========================================
// channel3 signals
wire signed[31:0] ch3_poly0_real;
wire signed[31:0] ch3_poly0_imag;
wire signed[31:0] ch3_poly1_real;
wire signed[31:0] ch3_poly1_imag;
wire signed[31:0] ch3_poly2_real;
wire signed[31:0] ch3_poly2_imag;
wire signed[31:0] ch3_poly3_real;
wire signed[31:0] ch3_poly3_imag;
wire signed[31:0] ch3_poly4_real;
wire signed[31:0] ch3_poly4_imag;
wire signed[31:0] ch3_poly5_real;
wire signed[31:0] ch3_poly5_imag;
wire signed[31:0] ch3_poly6_real;
wire signed[31:0] ch3_poly6_imag;
wire signed[31:0] ch3_poly7_real;
wire signed[31:0] ch3_poly7_imag;
wire signed[31:0] ch3_real;
wire signed[31:0] ch3_imag;
assign ch3_real = ch3_poly0_real + ch3_poly1_real + ch3_poly2_real + ch3_poly3_real + ch3_poly4_real + ch3_poly5_real + ch3_poly6_real + ch3_poly7_real;
assign ch3_imag = ch3_poly0_imag + ch3_poly1_imag + ch3_poly2_imag + ch3_poly3_imag + ch3_poly4_imag + ch3_poly5_imag + ch3_poly6_imag + ch3_poly7_imag;
assign channel3_data_o = {ch3_real, ch3_imag};

//========================================
// channel4 signals
wire signed[31:0] ch4_poly0_real;
wire signed[31:0] ch4_poly0_imag;
wire signed[31:0] ch4_poly1_real;
wire signed[31:0] ch4_poly1_imag;
wire signed[31:0] ch4_poly2_real;
wire signed[31:0] ch4_poly2_imag;
wire signed[31:0] ch4_poly3_real;
wire signed[31:0] ch4_poly3_imag;
wire signed[31:0] ch4_poly4_real;
wire signed[31:0] ch4_poly4_imag;
wire signed[31:0] ch4_poly5_real;
wire signed[31:0] ch4_poly5_imag;
wire signed[31:0] ch4_poly6_real;
wire signed[31:0] ch4_poly6_imag;
wire signed[31:0] ch4_poly7_real;
wire signed[31:0] ch4_poly7_imag;
wire signed[31:0] ch4_real;
wire signed[31:0] ch4_imag;
assign ch4_real = ch4_poly0_real + ch4_poly1_real + ch4_poly2_real + ch4_poly3_real + ch4_poly4_real + ch4_poly5_real + ch4_poly6_real + ch4_poly7_real;
assign ch4_imag = ch4_poly0_imag + ch4_poly1_imag + ch4_poly2_imag + ch4_poly3_imag + ch4_poly4_imag + ch4_poly5_imag + ch4_poly6_imag + ch4_poly7_imag;
assign channel4_data_o = {ch4_real, ch4_imag};

//========================================
// channel5 signals
wire signed[31:0] ch5_poly0_real;
wire signed[31:0] ch5_poly0_imag;
wire signed[31:0] ch5_poly1_real;
wire signed[31:0] ch5_poly1_imag;
wire signed[31:0] ch5_poly2_real;
wire signed[31:0] ch5_poly2_imag;
wire signed[31:0] ch5_poly3_real;
wire signed[31:0] ch5_poly3_imag;
wire signed[31:0] ch5_poly4_real;
wire signed[31:0] ch5_poly4_imag;
wire signed[31:0] ch5_poly5_real;
wire signed[31:0] ch5_poly5_imag;
wire signed[31:0] ch5_poly6_real;
wire signed[31:0] ch5_poly6_imag;
wire signed[31:0] ch5_poly7_real;
wire signed[31:0] ch5_poly7_imag;
wire signed[31:0] ch5_real;
wire signed[31:0] ch5_imag;
assign ch5_real = ch5_poly0_real + ch5_poly1_real + ch5_poly2_real + ch5_poly3_real + ch5_poly4_real + ch5_poly5_real + ch5_poly6_real + ch5_poly7_real;
assign ch5_imag = ch5_poly0_imag + ch5_poly1_imag + ch5_poly2_imag + ch5_poly3_imag + ch5_poly4_imag + ch5_poly5_imag + ch5_poly6_imag + ch5_poly7_imag;
assign channel5_data_o = {ch5_real, ch5_imag};

//========================================
// channel6 signals
wire signed[31:0] ch6_poly0_real;
wire signed[31:0] ch6_poly0_imag;
wire signed[31:0] ch6_poly1_real;
wire signed[31:0] ch6_poly1_imag;
wire signed[31:0] ch6_poly2_real;
wire signed[31:0] ch6_poly2_imag;
wire signed[31:0] ch6_poly3_real;
wire signed[31:0] ch6_poly3_imag;
wire signed[31:0] ch6_poly4_real;
wire signed[31:0] ch6_poly4_imag;
wire signed[31:0] ch6_poly5_real;
wire signed[31:0] ch6_poly5_imag;
wire signed[31:0] ch6_poly6_real;
wire signed[31:0] ch6_poly6_imag;
wire signed[31:0] ch6_poly7_real;
wire signed[31:0] ch6_poly7_imag;
wire signed[31:0] ch6_real;
wire signed[31:0] ch6_imag;
assign ch6_real = ch6_poly0_real + ch6_poly1_real + ch6_poly2_real + ch6_poly3_real + ch6_poly4_real + ch6_poly5_real + ch6_poly6_real + ch6_poly7_real;
assign ch6_imag = ch6_poly0_imag + ch6_poly1_imag + ch6_poly2_imag + ch6_poly3_imag + ch6_poly4_imag + ch6_poly5_imag + ch6_poly6_imag + ch6_poly7_imag;
assign channel6_data_o = {ch6_real, ch6_imag};

//========================================
// channel7 signals
wire signed[31:0] ch7_poly0_real;
wire signed[31:0] ch7_poly0_imag;
wire signed[31:0] ch7_poly1_real;
wire signed[31:0] ch7_poly1_imag;
wire signed[31:0] ch7_poly2_real;
wire signed[31:0] ch7_poly2_imag;
wire signed[31:0] ch7_poly3_real;
wire signed[31:0] ch7_poly3_imag;
wire signed[31:0] ch7_poly4_real;
wire signed[31:0] ch7_poly4_imag;
wire signed[31:0] ch7_poly5_real;
wire signed[31:0] ch7_poly5_imag;
wire signed[31:0] ch7_poly6_real;
wire signed[31:0] ch7_poly6_imag;
wire signed[31:0] ch7_poly7_real;
wire signed[31:0] ch7_poly7_imag;
wire signed[31:0] ch7_real;
wire signed[31:0] ch7_imag;
assign ch7_real = ch7_poly0_real + ch7_poly1_real + ch7_poly2_real + ch7_poly3_real + ch7_poly4_real + ch7_poly5_real + ch7_poly6_real + ch7_poly7_real;
assign ch7_imag = ch7_poly0_imag + ch7_poly1_imag + ch7_poly2_imag + ch7_poly3_imag + ch7_poly4_imag + ch7_poly5_imag + ch7_poly6_imag + ch7_poly7_imag;
assign channel7_data_o = {ch7_real, ch7_imag};

//========================================
// channel0 polyphase outputs
cplx_mult ch0_poly0 (
    .clk_i(clk_i),
    .ar_i(channel0_data_i[63:32]),
    .ai_i(channel0_data_i[31:0]),
    .br_i(32'h00007FFF),
    .bi_i(32'h00000000),
    .pr_o(ch0_poly0_real),
    .pi_o(ch0_poly0_imag)
);

cplx_mult ch0_poly1 (
    .clk_i(clk_i),
    .ar_i(channel1_data_i[63:32]),
    .ai_i(channel1_data_i[31:0]),
    .br_i(32'h00007FFF),
    .bi_i(32'h00000000),
    .pr_o(ch0_poly1_real),
    .pi_o(ch0_poly1_imag)
);

cplx_mult ch0_poly2 (
    .clk_i(clk_i),
    .ar_i(channel2_data_i[63:32]),
    .ai_i(channel2_data_i[31:0]),
    .br_i(32'h00007FFF),
    .bi_i(32'h00000000),
    .pr_o(ch0_poly2_real),
    .pi_o(ch0_poly2_imag)
);

cplx_mult ch0_poly3 (
    .clk_i(clk_i),
    .ar_i(channel3_data_i[63:32]),
    .ai_i(channel3_data_i[31:0]),
    .br_i(32'h00007FFF),
    .bi_i(32'h00000000),
    .pr_o(ch0_poly3_real),
    .pi_o(ch0_poly3_imag)
);

cplx_mult ch0_poly4 (
    .clk_i(clk_i),
    .ar_i(channel4_data_i[63:32]),
    .ai_i(channel4_data_i[31:0]),
    .br_i(32'h00007FFF),
    .bi_i(32'h00000000),
    .pr_o(ch0_poly4_real),
    .pi_o(ch0_poly4_imag)
);

cplx_mult ch0_poly5 (
    .clk_i(clk_i),
    .ar_i(channel5_data_i[63:32]),
    .ai_i(channel5_data_i[31:0]),
    .br_i(32'h00007FFF),
    .bi_i(32'h00000000),
    .pr_o(ch0_poly5_real),
    .pi_o(ch0_poly5_imag)
);

cplx_mult ch0_poly6 (
    .clk_i(clk_i),
    .ar_i(channel6_data_i[63:32]),
    .ai_i(channel6_data_i[31:0]),
    .br_i(32'h00007FFF),
    .bi_i(32'h00000000),
    .pr_o(ch0_poly6_real),
    .pi_o(ch0_poly6_imag)
);

cplx_mult ch0_poly7 (
    .clk_i(clk_i),
    .ar_i(channel7_data_i[63:32]),
    .ai_i(channel7_data_i[31:0]),
    .br_i(32'h00007FFF),
    .bi_i(32'h00000000),
    .pr_o(ch0_poly7_real),
    .pi_o(ch0_poly7_imag)
);

//========================================
// channel1 polyphase outputs
cplx_mult ch1_poly0 (
    .clk_i(clk_i),
    .ar_i(channel0_data_i[63:32]),
    .ai_i(channel0_data_i[31:0]),
    .br_i(32'h00007FFF),
    .bi_i(32'h00000000),
    .pr_o(ch1_poly0_real),
    .pi_o(ch1_poly0_imag)
);

cplx_mult ch1_poly1 (
    .clk_i(clk_i),
    .ar_i(channel1_data_i[63:32]),
    .ai_i(channel1_data_i[31:0]),
    .br_i(32'h00005A81),
    .bi_i(32'h00005A81),
    .pr_o(ch1_poly1_real),
    .pi_o(ch1_poly1_imag)
);

cplx_mult ch1_poly2 (
    .clk_i(clk_i),
    .ar_i(channel2_data_i[63:32]),
    .ai_i(channel2_data_i[31:0]),
    .br_i(32'h00000000),
    .bi_i(32'h00007FFF),
    .pr_o(ch1_poly2_real),
    .pi_o(ch1_poly2_imag)
);

cplx_mult ch1_poly3 (
    .clk_i(clk_i),
    .ar_i(channel3_data_i[63:32]),
    .ai_i(channel3_data_i[31:0]),
    .br_i(32'hFFFFA57E),
    .bi_i(32'h00005A81),
    .pr_o(ch1_poly3_real),
    .pi_o(ch1_poly3_imag)
);

cplx_mult ch1_poly4 (
    .clk_i(clk_i),
    .ar_i(channel4_data_i[63:32]),
    .ai_i(channel4_data_i[31:0]),
    .br_i(32'hFFFF8001),
    .bi_i(32'h00000000),
    .pr_o(ch1_poly4_real),
    .pi_o(ch1_poly4_imag)
);

cplx_mult ch1_poly5 (
    .clk_i(clk_i),
    .ar_i(channel5_data_i[63:32]),
    .ai_i(channel5_data_i[31:0]),
    .br_i(32'hFFFFA57E),
    .bi_i(32'hFFFFA57E),
    .pr_o(ch1_poly5_real),
    .pi_o(ch1_poly5_imag)
);

cplx_mult ch1_poly6 (
    .clk_i(clk_i),
    .ar_i(channel6_data_i[63:32]),
    .ai_i(channel6_data_i[31:0]),
    .br_i(32'hFFFFFFFF),
    .bi_i(32'hFFFF8001),
    .pr_o(ch1_poly6_real),
    .pi_o(ch1_poly6_imag)
);

cplx_mult ch1_poly7 (
    .clk_i(clk_i),
    .ar_i(channel7_data_i[63:32]),
    .ai_i(channel7_data_i[31:0]),
    .br_i(32'h00005A81),
    .bi_i(32'hFFFFA57E),
    .pr_o(ch1_poly7_real),
    .pi_o(ch1_poly7_imag)
);

//========================================
// channel2 polyphase outputs
cplx_mult ch2_poly0 (
    .clk_i(clk_i),
    .ar_i(channel0_data_i[63:32]),
    .ai_i(channel0_data_i[31:0]),
    .br_i(32'h00007FFF),
    .bi_i(32'h00000000),
    .pr_o(ch2_poly0_real),
    .pi_o(ch2_poly0_imag)
);

cplx_mult ch2_poly1 (
    .clk_i(clk_i),
    .ar_i(channel1_data_i[63:32]),
    .ai_i(channel1_data_i[31:0]),
    .br_i(32'h00000000),
    .bi_i(32'h00007FFF),
    .pr_o(ch2_poly1_real),
    .pi_o(ch2_poly1_imag)
);

cplx_mult ch2_poly2 (
    .clk_i(clk_i),
    .ar_i(channel2_data_i[63:32]),
    .ai_i(channel2_data_i[31:0]),
    .br_i(32'hFFFF8001),
    .bi_i(32'h00000000),
    .pr_o(ch2_poly2_real),
    .pi_o(ch2_poly2_imag)
);

cplx_mult ch2_poly3 (
    .clk_i(clk_i),
    .ar_i(channel3_data_i[63:32]),
    .ai_i(channel3_data_i[31:0]),
    .br_i(32'hFFFFFFFF),
    .bi_i(32'hFFFF8001),
    .pr_o(ch2_poly3_real),
    .pi_o(ch2_poly3_imag)
);

cplx_mult ch2_poly4 (
    .clk_i(clk_i),
    .ar_i(channel4_data_i[63:32]),
    .ai_i(channel4_data_i[31:0]),
    .br_i(32'h00007FFF),
    .bi_i(32'hFFFFFFFF),
    .pr_o(ch2_poly4_real),
    .pi_o(ch2_poly4_imag)
);

cplx_mult ch2_poly5 (
    .clk_i(clk_i),
    .ar_i(channel5_data_i[63:32]),
    .ai_i(channel5_data_i[31:0]),
    .br_i(32'h00000000),
    .bi_i(32'h00007FFF),
    .pr_o(ch2_poly5_real),
    .pi_o(ch2_poly5_imag)
);

cplx_mult ch2_poly6 (
    .clk_i(clk_i),
    .ar_i(channel6_data_i[63:32]),
    .ai_i(channel6_data_i[31:0]),
    .br_i(32'hFFFF8001),
    .bi_i(32'h00000000),
    .pr_o(ch2_poly6_real),
    .pi_o(ch2_poly6_imag)
);

cplx_mult ch2_poly7 (
    .clk_i(clk_i),
    .ar_i(channel7_data_i[63:32]),
    .ai_i(channel7_data_i[31:0]),
    .br_i(32'hFFFFFFFF),
    .bi_i(32'hFFFF8001),
    .pr_o(ch2_poly7_real),
    .pi_o(ch2_poly7_imag)
);

//========================================
// channel3 polyphase outputs
cplx_mult ch3_poly0 (
    .clk_i(clk_i),
    .ar_i(channel0_data_i[63:32]),
    .ai_i(channel0_data_i[31:0]),
    .br_i(32'h00007FFF),
    .bi_i(32'h00000000),
    .pr_o(ch3_poly0_real),
    .pi_o(ch3_poly0_imag)
);

cplx_mult ch3_poly1 (
    .clk_i(clk_i),
    .ar_i(channel1_data_i[63:32]),
    .ai_i(channel1_data_i[31:0]),
    .br_i(32'hFFFFA57E),
    .bi_i(32'h00005A81),
    .pr_o(ch3_poly1_real),
    .pi_o(ch3_poly1_imag)
);

cplx_mult ch3_poly2 (
    .clk_i(clk_i),
    .ar_i(channel2_data_i[63:32]),
    .ai_i(channel2_data_i[31:0]),
    .br_i(32'hFFFFFFFF),
    .bi_i(32'hFFFF8001),
    .pr_o(ch3_poly2_real),
    .pi_o(ch3_poly2_imag)
);

cplx_mult ch3_poly3 (
    .clk_i(clk_i),
    .ar_i(channel3_data_i[63:32]),
    .ai_i(channel3_data_i[31:0]),
    .br_i(32'h00005A81),
    .bi_i(32'h00005A81),
    .pr_o(ch3_poly3_real),
    .pi_o(ch3_poly3_imag)
);

cplx_mult ch3_poly4 (
    .clk_i(clk_i),
    .ar_i(channel4_data_i[63:32]),
    .ai_i(channel4_data_i[31:0]),
    .br_i(32'hFFFF8001),
    .bi_i(32'h00000000),
    .pr_o(ch3_poly4_real),
    .pi_o(ch3_poly4_imag)
);

cplx_mult ch3_poly5 (
    .clk_i(clk_i),
    .ar_i(channel5_data_i[63:32]),
    .ai_i(channel5_data_i[31:0]),
    .br_i(32'h00005A81),
    .bi_i(32'hFFFFA57E),
    .pr_o(ch3_poly5_real),
    .pi_o(ch3_poly5_imag)
);

cplx_mult ch3_poly6 (
    .clk_i(clk_i),
    .ar_i(channel6_data_i[63:32]),
    .ai_i(channel6_data_i[31:0]),
    .br_i(32'h00000000),
    .bi_i(32'h00007FFF),
    .pr_o(ch3_poly6_real),
    .pi_o(ch3_poly6_imag)
);

cplx_mult ch3_poly7 (
    .clk_i(clk_i),
    .ar_i(channel7_data_i[63:32]),
    .ai_i(channel7_data_i[31:0]),
    .br_i(32'hFFFFA57E),
    .bi_i(32'hFFFFA57E),
    .pr_o(ch3_poly7_real),
    .pi_o(ch3_poly7_imag)
);

//========================================
// channel4 polyphase outputs
cplx_mult ch4_poly0 (
    .clk_i(clk_i),
    .ar_i(channel0_data_i[63:32]),
    .ai_i(channel0_data_i[31:0]),
    .br_i(32'h00007FFF),
    .bi_i(32'h00000000),
    .pr_o(ch4_poly0_real),
    .pi_o(ch4_poly0_imag)
);

cplx_mult ch4_poly1 (
    .clk_i(clk_i),
    .ar_i(channel1_data_i[63:32]),
    .ai_i(channel1_data_i[31:0]),
    .br_i(32'hFFFF8001),
    .bi_i(32'h00000000),
    .pr_o(ch4_poly1_real),
    .pi_o(ch4_poly1_imag)
);

cplx_mult ch4_poly2 (
    .clk_i(clk_i),
    .ar_i(channel2_data_i[63:32]),
    .ai_i(channel2_data_i[31:0]),
    .br_i(32'h00007FFF),
    .bi_i(32'hFFFFFFFF),
    .pr_o(ch4_poly2_real),
    .pi_o(ch4_poly2_imag)
);

cplx_mult ch4_poly3 (
    .clk_i(clk_i),
    .ar_i(channel3_data_i[63:32]),
    .ai_i(channel3_data_i[31:0]),
    .br_i(32'hFFFF8001),
    .bi_i(32'h00000000),
    .pr_o(ch4_poly3_real),
    .pi_o(ch4_poly3_imag)
);

cplx_mult ch4_poly4 (
    .clk_i(clk_i),
    .ar_i(channel4_data_i[63:32]),
    .ai_i(channel4_data_i[31:0]),
    .br_i(32'h00007FFF),
    .bi_i(32'hFFFFFFFF),
    .pr_o(ch4_poly4_real),
    .pi_o(ch4_poly4_imag)
);

cplx_mult ch4_poly5 (
    .clk_i(clk_i),
    .ar_i(channel5_data_i[63:32]),
    .ai_i(channel5_data_i[31:0]),
    .br_i(32'hFFFF8001),
    .bi_i(32'h00000000),
    .pr_o(ch4_poly5_real),
    .pi_o(ch4_poly5_imag)
);

cplx_mult ch4_poly6 (
    .clk_i(clk_i),
    .ar_i(channel6_data_i[63:32]),
    .ai_i(channel6_data_i[31:0]),
    .br_i(32'h00007FFF),
    .bi_i(32'hFFFFFFFF),
    .pr_o(ch4_poly6_real),
    .pi_o(ch4_poly6_imag)
);

cplx_mult ch4_poly7 (
    .clk_i(clk_i),
    .ar_i(channel7_data_i[63:32]),
    .ai_i(channel7_data_i[31:0]),
    .br_i(32'hFFFF8001),
    .bi_i(32'h00000000),
    .pr_o(ch4_poly7_real),
    .pi_o(ch4_poly7_imag)
);

//========================================
// channel5 polyphase outputs
cplx_mult ch5_poly0 (
    .clk_i(clk_i),
    .ar_i(channel0_data_i[63:32]),
    .ai_i(channel0_data_i[31:0]),
    .br_i(32'h00007FFF),
    .bi_i(32'h00000000),
    .pr_o(ch5_poly0_real),
    .pi_o(ch5_poly0_imag)
);

cplx_mult ch5_poly1 (
    .clk_i(clk_i),
    .ar_i(channel1_data_i[63:32]),
    .ai_i(channel1_data_i[31:0]),
    .br_i(32'hFFFFA57E),
    .bi_i(32'hFFFFA57E),
    .pr_o(ch5_poly1_real),
    .pi_o(ch5_poly1_imag)
);

cplx_mult ch5_poly2 (
    .clk_i(clk_i),
    .ar_i(channel2_data_i[63:32]),
    .ai_i(channel2_data_i[31:0]),
    .br_i(32'h00000000),
    .bi_i(32'h00007FFF),
    .pr_o(ch5_poly2_real),
    .pi_o(ch5_poly2_imag)
);

cplx_mult ch5_poly3 (
    .clk_i(clk_i),
    .ar_i(channel3_data_i[63:32]),
    .ai_i(channel3_data_i[31:0]),
    .br_i(32'h00005A81),
    .bi_i(32'hFFFFA57E),
    .pr_o(ch5_poly3_real),
    .pi_o(ch5_poly3_imag)
);

cplx_mult ch5_poly4 (
    .clk_i(clk_i),
    .ar_i(channel4_data_i[63:32]),
    .ai_i(channel4_data_i[31:0]),
    .br_i(32'hFFFF8001),
    .bi_i(32'h00000000),
    .pr_o(ch5_poly4_real),
    .pi_o(ch5_poly4_imag)
);

cplx_mult ch5_poly5 (
    .clk_i(clk_i),
    .ar_i(channel5_data_i[63:32]),
    .ai_i(channel5_data_i[31:0]),
    .br_i(32'h00005A81),
    .bi_i(32'h00005A81),
    .pr_o(ch5_poly5_real),
    .pi_o(ch5_poly5_imag)
);

cplx_mult ch5_poly6 (
    .clk_i(clk_i),
    .ar_i(channel6_data_i[63:32]),
    .ai_i(channel6_data_i[31:0]),
    .br_i(32'hFFFFFFFF),
    .bi_i(32'hFFFF8001),
    .pr_o(ch5_poly6_real),
    .pi_o(ch5_poly6_imag)
);

cplx_mult ch5_poly7 (
    .clk_i(clk_i),
    .ar_i(channel7_data_i[63:32]),
    .ai_i(channel7_data_i[31:0]),
    .br_i(32'hFFFFA57E),
    .bi_i(32'h00005A81),
    .pr_o(ch5_poly7_real),
    .pi_o(ch5_poly7_imag)
);

//========================================
// channel6 polyphase outputs
cplx_mult ch6_poly0 (
    .clk_i(clk_i),
    .ar_i(channel0_data_i[63:32]),
    .ai_i(channel0_data_i[31:0]),
    .br_i(32'h00007FFF),
    .bi_i(32'h00000000),
    .pr_o(ch6_poly0_real),
    .pi_o(ch6_poly0_imag)
);

cplx_mult ch6_poly1 (
    .clk_i(clk_i),
    .ar_i(channel1_data_i[63:32]),
    .ai_i(channel1_data_i[31:0]),
    .br_i(32'hFFFFFFFF),
    .bi_i(32'hFFFF8001),
    .pr_o(ch6_poly1_real),
    .pi_o(ch6_poly1_imag)
);

cplx_mult ch6_poly2 (
    .clk_i(clk_i),
    .ar_i(channel2_data_i[63:32]),
    .ai_i(channel2_data_i[31:0]),
    .br_i(32'hFFFF8001),
    .bi_i(32'h00000000),
    .pr_o(ch6_poly2_real),
    .pi_o(ch6_poly2_imag)
);

cplx_mult ch6_poly3 (
    .clk_i(clk_i),
    .ar_i(channel3_data_i[63:32]),
    .ai_i(channel3_data_i[31:0]),
    .br_i(32'h00000000),
    .bi_i(32'h00007FFF),
    .pr_o(ch6_poly3_real),
    .pi_o(ch6_poly3_imag)
);

cplx_mult ch6_poly4 (
    .clk_i(clk_i),
    .ar_i(channel4_data_i[63:32]),
    .ai_i(channel4_data_i[31:0]),
    .br_i(32'h00007FFF),
    .bi_i(32'hFFFFFFFF),
    .pr_o(ch6_poly4_real),
    .pi_o(ch6_poly4_imag)
);

cplx_mult ch6_poly5 (
    .clk_i(clk_i),
    .ar_i(channel5_data_i[63:32]),
    .ai_i(channel5_data_i[31:0]),
    .br_i(32'hFFFFFFFF),
    .bi_i(32'hFFFF8001),
    .pr_o(ch6_poly5_real),
    .pi_o(ch6_poly5_imag)
);

cplx_mult ch6_poly6 (
    .clk_i(clk_i),
    .ar_i(channel6_data_i[63:32]),
    .ai_i(channel6_data_i[31:0]),
    .br_i(32'hFFFF8001),
    .bi_i(32'h00000000),
    .pr_o(ch6_poly6_real),
    .pi_o(ch6_poly6_imag)
);

cplx_mult ch6_poly7 (
    .clk_i(clk_i),
    .ar_i(channel7_data_i[63:32]),
    .ai_i(channel7_data_i[31:0]),
    .br_i(32'h00000000),
    .bi_i(32'h00007FFF),
    .pr_o(ch6_poly7_real),
    .pi_o(ch6_poly7_imag)
);

//========================================
// channel7 polyphase outputs
cplx_mult ch7_poly0 (
    .clk_i(clk_i),
    .ar_i(channel0_data_i[63:32]),
    .ai_i(channel0_data_i[31:0]),
    .br_i(32'h00007FFF),
    .bi_i(32'h00000000),
    .pr_o(ch7_poly0_real),
    .pi_o(ch7_poly0_imag)
);

cplx_mult ch7_poly1 (
    .clk_i(clk_i),
    .ar_i(channel1_data_i[63:32]),
    .ai_i(channel1_data_i[31:0]),
    .br_i(32'h00005A81),
    .bi_i(32'hFFFFA57E),
    .pr_o(ch7_poly1_real),
    .pi_o(ch7_poly1_imag)
);

cplx_mult ch7_poly2 (
    .clk_i(clk_i),
    .ar_i(channel2_data_i[63:32]),
    .ai_i(channel2_data_i[31:0]),
    .br_i(32'hFFFFFFFF),
    .bi_i(32'hFFFF8001),
    .pr_o(ch7_poly2_real),
    .pi_o(ch7_poly2_imag)
);

cplx_mult ch7_poly3 (
    .clk_i(clk_i),
    .ar_i(channel3_data_i[63:32]),
    .ai_i(channel3_data_i[31:0]),
    .br_i(32'hFFFFA57E),
    .bi_i(32'hFFFFA57E),
    .pr_o(ch7_poly3_real),
    .pi_o(ch7_poly3_imag)
);

cplx_mult ch7_poly4 (
    .clk_i(clk_i),
    .ar_i(channel4_data_i[63:32]),
    .ai_i(channel4_data_i[31:0]),
    .br_i(32'hFFFF8001),
    .bi_i(32'h00000000),
    .pr_o(ch7_poly4_real),
    .pi_o(ch7_poly4_imag)
);

cplx_mult ch7_poly5 (
    .clk_i(clk_i),
    .ar_i(channel5_data_i[63:32]),
    .ai_i(channel5_data_i[31:0]),
    .br_i(32'hFFFFA57E),
    .bi_i(32'h00005A81),
    .pr_o(ch7_poly5_real),
    .pi_o(ch7_poly5_imag)
);

cplx_mult ch7_poly6 (
    .clk_i(clk_i),
    .ar_i(channel6_data_i[63:32]),
    .ai_i(channel6_data_i[31:0]),
    .br_i(32'h00000000),
    .bi_i(32'h00007FFF),
    .pr_o(ch7_poly6_real),
    .pi_o(ch7_poly6_imag)
);

cplx_mult ch7_poly7 (
    .clk_i(clk_i),
    .ar_i(channel7_data_i[63:32]),
    .ai_i(channel7_data_i[31:0]),
    .br_i(32'h00005A81),
    .bi_i(32'h00005A81),
    .pr_o(ch7_poly7_real),
    .pi_o(ch7_poly7_imag)
);

endmodule