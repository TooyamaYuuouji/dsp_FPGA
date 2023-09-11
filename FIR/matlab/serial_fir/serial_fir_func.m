% 串行 fir 滤波器的实现

function [y, yref] = serial_fir_func(x, h)
% x: input data vector
% h: fir coef [h(0),h(1),...,h(N-1)]
x_len = length(x);
h_len = length(h);
y = zeros(x_len, 1);
tap_delay = zeros(h_len, 1);
for k=1:x_len
    tap_delay = [x(k); tap_delay(1:h_len-1)];
    for n=1:h_len
        y(k) = y(k)+tap_delay(n)*h(n);
    end
end
yref = filter(h,1,x);
end