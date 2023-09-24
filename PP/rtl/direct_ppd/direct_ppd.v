`timescale 1ns / 1ps

module direct_ppd (
    input  wire       sys_clk_i ,
    input  wire       sys_rstn_i,

    input  wire       start_i   ,
    input  wire[10:0] signal_i  ,
    output wire[47:0] sum_o
    );

wire shift_reg__phase_en_o;
wire[10:0] shift_reg__signal_phase1_o;
wire[10:0] shift_reg__signal_phase2_o;
wire[10:0] shift_reg__signal_phase3_o;
wire[10:0] shift_reg__signal_phase4_o;
wire[10:0] filter_coeff__filter_phase1_o;
wire[10:0] filter_coeff__filter_phase2_o;
wire[10:0] filter_coeff__filter_phase3_o;
wire[10:0] filter_coeff__filter_phase4_o;
wire[47:0] P1;
wire[10:0] A1;
wire[10:0] B1;
wire[47:0] P2;
wire[10:0] A2;
wire[10:0] B2;
wire[47:0] P3;
wire[10:0] A3;
wire[10:0] B3;
wire[47:0] P4;
wire[10:0] A4;
wire[10:0] B4;

wire[47:0] P;

assign A1 = shift_reg__phase_en_o == 1'b1 ? shift_reg__signal_phase1_o : 'd0;
assign B1 = shift_reg__phase_en_o == 1'b1 ? filter_coeff__filter_phase1_o : 'd0;
assign A2 = shift_reg__phase_en_o == 1'b1 ? shift_reg__signal_phase2_o : 'd0;
assign B2 = shift_reg__phase_en_o == 1'b1 ? filter_coeff__filter_phase2_o : 'd0;
assign A3 = shift_reg__phase_en_o == 1'b1 ? shift_reg__signal_phase3_o : 'd0;
assign B3 = shift_reg__phase_en_o == 1'b1 ? filter_coeff__filter_phase3_o : 'd0;
assign A4 = shift_reg__phase_en_o == 1'b1 ? shift_reg__signal_phase4_o : 'd0;
assign B4 = shift_reg__phase_en_o == 1'b1 ? filter_coeff__filter_phase4_o : 'd0;

assign P = P1 + P2 + P3 + P4;

assign sum_o = P;

shift_reg shift_reg_inst(
    .clk_i  (sys_clk_i),
    .rstn_i (sys_rstn_i),
    // .start_i(start_i),
    .start_i   (start_i),
    .x_i    (signal_i),
    .phase_en_o(shift_reg__phase_en_o),
    .signal_phase1_o(shift_reg__signal_phase1_o),
    .signal_phase2_o(shift_reg__signal_phase2_o),
    .signal_phase3_o(shift_reg__signal_phase3_o),
    .signal_phase4_o(shift_reg__signal_phase4_o)
);

filter_coeff filter_coeff_inst(
    .clk_i          (sys_clk_i),
    .rstn_i         (sys_rstn_i),
    .start_i        (start_i),
    .change_i       (shift_reg__phase_en_o),
    .filter_phase1_o(filter_coeff__filter_phase1_o),
    .filter_phase2_o(filter_coeff__filter_phase2_o),
    .filter_phase3_o(filter_coeff__filter_phase3_o),
    .filter_phase4_o(filter_coeff__filter_phase4_o)
);

dsp_macro_0 phase1_conv (
  .CLK(sys_clk_i),  // input wire CLK
  .A(A4),      // input wire [10 : 0] A
  .B(B1),      // input wire [10 : 0] B
  .P(P1)      // output wire [47 : 0] P
);

dsp_macro_0 phase2_conv (
  .CLK(sys_clk_i),  // input wire CLK
  .A(A3),      // input wire [10 : 0] A
  .B(B2),      // input wire [10 : 0] B
  .P(P2)      // output wire [47 : 0] P
);

dsp_macro_0 phase3_conv (
  .CLK(sys_clk_i),  // input wire CLK
  .A(A2),      // input wire [10 : 0] A
  .B(B3),      // input wire [10 : 0] B
  .P(P3)      // output wire [47 : 0] P
);

dsp_macro_0 phase4_conv (
  .CLK(sys_clk_i),  // input wire CLK
  .A(A1),      // input wire [10 : 0] A
  .B(B4),      // input wire [10 : 0] B
  .P(P4)      // output wire [47 : 0] P
);

endmodule
