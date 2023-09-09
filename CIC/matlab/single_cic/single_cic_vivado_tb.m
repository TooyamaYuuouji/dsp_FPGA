% 长度为5的CIC滤波器，归一化频率为0.4时频响很低

clc; clear; close;

%% 测试信号生成
fs = 2000; % 采样率
f1 = 200;   % 信号1频率
f2 = 400;   % 信号2频率
t = 0:1/fs:1; % 采样时长为1s

% 生成信号
s1 = sin(2*pi*f1*t);
s2 = sin(2*pi*f2*t);
norm_signal = s1 + s2;

%% 滤波和绘图
% 滤波
after_filter = single_cic_func(5, norm_signal);
% 分析
signal_dB = 20*log(abs(fft(norm_signal,2048)))/log(10); % 转为dB
signal_dB = signal_dB - max(signal_dB); % 最值归零
after_filter_dB = 20*log(abs(fft(after_filter,2048)))/log(10); % 转为dB
after_filter_dB = after_filter_dB - max(after_filter_dB); % 最值归零
% 绘图
freq_range = 0:fs/length(after_filter_dB):fs/2;
plot(freq_range, signal_dB(1:length(freq_range)), 'k-', ...
     freq_range, after_filter_dB(1:length(freq_range)), 'r--');
xlabel('频率（Hz）'); ylabel('幅度（dB）'); title('滤波前后频谱');
legend('输入信号频谱','滤波后的频谱', 'Location', 'east');
grid;

%% 数据写入txt文档
% 原始信号数据
file_path = 'D:\Code\Proj\filter_FPGA\CIC\matlab\single_cic\'; % 存放数据文件的路径
signal_filename = 'matlab_signal_bin.txt'; % 存放原始信号的文件名
after_filter_filename = 'matlab_after_filter_dec.txt'; % 存放滤波后信号的文件名
fid = fopen([file_path, signal_filename], 'w');
N = 11; % 量化位数为12
norm_signal = norm_signal/max(abs(norm_signal)); % 归一化处理
quan_signal = round(norm_signal.*(2^(N-1)-1)); % 量化
for i = 1:length(quan_signal)
    signal_bin = dec2bin(quan_signal(i), N);
    fprintf(fid, '%s', signal_bin);
    fprintf(fid, '\r\n');
end
fclose(fid);

% 滤波后数据
fid = fopen([file_path, after_filter_filename], 'w');
for i = 1:length(after_filter)
    fprintf(fid, '%d', after_filter(i));
    fprintf(fid, '\r\n');
end
fclose(fid);