# dsp_FPGA

## 简介

数字信号处理的FPGA实现。主要包含MATLAB的仿真和FPGA的RTL实现。该项目不定时更新。

## 平台

### 操作系统

+ Windows 11 家庭版

### 使用软件

+ MATLAB R2020b

+ Quartus Prime 22.1std Lite Edition

+ Questa Sim-64 10.6c

+ PyCharm Community Edition 2023.1.2

## 文件结构

+ CIC：CIC滤波器
  
  + single_cic：单级CIC滤波器，无降采样部分

+ FIR：FIR滤波器
  
  + serial_fir：串行结构的FIR滤波器，滤波器系数由Matlab归一化

+ PP：Polyphase相关
  
  + PPD：Polyphase Decimator，多相抽取器
    
    + direct_ppd：直接实现的多相抽取器
  
  + PPF：Polyphase Filter，多相滤波器，也被称为信道化接收结构
    
    + direct_ppf：直接实现的多相滤波器。没有前置降采样结构，使用系数矩阵相乘的方式实现
    
    + s_axis_direct_ppf：带axis接口的ppf，使用wrapper模拟前置降采样。~~模块之间似乎存在时序问题，不定时解决中~~
    
    + ppf：标准的多相滤波器结构。使用前置系数、后置系数、FFT运算实现整个结构。

## 文档

编写中，暂不提供

---

## Introduction

digital signal processing on FPGA
