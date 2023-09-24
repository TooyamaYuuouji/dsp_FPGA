// 滤波器系数输出

module filter_coeff(
    input  wire       clk_i          ,
    input  wire       rstn_i         ,

    input  wire       start_i        ,
    input  wire       change_i       ,
    output wire[10:0] filter_phase1_o,
    output wire[10:0] filter_phase2_o,
    output wire[10:0] filter_phase3_o,
    output wire[10:0] filter_phase4_o
);

reg[10:0] reg_filter[0:19];
reg[2:0] reg_cnt;

assign filter_phase1_o = reg_filter[0+reg_cnt*4];
assign filter_phase2_o = reg_filter[1+reg_cnt*4];
assign filter_phase3_o = reg_filter[2+reg_cnt*4];
assign filter_phase4_o = reg_filter[3+reg_cnt*4];

// reg_cnt: 滤波器选择计数器
always @(posedge clk_i or negedge rstn_i) begin
    if(!rstn_i)
        reg_cnt <= 'd0;
    else if(start_i)
        reg_cnt <= 'd0;
    else if((reg_cnt == 3'd4) && (change_i))
        reg_cnt <= 'd0;
    else if(change_i)
        reg_cnt <= reg_cnt + 1'b1;
end

// reg_filter: 初始化滤波器系数
initial begin
    reg_filter[0]   = 11'h003;
    reg_filter[1]   = 11'h002;
    reg_filter[2]   = 11'hFFD;
    reg_filter[3]   = 11'hFF3;
    reg_filter[4]   = 11'hFE9;
    reg_filter[5]   = 11'hFF0;
    reg_filter[6]   = 11'h01A;
    reg_filter[7]   = 11'h066;
    reg_filter[8]   = 11'h0BD;
    reg_filter[9]   = 11'h0F7;
    reg_filter[10]  = 11'h0F7;
    reg_filter[11]  = 11'h0BD;
    reg_filter[12]  = 11'h066;
    reg_filter[13]  = 11'h01A;
    reg_filter[14]  = 11'hFF0;
    reg_filter[15]  = 11'hFE9;
    reg_filter[16]  = 11'hFF3;
    reg_filter[17]  = 11'hFFD;
    reg_filter[18]  = 11'h002;
    reg_filter[19]  = 11'h003;
end

endmodule