clc; clear; close;

%% 读取数据
file_path = 'D:\Code\Proj\filter_FPGA\CIC\matlab\single_cic\'; % 存放数据文件的路径（MATLAB）
after_filter_filename = 'matlab_after_filter_dec.txt'; % 存放滤波后信号的文件名（MATLAB）
fid = fopen([file_path, after_filter_filename], 'r');
scan_data1 = textscan(fid, '%s');
fclose(fid);

file_path = 'D:\Code\Proj\filter_FPGA\CIC\matlab\single_cic\'; % 存放数据文件的路径（Vivado）
after_filter_filename = 'vivado_after_filter.txt'; % 存放滤波后信号的文件名（Vivado）
fid = fopen([file_path, after_filter_filename], 'r');
scan_data2 = textscan(fid, '%s');
fclose(fid);

data = scan_data1{1};
matlab_after_filter = str2double(data);

data = scan_data2{1};
vivado_after_filter = str2double(data);

%% 绘图
% 定义变量
fs = 2000; % 采样率
% 转换
matlab_after_filter_dB = 20*log(abs(fft(matlab_after_filter, 2048)))/log(10); % 转为dB
matlab_after_filter_dB = matlab_after_filter_dB - max(matlab_after_filter_dB); % 最值归零
vivado_after_filter_dB = 20*log(abs(fft(vivado_after_filter, 2048)))/log(10); % 转为dB
vivado_after_filter_dB = vivado_after_filter_dB - max(vivado_after_filter_dB); % 最值归零
% 绘图
figure('NAME', '时域波形');
subplot(2,1,1); plot(matlab_after_filter); title('MATLAB中滤波后信号的时域波形');
subplot(2,1,2); plot(vivado_after_filter); title('Vivado中滤波后信号的时域波形');
figure('NAME', '频域波形');
freq_range = 0:fs/length(matlab_after_filter_dB):fs/2;
plot(freq_range, matlab_after_filter_dB(1:length(freq_range)), 'r-', ...
     freq_range, vivado_after_filter_dB(1:length(freq_range)), 'b--');
xlabel('频率（Hz）'); ylabel('幅度（dB）'); title('滤波后频谱');
legend('MATLAB中滤波后的频谱', 'Vivado中滤波后的频谱', 'Location', 'east');
grid;