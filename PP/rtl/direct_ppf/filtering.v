
// fir 滤波器
// 全并行转置结构，输出结果延后输入信号一个时钟周期

module filtering #(
    parameter DIN_WIDTH   = 16,
    parameter COEFF_FILE  = "", // 滤波器系数文件的路径
    parameter COEFF_WIDTH = 16, // 滤波器系数宽度
    parameter COEFF_NUM   = 4, // 滤波器系数个数
    parameter DOUT_WIDTH  = 32
)(
    input  wire                        clk_i       ,
    input  wire                        rstn_i      ,
    input  wire                        data_valid_i,
    input  wire signed[DIN_WIDTH-1:0]  data_real_i ,
    input  wire signed[DIN_WIDTH-1:0]  data_imag_i ,

    output wire signed[DOUT_WIDTH-1:0] data_real_o ,
    output wire signed[DOUT_WIDTH-1:0] data_imag_o
);

localparam P_WIDTH = DIN_WIDTH + COEFF_WIDTH;

reg[clogb2(COEFF_NUM)-1:0] reg_coeff_index;
reg[COEFF_WIDTH-1:0] reg_coeff_vector[COEFF_NUM-1:0];

wire signed[P_WIDTH-1:0] data_real;
wire signed[P_WIDTH-1:0] data_imag;

assign data_real_o = data_real;
assign data_imag_o = data_imag;

function integer clogb2(input integer depth);
    for(clogb2 = 0; depth > 0; clogb2 = clogb2 + 1)
        depth = depth >> 1;
endfunction

// reg_coeff_index: 滤波器系数下标自增
always @(posedge clk_i) begin
    if(~rstn_i) begin
        reg_coeff_index <= 1'b0;
    end else if(data_valid_i) begin
        if(reg_coeff_index == COEFF_NUM - 1)
            reg_coeff_index <= 'd0;
        else
            reg_coeff_index <= reg_coeff_index + 1'b1;
    end else begin
        reg_coeff_index <= 1'b0;
    end
end

// 初始化滤波器系数
integer ii;
initial begin
    if(COEFF_FILE != "") begin
        $readmemh(COEFF_FILE, reg_coeff_vector, 0, COEFF_NUM-1);
    end else begin
        for(ii = 0; ii < COEFF_NUM; ii = ii + 1) begin
            reg_coeff_vector[ii] = 'd0;
        end
    end
end

// 实部卷积
genvar var0;
generate
    wire[P_WIDTH-1:0] pr[COEFF_NUM:0];
    assign pr[0] = 'd0;
    for(var0 = 0; var0 < COEFF_NUM; var0 = var0 + 1) begin
        mult_add #(
            .AWIDTH    (DIN_WIDTH),
            .BWIDTH    (COEFF_WIDTH),
            .PIN_WIDTH (P_WIDTH),
            .POUT_WIDTH(P_WIDTH)
        ) mult_add_inst(
            .clk_i (clk_i),
            .rstn_i(rstn_i),
            .a_in  (data_real_i),
            .b_in  (reg_coeff_vector[COEFF_NUM - 1 - var0]),
            .p_in  (pr[var0]),
            .p_out (pr[var0 + 1])
        );
    end
    assign data_real = pr[COEFF_NUM];
endgenerate

// 虚部卷积
genvar var1;
generate
    wire[P_WIDTH-1:0] pi[COEFF_NUM:0];
    assign pi[0] = 'd0;
    for(var1 = 0; var1 < COEFF_NUM; var1 = var1 + 1) begin
        mult_add #(
            .AWIDTH    (DIN_WIDTH),
            .BWIDTH    (COEFF_WIDTH),
            .PIN_WIDTH (P_WIDTH),
            .POUT_WIDTH(P_WIDTH)
        ) mult_add_inst(
            .clk_i (clk_i),
            .rstn_i(rstn_i),
            .a_in  (data_imag_i),
            .b_in  (reg_coeff_vector[COEFF_NUM - 1 - var1]),
            .p_in  (pi[var1]),
            .p_out (pi[var1 + 1])
        );
    end
    assign data_imag = pi[COEFF_NUM];
endgenerate

endmodule