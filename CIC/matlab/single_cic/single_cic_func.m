% 单级CIC滤波器
% D: 滤波器长度
% signal: 输入信号
function after_h = single_cic_func(D, signal)

h = ones(1,D);  % CIC滤波器 h(n)
after_h = filter(h,1,signal);  % 滤波器的响应函数
% fvtool(h);
end