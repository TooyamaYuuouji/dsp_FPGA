
// 有符号复数的乘法器

module cplx_mult (
    input  wire              clk_i,
    input  wire signed[31:0] ar_i,
    input  wire signed[31:0] ai_i,
    input  wire signed[31:0] br_i,
    input  wire signed[31:0] bi_i,
    output wire signed[31:0] pr_o,
    output wire signed[31:0] pi_o
);

reg[63:0] real_result;
reg[63:0] imag_result;

always @(posedge clk_i) begin
    real_result <= ar_i * br_i - ai_i * bi_i;
    imag_result <= ai_i * br_i + ar_i * bi_i;
end

assign pr_o = real_result >> 31;
assign pi_o = imag_result >> 31;

endmodule