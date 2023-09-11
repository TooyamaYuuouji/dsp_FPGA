"""
多相滤波器（Polyphase Filter）的实现
"""

import numpy
import matplotlib.pyplot as pyplot
import scipy.signal
import scipy.fft


class PPFilter():
    _channel_num: int
    _poly_filter: numpy.ndarray

    def __init__(self, filter_coeff: numpy.ndarray, channel_num: int = 8):
        self._channel_num = channel_num
        self._poly_filter = numpy.reshape(filter_coeff, (channel_num, -1), order='F')

    def filtering(self, signal: numpy.ndarray) -> numpy.ndarray:
        # 数据补零，使其能被信道数整除
        ratio = int(numpy.ceil(signal.size / self._channel_num))
        zero_len = int(self._channel_num * ratio - signal.size)
        signal_add_zero = numpy.concatenate((signal, numpy.zeros(zero_len)))
        # 信号多相
        poly_signal_temp = numpy.reshape(signal, (self._channel_num, -1), order='F')
        poly_signal = numpy.flipud(poly_signal_temp)
        # 多相分量分配系数
        index = numpy.arange(ratio)
        prefilter_data = poly_signal * ((-1) ** index)
        # 多相滤波
        filter_data = numpy.zeros(prefilter_data.shape, dtype=complex)
        for ii in range(self._channel_num):
            filter_data[ii] = scipy.signal.lfilter(self._poly_filter[ii], 1, prefilter_data[ii])

        # 滤波后处理
        postfilter_data = numpy.zeros(prefilter_data.shape, dtype=complex)
        for ii in range(self._channel_num):
            postfilter_data[ii] = filter_data[ii] * ((-1) ** ii) * numpy.exp(-1j * numpy.pi * ii / self._channel_num)

        ppf_result = scipy.fft.fft(postfilter_data, axis=0)

        return ppf_result

    def fvtool(self):
        n = self._poly_filter.size * 100

        w = numpy.linspace(0, 1, n)
        p = 2 * numpy.pi * numpy.cumsum(w)
        s = numpy.exp(1j * p)
        a = 20 * numpy.log10(numpy.abs(self.filtering(s)))
        w = numpy.linspace(0, 1, a.shape[1])

        pyplot.figure()
        pyplot.plot(w, a.T)
        pyplot.title('Digital channelizer frequency response')
        pyplot.xlabel('Frequency [*rad/sample]')
        pyplot.ylabel('Amplitude [dB]')
        pyplot.show()
        pass

        # return w, a


if __name__ == '__main__':
    print('in ppf')
