`timescale 1ns/1ps

module single_cic_tb();

localparam SYS_CLK_50M = 20;

logic       sys_clk;
logic       sys_rstn;
logic       en;
logic[10:0] din;
// logic                 valid ;
logic signed[21:0] dout;

//========================================
// 50MHz sys_clk generating
initial begin
     sys_clk = 1'b0 ;
    forever begin
        #SYS_CLK_50M;
        sys_clk = ~sys_clk ;
    end
end

//========================================
// reset
initial begin
    sys_rstn = 1'b0;
    #300;
    sys_rstn = 1'b1;
end

//========================================
// file
string FILEPATH = "D:/Code/Proj/filter_FPGA/CIC/matlab/single_cic";
string SIGNAL_FILENAME = "matlab_signal_bin.txt";
string SIGNAL_FILEPATH = $sformatf("%s/%s", FILEPATH, SIGNAL_FILENAME);
string AFTER_FILTER_FILENAME = "vivado_after_filter.txt";
string AFTER_FILTER_FILEPATH = $sformatf("%s/%s", FILEPATH, AFTER_FILTER_FILENAME);
integer fid;

//========================================
// read signal data into register
localparam SIM_DATA_NUM = 2000;

logic[10:0] sim_din[0:SIM_DATA_NUM];
int index;
initial begin
    din = 0;
    en = 0;
    index = 0;

    fid = $fopen(AFTER_FILTER_FILEPATH);
    $readmemb(SIGNAL_FILEPATH, sim_din);

    #500;
    en = 1;
    repeat(SIM_DATA_NUM) begin
        @(posedge sys_clk);
        din = sim_din[index];
        index ++;

        $fdisplay(fid, "%d", dout);
    end
    $fclose(fid);
    $finish;
end

single_cic DUT (
    .clk_i  (sys_clk),
    .rstn_i (sys_rstn),
    .en_i   (en),
    .data_i (din), // 11位有符号数
    .data_o (dout)
);

endmodule: single_cic_tb