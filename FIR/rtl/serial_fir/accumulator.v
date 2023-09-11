// 16个数的顺序累加器
// 求和结果的位宽计算公式：w=ceil(B+log2L)

module accumulator (
    input  wire              clk_i    ,
    input  wire signed[22:0] data_i   ,
    input  wire              bypass_i ,
    input  wire              capture_i,
    output reg signed[26:0]  data_o   
);

wire signed[26:0] sum_data;

always @(posedge clk_i) begin
    if(capture_i)
        data_o <= sum_data;
    else
        data_o <= data_o;
end

//------------------------------
// 例化
//------------------------------
// 加法器IP核
c_addsub_0 add_inst (
  .A(sum_data),            // input wire [26 : 0] A
  .B(data_i),            // input wire [22 : 0] B
  .CLK(clk_i),        // input wire CLK
  .BYPASS(bypass_i),  // input wire BYPASS
  .S(sum_data)            // output wire [26 : 0] S
);

endmodule