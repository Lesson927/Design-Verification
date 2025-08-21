# filelist

## 格式
```filelist
../../tb/top/tb_top.sv
../../tb/top/define.sv
```
## 批量添加
工程中，编译文件时，经常采用filelist列出所有需要编译的文件及路径。

文件少的时候，可以直接手写/xx/xxx/a.c

但是文件多了，手写效率低，易错。

采用命令：

（1）
find -name “*.v” > filelist.f

会将当前目录下及子目录中所有.v的文件及路径写到文件filelist.f中。

（2）
find dir -name “*.v” > filelist.f

其中，dir:文件夹名。
会将dir中的所有.v的文件都写到filelist.f中。