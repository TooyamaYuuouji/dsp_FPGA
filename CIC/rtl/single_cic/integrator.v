// 积分器，供CIC滤波器使用

module integrator (
    input  wire              clk_i  ,
    input  wire              rstn_i ,
    input  wire              en_i   ,
    input  wire signed[10:0] data_i , // 11位有符号数
    output wire              valid_o,
    output wire signed[21:0] data_o
);

wire signed[21:0] sxt_data = {{(22-11){data_i[10]}}, data_i}; // symbol extension，符号位扩展

reg signed[21:0] reg_data0;

always @(posedge clk_i or negedge rstn_i) begin
    if(!rstn_i) begin
        reg_data0 <= 'd0;
    end else if(en_i) begin
        reg_data0 <= reg_data0 + sxt_data;
    end
end

assign data_o = reg_data0;

endmodule