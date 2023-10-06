// 分频器，用于fir滤波等操作

module freq_divider #(
    parameter DIV_RATIO = 8
) (
    input  wire clk_i    ,
    input  wire rstn_i   ,
    output reg  div_clk_o
);

reg[9:0] reg_cnt; // 分频用计数器

// 计数器计数
always @(posedge clk_i or negedge rstn_i) begin
    if(~rstn_i) begin
        reg_cnt <= 'd0;
    end else begin
        if(reg_cnt == DIV_RATIO - 1) begin
            reg_cnt <= 'd0;
        end else begin
            reg_cnt <= reg_cnt + 1'b1;
        end
    end
end

always @(posedge clk_i or negedge rstn_i) begin
    if(~rstn_i) begin
        div_clk_o <= 'd0;
    end else begin
        if(reg_cnt == DIV_RATIO - 1) begin
            div_clk_o <= ~div_clk_o;
        end
    end
end

endmodule