% serial_fir_func 的测试文件

clc; clear; close;

%%
% 参数定义
fs = 2000;  % 抽样频率为2000Hz
order = 15; % 滤波器阶数
f_stop = 500;   % 截止频率500Hz
wf_stop = f_stop/(fs/2); %归一化截止频率
ftype = 'low';  %滤波器类型
% 生成滤波器
h = fir1(order, wf_stop, ftype);
% 生成信号
f1 = 200;   % 信号1频率
f2 = 800;   % 信号2频率
t = 0:1/fs:1; % 采样时间1s
s1 = sin(2*pi*f1*t); % 信号1
s2 = sin(2*pi*f2*t); % 信号2
signal = s1 + s2;    % 合成信号

%% 滤波和绘图
% 滤波
after_filter = serial_fir_func(signal, h);
% 分析
signal_dB = 20*log(abs(fft(signal, 2048)))/log(10); % 转为dB
signal_dB = signal_dB - max(signal_dB); % 最值归零
filter_dB = 20*log(abs(fft(h, 2048)))/log(10); % 转为dB
filter_dB = filter_dB - max(filter_dB); % 最值归零
after_filter_dB = 20*log(abs(fft(after_filter, 2048)))/log(10); % 转为dB
after_filter_dB = after_filter_dB - max(after_filter_dB); % 最值归零
% 绘图
freq_range = 0:fs/length(after_filter_dB):fs/2;
plot(freq_range, signal_dB(1:length(freq_range)), 'k-', ...
     freq_range, after_filter_dB(1:length(freq_range)), 'b--', ...
     freq_range, filter_dB(1:length(freq_range)), 'r-');
xlabel('频率（Hz）'); ylabel('幅度（dB）'); title('滤波前后频谱');
legend('输入信号频谱','滤波后的频谱','滤波器频谱', 'Location', 'east');
grid;