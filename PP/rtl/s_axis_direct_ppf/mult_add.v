
// 卷积器，相乘后累加
// p_out = p_in + a_in * b_in

module mult_add #(
    parameter AWIDTH     = 16,
    parameter BWIDTH     = 16,
    parameter PIN_WIDTH  = 32,
    parameter POUT_WIDTH = 33 
)(
    input  wire                        clk_i,
    input  wire                        rstn_i,
    input  wire signed[AWIDTH-1:0]     a_in,
    input  wire signed[BWIDTH-1:0]     b_in,
    input  wire signed[PIN_WIDTH-1:0]  p_in,
    output wire signed[POUT_WIDTH-1:0] p_out
);

reg signed[POUT_WIDTH-1:0] p_out_r;

always @(posedge clk_i) begin
    if(~rstn_i) begin
        p_out_r <= 0;
    end else begin
        p_out_r <= a_in * b_in + p_in; 
    end
end

assign p_out = p_out_r;

endmodule

// 例化模板
/* 
mult_add #(
    .AWIDTH    (),
    .BWIDTH    (),
    .PIN_WIDTH (),
    .POUT_WIDTH()
) your_instance_name(
    .clk_i (),
    .rstn_i(),
    .a_in  (),
    .b_in  (),
    .p_in  (),
    .p_out ()
);
*/
