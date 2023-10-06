// axi-stream接口处理模块，该模块对于axis而言属于slave
// 输入数据由实部和虚部组成，其中前半部分为实部，后半部分为虚部
// 输出八路数据，相当于对输入数据进行八相分解

module s_axis_wrapper #(
    parameter TDATA_WIDTH = 32
) (
// axi-stream 接口
    input  wire                  ACLK       , // axis时钟
    input  wire                  ARESETn    , // axis全局复位，低电平有效
    input  wire[TDATA_WIDTH-1:0] TDATA      , // 传入数据，前半部分为实部，后半部分为虚部
    input  wire                  TVALID     , // 数据有效
    input  wire                  TLAST      , // 最后一个数据
    output wire                  TREADY     , // 准备接收数据
// 八相分解后的输出
    output reg                   ch0_valid_o,
    output reg[TDATA_WIDTH-1:0]  ch0_o      , // channel-0 的数据，前半部分为实部，后半部分为虚部
    output reg                   ch1_valid_o,
    output reg[TDATA_WIDTH-1:0]  ch1_o      , // channel-1 的数据，前半部分为实部，后半部分为虚部
    output reg                   ch2_valid_o,
    output reg[TDATA_WIDTH-1:0]  ch2_o      , // channel-2 的数据，前半部分为实部，后半部分为虚部
    output reg                   ch3_valid_o,
    output reg[TDATA_WIDTH-1:0]  ch3_o      , // channel-3 的数据，前半部分为实部，后半部分为虚部
    output reg                   ch4_valid_o,
    output reg[TDATA_WIDTH-1:0]  ch4_o      , // channel-4 的数据，前半部分为实部，后半部分为虚部
    output reg                   ch5_valid_o,
    output reg[TDATA_WIDTH-1:0]  ch5_o      , // channel-5 的数据，前半部分为实部，后半部分为虚部
    output reg                   ch6_valid_o,
    output reg[TDATA_WIDTH-1:0]  ch6_o      , // channel-6 的数据，前半部分为实部，后半部分为虚部
    output reg                   ch7_valid_o,
    output reg[TDATA_WIDTH-1:0]  ch7_o        // channel-7 的数据，前半部分为实部，后半部分为虚部
);

reg[2:0] reg_ch_index; // 信道选择寄存器
reg[TDATA_WIDTH-1:0] reg_data; // 数据存储寄存器
reg reg_dout_valid; // 输出有效寄存器

// reg_dout_valid: 根据TVALID决定输出是否有效
always @(posedge ACLK or negedge ARESETn) begin
    if(~ARESETn) begin
        reg_dout_valid <= 'd0;
    end else begin
        if(TVALID) begin
            reg_dout_valid <= 1'b1;
        end
    end
end

// 依次对有效信号进行打拍
// valid_o设定为reg类型，暗含了一次打拍操作，否则需要多个延时寄存器
always @(posedge ACLK or negedge ARESETn) begin
    if(~ARESETn) begin
        ch0_valid_o <= 'd0;
        ch1_valid_o <= 'd0;
        ch2_valid_o <= 'd0;
        ch3_valid_o <= 'd0;
        ch4_valid_o <= 'd0;
        ch5_valid_o <= 'd0;
        ch6_valid_o <= 'd0;
        ch7_valid_o <= 'd0;
    end else begin
        ch0_valid_o <= reg_dout_valid;
        ch1_valid_o <= ch0_valid_o;
        ch2_valid_o <= ch1_valid_o;
        ch3_valid_o <= ch2_valid_o;
        ch4_valid_o <= ch3_valid_o;
        ch5_valid_o <= ch4_valid_o;
        ch6_valid_o <= ch5_valid_o;
        ch7_valid_o <= ch6_valid_o;
    end
end

// reg_data: 暂存输入数据
always @(posedge ACLK or negedge ARESETn) begin
    if(~ARESETn) begin
        reg_data <= 'd0;
    end else begin
        if(TVALID) begin
            reg_data <= TDATA;
        end
    end
end

// reg_ch_index: 根据该寄存器的值选择哪个信号进行输出
// 注：由于 reg_data 会打一拍，让计数器默认最大值，溢出过程就会抵消 reg_data 打一拍的效果
always @(posedge ACLK or negedge ARESETn) begin
    if(~ARESETn) begin
        reg_ch_index <= 'b111;
    end else begin
        if(TVALID) begin
            reg_ch_index <= reg_ch_index + 1'b1;
        end
    end
end

// 根据 reg_ch_index 的值确定将数据传到哪个信道上，默认为 channel-0
always @(posedge ACLK or negedge ARESETn) begin
    if(~ARESETn) begin
        ch0_o <= 'd0;
        ch1_o <= 'd0;
        ch2_o <= 'd0;
        ch3_o <= 'd0;
        ch4_o <= 'd0;
        ch5_o <= 'd0;
        ch6_o <= 'd0;
        ch7_o <= 'd0;
    end else begin
        case(reg_ch_index)
            3'b000  : ch0_o <= reg_data;
            3'b001  : ch1_o <= reg_data;
            3'b010  : ch2_o <= reg_data;
            3'b011  : ch3_o <= reg_data;
            3'b100  : ch4_o <= reg_data;
            3'b101  : ch5_o <= reg_data;
            3'b110  : ch6_o <= reg_data;
            3'b111  : ch7_o <= reg_data;
            default : ch0_o <= reg_data;
        endcase
    end
end

endmodule