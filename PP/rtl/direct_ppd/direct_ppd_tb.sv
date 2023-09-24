`timescale 1ns/1ps

module direct_ppd_tb;

logic clk, rstn;
logic start_i;
logic[10:0] signal_i;
logic[47:0] sum_o;

parameter data_num = 2000;

initial begin
    clk = 0;
    rstn = 0;
    start_i = 0;
    signal_i = 0;
    #200;
    rstn = 1;
end

initial begin
    forever begin
        #5;
        clk <= ~clk;
    end
end


logic[10:0] bin_mem[data_num];
int i = 0;
integer fid = 0;
initial begin
    $readmemb("D:/Code/Proj/ppf_FPGA/matlab/matlab_signal_bin.txt", bin_mem);

    wait(rstn);
    @(posedge clk);
    start_i <= 1;
    @(posedge clk);
    start_i <= 0;
    repeat(data_num) begin
        @(posedge clk);
        signal_i <= bin_mem[i];
        i++;
    end
end

initial begin
	fid = $fopen("D:/Code/Proj/ppf_FPGA/vivado/ppf/ppf.srcs/sim_1/new/vivado_after_ppf.txt");
    wait(rstn);
    repeat(data_num/4+20) begin
        repeat(4) @(posedge clk);
        $fdisplay(fid, "%b", sum_o);
    end
    #100;
    $fclose(fid);
    $finish;
end

direct_ppf DUT(
    .sys_clk_i (clk),
    .sys_rstn_i(rstn),
    .start_i   (start_i),
    .signal_i  (signal_i),
    .sum_o     (sum_o)
    );

endmodule: direct_ppd_tb