import scipy
import numpy
import matplotlib.pyplot as pyplot
import ppf

channel_num = 8  # 信道数
fs = 1000  # 采样率，1000kHz
t1 = 1  # 最大采样时间
t = numpy.arange(0, int(t1 * fs)) / fs  # 采样时间
# 生成信号
f0 = 80
f1 = 100
signal = scipy.signal.chirp(t, f0, t1, f1)
F_signal = scipy.fft.fft(signal, 2048)

# 生成滤波器
cutoff = fs / channel_num / 2  # 截至频率
trans_width = cutoff / 10  # 过渡带宽度
filter_len = 128  # 滤波器长度
filter_coeff = scipy.signal.remez(filter_len, [0, cutoff - trans_width, cutoff + trans_width, 0.5*fs], [1, 0], fs=fs)
F_filter_coeff = scipy.fft.fft(filter_coeff, 2048)

# 多相滤波器滤波
ppf_inst = ppf.PPFilter(filter_coeff=filter_coeff, channel_num=channel_num)
# ppf_inst.fvtool()
after_ppf = ppf_inst.filtering(signal)
after_ppf_dB = 20 * numpy.log10(numpy.abs(after_ppf))
print(type(after_ppf_dB))

# 绘图
# 原始信号和滤波器
pyplot.figure(1)
pyplot.subplot(4, 1, 1)
pyplot.plot(numpy.real(signal))
pyplot.subplot(4, 1, 2)
pyplot.plot(numpy.abs(F_signal))
pyplot.subplot(4, 1, 3)
pyplot.plot(numpy.real(filter_coeff))
pyplot.subplot(4, 1, 4)
pyplot.plot(numpy.abs(F_filter_coeff))
pyplot.rcParams['font.sans-serif'] = ['SimHei']  # 设置中文字体
pyplot.rcParams['axes.unicode_minus'] = False  # 解决负号显示问题
# pyplot.title('')
# 多相滤波
pyplot.figure(2)
pyplot.subplot(4, 1, 1)
pyplot.plot(numpy.real(after_ppf_dB[0:3].T))
pyplot.subplot(4, 1, 2)
pyplot.plot(numpy.imag(after_ppf_dB[0:3].T))
pyplot.subplot(4, 1, 3)
pyplot.plot(numpy.real(after_ppf_dB[4:7].T))
pyplot.subplot(4, 1, 4)
pyplot.plot(numpy.imag(after_ppf_dB[4:7].T))
pyplot.show()
