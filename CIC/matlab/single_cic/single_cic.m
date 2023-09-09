% 用Matlab仿真不同长度的单级CIC滤波器的频谱特性。

% 长度为1
M = 1;  % 滤波器长度
h = ones(1,M);  % CIC滤波器 h(n)
delta = [1 zeros(1,1023)];  % 冲激函数
after_h1 = filter(h,1,delta);  % 滤波器的响应函数
h1_AFR_dB = 20*log10(abs(fft(after_h1, 1024))); % 滤波器的幅频响应
norm_h1_AFR_dB = h1_AFR_dB - max(h1_AFR_dB);

M = 3;  % 滤波器长度
h = ones(1,M);  % CIC滤波器 h(n)
delta = [1 zeros(1,1023)];  % 冲激函数
after_h3 = filter(h,1,delta);  % 滤波器的响应函数
h3_AFR_dB = 20*log10(abs(fft(after_h3, 1024))); % 滤波器的幅频响应
norm_h3_AFR_dB = h3_AFR_dB - max(h3_AFR_dB);

M = 5;  % 滤波器长度
h = ones(1,M);  % CIC滤波器 h(n)
delta = [1 zeros(1,1023)];  % 冲激函数
after_h5 = filter(h,1,delta);  % 滤波器的响应函数
h5_AFR_dB = 20*log10(abs(fft(after_h5, 1024))); % 滤波器的幅频响应
norm_h5_AFR_dB = h5_AFR_dB - max(h5_AFR_dB);

M = 10;  % 滤波器长度
h = ones(1,M);  % CIC滤波器 h(n)
delta = [1 zeros(1,1023)];  % 冲激函数
after_h10 = filter(h,1,delta);  % 滤波器的响应函数
h10_AFR_dB = 20*log10(abs(fft(after_h10, 1024))); % 滤波器的幅频响应
norm_h10_AFR_dB = h10_AFR_dB - max(h10_AFR_dB);

%% 绘图
f = 0:length(h1_AFR_dB)-1;
f = 2*f/(length(f)); % 归一化频率，最大值抽样频率为2 即f/N *fs
plot(f, norm_h1_AFR_dB, 'o', ...
     f, norm_h3_AFR_dB, '-', ...
     f, norm_h5_AFR_dB, '.', ...
     f, norm_h10_AFR_dB, '^');
axis([0 1 -50 0]);
xlabel('归一化频率'); ylabel('幅度(dB)');
legend('M=1', 'M=3', 'M=5', 'M=10');
grid;
