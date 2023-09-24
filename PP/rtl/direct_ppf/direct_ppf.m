%% 直接型多相滤波器的实现
% 使用系数矩阵的方式实现多相滤波
% 系数被量化后进行滤波，多个过程都使用到了量化

clc; clear; close;

%% 生成信号
fs = 1000;
f1 = 50;
f2 = 150;
N = 128;
t = (1:N)/fs;
signal = cos(2*pi*f1.*t);
exp_carrier = exp(-1j*2*pi*f2.*t);
cplx_signal = signal .* exp_carrier;
% cplx_signal = signal;

%% 生成滤波器
h_n = 32;
h = fir1(h_n-1, 0.2, 'low');
% fvtool(h);

%% 量化
channel_num = 8;
Q = 16;
% 数据量化
signal_real = real(cplx_signal);
quan_signal_real = floor(signal_real*(2^(Q-1)-1));
signal_imag = imag(cplx_signal);
quan_signal_imag = floor(signal_imag*(2^(Q-1)-1));
quan_signal = quan_signal_real + 1j * quan_signal_imag;

% 滤波器量化
quan_h = floor(h*(2^(Q-1)-1));

% 旋转矩阵量化
for ii = 1:channel_num
    for jj = 1:channel_num
        item = exp(-1j*2*pi/channel_num)^(-(ii-1)*(jj-1));
        item_real = real(item);
        quan_item_real = floor(item_real*(2^(Q-1)-1));
        item_imag = imag(item);
        quan_item_imag = floor(item_imag*(2^(Q-1)-1));
        quan_D(ii, jj) = quan_item_real + 1j * quan_item_imag;
    end
end

%% 多相滤波
poly_signal = reshape(quan_signal, channel_num, []);
poly_signal = flipud(poly_signal);
poly_h = reshape(quan_h, channel_num, []);
for ii = 1:channel_num
    after_poly_y(ii, :) = filter(poly_h(ii, :), 1, poly_signal(ii, :));
end

% 线性组合
poly_y = quan_D * after_poly_y;

% 滤波结果绘图
figure();
for ii = 1:channel_num
    F_poly_y = abs(fft(poly_y(ii, :), 4096));
    norm_F_poly_y = F_poly_y / max(F_poly_y);
    subplot(2,4,ii); plot(norm_F_poly_y); title(string(ii));
end

%% 数据写出
% 系数矩阵数据写出
fid = fopen('dft_d_mtx.txt','w');
fprintf(fid, '%s_%s', dec2hex(quan_item_real, 8), dec2hex(quan_item_imag, 8));
        fprintf(fid, ' ');
fprintf(fid, '\r\n');
fclose(fid);

% 滤波器数据
fid = fopen('D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch0_h_hex.txt','w');
din = poly_h(1, :);
for ii = 1:length(din)
    fprintf(fid, '%s', dec2hex(din(ii), 4));
    fprintf(fid, '\r\n');
end
fclose(fid);

fid = fopen('D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch1_h_hex.txt','w');
din = poly_h(2, :);
for ii = 1:length(din)
    fprintf(fid, '%s', dec2hex(din(ii), 4));
    fprintf(fid, '\r\n');
end
fclose(fid);

fid = fopen('D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch2_h_hex.txt','w');
din = poly_h(3, :);
for ii = 1:length(din)
    fprintf(fid, '%s', dec2hex(din(ii), 4));
    fprintf(fid, '\r\n');
end
fclose(fid);

fid = fopen('D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch3_h_hex.txt','w');
din = poly_h(4, :);
for ii = 1:length(din)
    fprintf(fid, '%s', dec2hex(din(ii), 4));
    fprintf(fid, '\r\n');
end
fclose(fid);

fid = fopen('D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch4_h_hex.txt','w');
din = poly_h(5, :);
for ii = 1:length(din)
    fprintf(fid, '%s', dec2hex(din(ii), 4));
    fprintf(fid, '\r\n');
end
fclose(fid);

fid = fopen('D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch5_h_hex.txt','w');
din = poly_h(6, :);
for ii = 1:length(din)
    fprintf(fid, '%s', dec2hex(din(ii), 4));
    fprintf(fid, '\r\n');
end
fclose(fid);

fid = fopen('D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch6_h_hex.txt','w');
din = poly_h(7, :);
for ii = 1:length(din)
    fprintf(fid, '%s', dec2hex(din(ii), 4));
    fprintf(fid, '\r\n');
end
fclose(fid);

fid = fopen('D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch7_h_hex.txt','w');
din = poly_h(8, :);
for ii = 1:length(din)
    fprintf(fid, '%s', dec2hex(din(ii), 4));
    fprintf(fid, '\r\n');
end
fclose(fid);

% 信号数据
fid = fopen('D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch0_signal_hex.txt','w');
din = poly_signal(1, :);
for ii = 1:length(din)
    fprintf(fid, '%s', dec2hex(real(din(ii)), 4));
    fprintf(fid, '%s', dec2hex(imag(din(ii)), 4));
    fprintf(fid, '\r\n');
end
fclose(fid);

fid = fopen('D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch1_signal_hex.txt','w');
din = poly_signal(2, :);
for ii = 1:length(din)
    fprintf(fid, '%s', dec2hex(real(din(ii)), 4));
    fprintf(fid, '%s', dec2hex(imag(din(ii)), 4));
    fprintf(fid, '\r\n');
end
fclose(fid);

fid = fopen('D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch2_signal_hex.txt','w');
din = poly_signal(3, :);
for ii = 1:length(din)
    fprintf(fid, '%s', dec2hex(real(din(ii)), 4));
    fprintf(fid, '%s', dec2hex(imag(din(ii)), 4));
    fprintf(fid, '\r\n');
end
fclose(fid);

fid = fopen('D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch3_signal_hex.txt','w');
din = poly_signal(4, :);
for ii = 1:length(din)
    fprintf(fid, '%s', dec2hex(real(din(ii)), 4));
    fprintf(fid, '%s', dec2hex(imag(din(ii)), 4));
    fprintf(fid, '\r\n');
end
fclose(fid);

fid = fopen('D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch4_signal_hex.txt','w');
din = poly_signal(5, :);
for ii = 1:length(din)
    fprintf(fid, '%s', dec2hex(real(din(ii)), 4));
    fprintf(fid, '%s', dec2hex(imag(din(ii)), 4));
    fprintf(fid, '\r\n');
end
fclose(fid);

fid = fopen('D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch5_signal_hex.txt','w');
din = poly_signal(6, :);
for ii = 1:length(din)
    fprintf(fid, '%s', dec2hex(real(din(ii)), 4));
    fprintf(fid, '%s', dec2hex(imag(din(ii)), 4));
    fprintf(fid, '\r\n');
end
fclose(fid);

fid = fopen('D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch6_signal_hex.txt','w');
din = poly_signal(7, :);
for ii = 1:length(din)
    fprintf(fid, '%s', dec2hex(real(din(ii)), 4));
    fprintf(fid, '%s', dec2hex(imag(din(ii)), 4));
    fprintf(fid, '\r\n');
end
fclose(fid);

fid = fopen('D:/Code/Proj/filter_FPGA/PP/rtl/ppf_v2/src/ch7_signal_hex.txt','w');
din = poly_signal(8, :);
for ii = 1:length(din)
    fprintf(fid, '%s', dec2hex(real(din(ii)), 4));
    fprintf(fid, '%s', dec2hex(imag(din(ii)), 4));
    fprintf(fid, '\r\n');
end
fclose(fid);