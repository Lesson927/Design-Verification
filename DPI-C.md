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
C侧
```C
float calculate_result(int x) {

    return f;
}
```
SV侧
```systemverilog
//数据类型需要转换
import "DPI-C" function shortreal calculate_result(input int x);
import "DPI-C" function void print_binary(input real d, input int precision);
```
## 关于可恨的.so文件
在c编译成.so文件中踩过的坑
### 验证有效
```bash
# 检查文件类型
file your_library.so
# 应显示类似：ELF 64-bit LSB shared object, x86-64

# 检查依赖项
ldd your_library.so
# 查看是否有 "not found" 的依赖项
```
<img width="1494" height="258" alt="image" src="https://github.com/user-attachments/assets/21037cc8-a825-4150-ae6c-b379f9e8bdc3" />
**如图该.so有多个依赖库，并且有特定路径，需要用此.so需要放置正确路径下运用.so**
### 链接
软连接
```bash
# 创建软链接
ln -s original_library.so new_name.so
# 验证链接
ls -l new_name.so
# 应显示：new_name.so -> original_library.so
```
