# antidote_MATLAB

## 介绍
antidote_MATLAB 是一个非常简短的 MATLAB 框架，顾名思义，可以帮助代码编写者找到“刚刚”的代码。

代码的管理通常采用比如 Git 等 VCS 工具，但是 MATLAB 做为一种偏科学研究的工具，在编写代码的时候通常不会用上述工具，尤其是在开发阶段。

本工具的基本原理是在运行代码的时候自动保存一份当前代码到特定目录，因为只是简单的复制，所以带来的缺点是占用空间较大。
在保存代码的同时，也保存了当前环境和日志，用于恢复当时的状态。保存粒度可以选择按照天、小时、分钟或秒，当然粒度选择的越小，代码备份的越频繁，占用的空间越大，但是找回“刚刚”的代码的可能性越大。

同时提供了日志函数和进度显示函数，进度显示函数主要用于迭代代码环境中。

## 使用说明

*config.m* 包含本框架的所有基本代码。

*demo.m* 是使用本框架的一个例子。


## 函数说明

[figure_dir, func_logger, func_progress_bar, func_start, func_end] = config(output_dir, output_prefix, output_by)

功能：配置函数

输入参数：

- output_dir：输出目录，建议指定为 'output'
- output_prefix：输出目录的父目录，建议用当前目录，可以参考 demo
- output_by：粒度，字符串枚举类型，可选 'day', 'hour', 'minute', 'second'

输出参数：

- figure_dir：图输出目录，对应 'output_prefix'/'output_dir'/figure
- func_logger：日志输出函数
- func_progress_bar：进度信息输出函数
- func_start：开始函数，通常放置在 config 函数之后
- func_end：结束函数，通常放置在文件末尾
