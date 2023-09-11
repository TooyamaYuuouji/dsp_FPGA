// 带数据选择器的移位寄存器

module shift_reg(
    input  wire       clk_i ,
    input  wire       rstn_i,
    input  wire       en_i  ,
    input  wire[11:0] data_i,
    input  wire[3:0]  addr_i,
    output reg[11:0]  data_o
);

reg[11:0] reg_data_i[0:15]; // 十六个输入信号寄存器

// reg_data_i: 移位寄存器存储输入数据
integer i;
always @(posedge clk_i) begin
    if(!rstn_i) begin
        for(i = 0; i < 15; i = i + 1) begin
            reg_data_i[i] <= 'd0;
        end
    end else begin
        if(en_i) begin
            for(i = 0; i < 15; i = i + 1) begin
                reg_data_i[i+1] <= reg_data_i[i];
            end
            reg_data_i[0] <= data_i;
        end
    end
end
    

// 根据地址信号输出数据
always @(*) begin
    case(addr_i)
        4'd0    : data_o <= reg_data_i[0];
        4'd1    : data_o <= reg_data_i[1];
        4'd2    : data_o <= reg_data_i[2];
        4'd3    : data_o <= reg_data_i[3];
        4'd4    : data_o <= reg_data_i[4];
        4'd5    : data_o <= reg_data_i[5];
        4'd6    : data_o <= reg_data_i[6];
        4'd7    : data_o <= reg_data_i[7];
        4'd8    : data_o <= reg_data_i[8];
        4'd9    : data_o <= reg_data_i[9];
        4'd10   : data_o <= reg_data_i[10];
        4'd11   : data_o <= reg_data_i[11];
        4'd12   : data_o <= reg_data_i[12];
        4'd13   : data_o <= reg_data_i[13];
        4'd14   : data_o <= reg_data_i[14];
        4'd15   : data_o <= reg_data_i[15];
        default : data_o <= 'd0;
    endcase
end

endmodule