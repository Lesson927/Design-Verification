# DPI-C学习笔记
## 数据类型
![数据类型](https://github.com/Lesson927/IC-verification/blob/main/images/DPI-C%E6%95%B0%E6%8D%AE%E7%B1%BB%E5%9E%8B.png)
## 编译
```bash
gcc -shared -fPIC \
-I"../../" \
-L"../../" \
-lmpfr -lgmp 
".c" -o ".so"
```
## 仿真引用
```bash
-sv_lib ../../...abcd.so
```
