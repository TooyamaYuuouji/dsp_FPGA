% 多相抽取器
% 没有进行频谱搬移，只是将滤波运算并行化实现了而已

function y = direct_ppd_func(signal, h, M)
    % 信号补零
    signal_len = length(signal);
    K = ceil(signal_len/M);
    signal_new_len = K*M;
    new_signal = [signal, zeros(1, signal_new_len-signal_len)]; % 如果信号长度不够，补零
    % 滤波器补零
    h_len = length(h);
    K = ceil(h_len/M);
    h_new_len = K*M;
    new_h = [h, zeros(1, h_new_len-h_len)]; % 如果滤波器长度不够，补零
    
    poly_signal = reshape(new_signal, M, []);
    poly_signal = flipud(poly_signal);
    poly_h = reshape(new_h, M, []);
    
    for ii = 1:M
        poly_y(ii, :) = filter(poly_h(ii, :), 1, poly_signal(ii, :));
    end
    
    y = sum(poly_y);
end