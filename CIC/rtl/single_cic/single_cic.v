// 单级CIC滤波器的rtl实现
// 梳状器D=3

module single_cic(
    input  wire              clk_i  ,
    input  wire              rstn_i ,
    input  wire              en_i   ,
    input  wire signed[10:0] data_i , // 11位有符号数
    output wire signed[21:0] data_o
);

wire signed[21:0] integrator__data_o;

reg reg_dff_en;

always @(posedge clk_i) begin
    reg_dff_en <= en_i;
end

integrator integrator_inst (
    .clk_i  (clk_i),
    .rstn_i (rstn_i),
    .en_i   (en_i),
    .data_i (data_i), // 11位有符号数
    .valid_o(),
    .data_o (integrator__data_o)
);

comb comb_inst (
    .clk_i (clk_i),
    .rstn_i(rstn_i),
    .en_i  (reg_dff_en),
    .data_i(integrator__data_o),
    .data_o(data_o)
);

endmodule