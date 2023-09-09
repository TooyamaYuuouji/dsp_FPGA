// 梳状器，供CIC滤波器使用
// D = 3

module comb (
    input  wire              clk_i ,
    input  wire              rstn_i,
    input  wire              en_i  ,
    input  wire signed[21:0] data_i,
    output wire signed[21:0] data_o
);

localparam D = 5;

reg signed[21:0] reg_data[0:D-1];

integer i;
always @(posedge clk_i or negedge rstn_i) begin
    if(!rstn_i) begin
        for(i = 0; i < D; i = i + 1) begin
            reg_data[i] <= 'd0;
        end
    end else if(en_i) begin
        for(i = 0; i < D-1; i = i + 1) begin
            reg_data[i+1] <= reg_data[i];
        end
        reg_data[0] <= data_i;
    end
end

assign data_o = data_i - reg_data[D-1];

endmodule