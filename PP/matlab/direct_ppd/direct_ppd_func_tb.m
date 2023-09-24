% direct_ppd_func 的测试文件

clc; clear; close;

%%
% 参数定义
fs = 2000;  % 抽样频率为2000Hz
order = 19; % 滤波器阶数
f_stop = 250;   % 截止频率500Hz
wf_stop = f_stop/(fs/2); %归一化截止频率
ftype = 'low';  %滤波器类型
% 生成滤波器
h = fir1(order, wf_stop, ftype);
% 生成信号
f1 = 50;   % 信号1频率
f2 = 800;   % 信号2频率
t = 0:1/fs:(1-1/fs); % 采样时间1s
s1 = sin(2*pi*f1*t); % 信号1
s2 = sin(2*pi*f2*t); % 信号2
signal = s1 + s2;    % 合成信号
% 相数
M = 4;
% 多相滤波
p_y = direct_ppd_func(signal, h, M);
% 普通滤波加抽取
g_y = downsample(filter(h, 1, signal), M);

%% 绘图
% 分析
signal_dB = 20*log(abs(fft(signal, 2048)))/log(10); % 转为dB
signal_dB = signal_dB - max(signal_dB); % 最值归零
filter_dB = 20*log(abs(fft(h, 2048)))/log(10); % 转为dB
filter_dB = filter_dB - max(filter_dB); % 最值归零
poly_filter_dB = 20*log(abs(fft(p_y, 2048)))/log(10); % 转为dB
poly_filter_dB = poly_filter_dB - max(poly_filter_dB); % 最值归零
general_filter_dB = 20*log(abs(fft(g_y, 2048)))/log(10); % 转为dB
general_filter_dB = general_filter_dB - max(general_filter_dB); % 最值归零
% 绘图
freq_range = 0:fs/length(poly_filter_dB):fs/2;
plot(freq_range, signal_dB(1:length(freq_range)), 'k-', ...
     freq_range, poly_filter_dB(1:length(freq_range)), 'b--', ...
     freq_range, general_filter_dB(1:length(freq_range)), 'g.-', ...
     freq_range, filter_dB(1:length(freq_range)), 'r-');
xlabel('频率（Hz）'); ylabel('幅度（dB）'); title('滤波前后频谱');
legend('输入信号频谱', '多相滤波后的频谱', '一般滤波抽取后的频谱', '滤波器频谱', 'Location', 'east');
grid;

%% 输出数据
% 滤波器数据
B = 11; % 量化位数
quan_h = floor(h.*(2^(B-1)-1)); % 量化后的结果
h_hex = dec2hex(quan_h); % MATLAB的转化结果的位宽不完美，需要注意

% 信号数据
B = 11; % 量化位数
norm_signal = signal/max(abs(signal)); % 归一化处理
quan_signal = round(norm_signal.*(2^(B-1)-1)); % 量化
fid = fopen('D:\Code\Proj\ppf_FPGA\matlab\matlab_signal_bin.txt','w');
for i = 1:length(quan_signal)
    signal_bin = dec2bin(quan_signal(i), B);
    fprintf(fid, '%s', signal_bin);
    fprintf(fid, '\r\n');
end
fclose(fid);

% 滤波后数据
fid = fopen('D:\Code\Proj\ppf_FPGA\matlab\matlab_after_filter_dec.txt','w');
for i = 1:length(y)
    fprintf(fid, '%d', y(i));
    fprintf(fid, '\r\n');
end
fclose(fid);