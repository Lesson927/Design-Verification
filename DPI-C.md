# DPI-C学习笔记
## 数据类型
![数据类型](https://github.com/Lesson927/IC-verification/blob/main/images/DPI-C%E6%95%B0%E6%8D%AE%E7%B1%BB%E5%9E%8B.png)
## 编译
```do
gcc -shared -fPIC \
-I"../../" \
-L"../../" \
-lmpfr -lgmp 
".c" -o ".so"
```
## 仿真引用
```do
-sv_lib ../../...abcd.so
```
## SV导入
```C
float calculate_result(int x) {

    return f;
}
```
```systemverilog
//数据类型需要转换
import "DPI-C" function shortreal calculate_result(input int x);
import "DPI-C" function void print_binary(input real d, input int precision);
```
