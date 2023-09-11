`timescale 1ns / 1ps


module serial_fir_temp (
    input  wire               clk_i   ,
    input  wire               rstn_i  ,

    input  wire               enable_i,
    input  wire signed[11:0]  data_i  ,
    output wire signed[26:0]  data_o
);

reg[10:0] reg_h_coeff[0:15]; // 滤波器系数
reg signed[11:0] reg_x_i[0:15]; // 五个输入信号寄存器
wire signed[22:0] mult_result[0:15]; // 乘法结果

// 初始化滤波器系数
initial begin
    reg_h_coeff[0]  = 11'h001;
    reg_h_coeff[1]  = 11'h004;
    reg_h_coeff[2]  = 11'h00E;
    reg_h_coeff[3]  = 11'h023;
    reg_h_coeff[4]  = 11'h042;
    reg_h_coeff[5]  = 11'h066;
    reg_h_coeff[6]  = 11'h087;
    reg_h_coeff[7]  = 11'h09A;
    reg_h_coeff[8]  = 11'h09A;
    reg_h_coeff[9]  = 11'h087;
    reg_h_coeff[10] = 11'h066;
    reg_h_coeff[11] = 11'h042;
    reg_h_coeff[12] = 11'h023;
    reg_h_coeff[13] = 11'h00E;
    reg_h_coeff[14] = 11'h004;
    reg_h_coeff[15] = 11'h001;
end

// reg_x_i: 将输入信号按照类fifo的方式进行寄存
integer i;
always @(posedge clk_i or negedge rstn_i) begin
    if(!rstn_i) begin
        for(i = 0; i < 16; i = i + 1) begin
            reg_x_i[i] <= 'd0;
        end
    end else begin
        for(i = 0; i < 15; i = i + 1) begin
            reg_x_i[i+1] <= reg_x_i[i];
        end
        if(en_i)
            reg_x_i[0] <= data_i;
        else
            reg_x_i[0] <= 'd0;
    end
end

// 计算乘法结果
genvar gi;
generate
    for(gi = 0; gi < 16; gi = gi + 1) begin
        mult_gen_0 mult_gen_inst (
            .CLK(clk_i),  // input wire CLK
            .A(reg_h_coeff[gi]),      // input wire [10 : 0] A
            .B(reg_x_i[gi]),      // input wire [11 : 0] B
            .P(mult_result[gi])      // output wire [22 : 0] P
        );
    end
endgenerate

// 求和
assign data_o = mult_result[0] + mult_result[1] + mult_result[2] + mult_result[3] +
             mult_result[4] + mult_result[5] + mult_result[6] + mult_result[7] +
             mult_result[8] + mult_result[9] + mult_result[10] + mult_result[11] +
             mult_result[12] + mult_result[13] + mult_result[14] + mult_result[15];

endmodule
