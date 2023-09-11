`timescale 1ns / 1ps

module serial_fir_temp_tb;

logic clk, rstn;
logic en_i;
logic[11:0] din;
logic signed[26:0] dout;

//========================================
// clk generating
initial begin
    forever begin
        #5;
        clk <= ~clk;
    end
end

//========================================
// reset
initial begin
    clk = 0;
    rstn = 0;
    din = 0;
    en_i = 0;
    #200;
    rstn = 1;
end

//========================================
// file
string FILEPATH = "D:/Code/Proj/filter_FPGA/FIR/matlab/serial_fir";
string SIGNAL_FILENAME = "matlab_signal_bin.txt";
string SIGNAL_FILEPATH = $sformatf("%s/%s", FILEPATH, SIGNAL_FILENAME);
string AFTER_FILTER_FILENAME = "vivado_after_filter.txt";
string AFTER_FILTER_FILEPATH = $sformatf("%s/%s", FILEPATH, AFTER_FILTER_FILENAME);
integer fid;

//========================================
// read signal data into register
parameter SIM_DATA_NUM = 2000;

logic[11:0] sim_din[0:SIM_DATA_NUM];
int index = 0;
initial begin
	fid = $fopen(AFTER_FILTER_FILEPATH);
    $readmemb(SIGNAL_FILEPATH, sim_din);

    wait(rstn);
    repeat(SIM_DATA_NUM) begin
        @(posedge clk);
        en_i <= 1;
        din <= sim_din[index];
        index++;
        for(int index = 0; index < 15; index ++) begin
            @(posedge clk);
            en_i <= 0;
        end

        $fdisplay(fid, "%d", dout);
    end
    repeat(20) begin
        @(posedge clk);
        $fdisplay(fid, "%d", dout);
    end
    #100;
    $fclose(fid);
    $finish;
end

serial_fir_temp DUT(
    .clk_i     (clk),
    .rstn_i    (rstn),
    .enable_i  (en_i),
    .data_i    (din),
    .data_o    (dout)
);

endmodule: serial_fir_temp_tb
