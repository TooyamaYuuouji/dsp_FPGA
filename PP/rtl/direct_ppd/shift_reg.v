// 移位寄存器

module shift_reg(
    input  wire       clk_i   ,
    input  wire       rstn_i  ,

    input  wire       start_i , // 开始信号
    input  wire[10:0] x_i     ,
    output wire       phase_en_o,
    output wire[10:0] signal_phase1_o,
    output wire[10:0] signal_phase2_o,
    output wire[10:0] signal_phase3_o,
    output wire[10:0] signal_phase4_o
);

localparam PHASE_NUM = 4;

reg[2:0] reg_cnt;
reg[10:0] reg_shift[0:PHASE_NUM - 1];

// 根据计数器的值确定是否要输出
assign phase_en_o = (reg_cnt == 'd3) ? 1'b1 : 1'b0;

// 输出每个相的信号
assign signal_phase1_o = (phase_en_o == 1'b1) ? reg_shift[0] : 'd0;
assign signal_phase2_o = (phase_en_o == 1'b1) ? reg_shift[1] : 'd0;
assign signal_phase3_o = (phase_en_o == 1'b1) ? reg_shift[2] : 'd0;
assign signal_phase4_o = (phase_en_o == 1'b1) ? reg_shift[3] : 'd0;

// reg_cnt: 计数器
always @(posedge clk_i or negedge rstn_i) begin
    if(!rstn_i)
        reg_cnt <= 'd0;
    else if(start_i)
        reg_cnt <= 'd3;
    else if(reg_cnt == 3'd3)
        reg_cnt <= 'd0;
    else
        reg_cnt <= reg_cnt + 1'b1;
end

// reg_shift: 移位寄存
integer i;
always @(posedge clk_i or negedge rstn_i) begin
    if(!rstn_i) begin
        for(i = 0; i < PHASE_NUM; i = i + 1) begin
            reg_shift[i] <= 'd0;
        end
    end else begin
        // if(start_i == 1'b1) begin
            reg_shift[0] <= x_i;
            for(i = 0; i < PHASE_NUM - 1; i = i + 1) begin
                reg_shift[i+1] <= reg_shift[i];
            end
        // end
    end
end

endmodule