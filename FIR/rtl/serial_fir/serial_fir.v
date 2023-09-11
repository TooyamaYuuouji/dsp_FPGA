// 移位滤波器
// 移位寄存器模块：shift_reg.v
// 累加器模块：accum_adder.v
// 乘法器模块：Multiplier（12.0）IP核
// 选通信号等部分的波形待优化

module serial_fir(
    input  wire       clk_i ,
    input  wire       rstn_i,
    input  wire       enable_i,
    input  wire[11:0] data_i,
    output wire[26:0] data_o   
);

wire signed[11:0] shift_reg_data_o;
wire signed[22:0] after_multi;

reg reg_bypass;
reg[3:0] reg_addr;
reg[10:0] reg_h_coeff[0:15]; // 滤波器系数

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

// reg_addr: 地址计数器
always @(posedge clk_i or negedge rstn_i) begin
    if(!rstn_i) begin
        reg_addr <= 4'd0;
    end else begin
        if(enable_i) begin
            reg_addr <= 4'd0;
        end else begin
            if(reg_addr == 4'd15) begin
                reg_addr <= 4'd0;
            end else begin
                reg_addr <= reg_addr + 1'b1;
            end
        end
    end
end

// reg_bypass: 选通信号
always @(posedge clk_i or negedge rstn_i) begin
    if(!rstn_i) begin
        reg_bypass <= 1'b0;
    end else begin
        if(enable_i) begin
            reg_bypass <= 1'b1;
        end else begin
            reg_bypass <= 1'b0;
        end
    end
end

//------------------------------
// 例化
//------------------------------
shift_reg shift_reg_inst (
    .clk_i  (clk_i),
    .rstn_i (rstn_i),
    .en_i   (enable_i),
    .data_i (data_i),
    .addr_i (reg_addr),
    .data_o (shift_reg_data_o)
);

mult_gen_0 mult_inst (
  .CLK(clk_i),  // input wire CLK
  .A(reg_h_coeff[reg_addr]),      // input wire [10 : 0] A
  .B(shift_reg_data_o),      // input wire [11 : 0] B
  .P(after_multi)      // output wire [22 : 0] P
);

accumulator accumulator_inst (
    .clk_i    (clk_i),
    .data_i   (after_multi),
    .bypass_i (reg_bypass),
    .capture_i(reg_bypass),
    .data_o   (data_o)
);


endmodule