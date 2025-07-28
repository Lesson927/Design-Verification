# DPI-C学习笔记
## 数据类型
![数据类型]()
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