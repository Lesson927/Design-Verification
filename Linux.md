# Linux 常用命令

## ls
```bash
ls
ls -a 所有
ls -h 
```
## cd
```bash
cd 切换目录
cd ~ 切换到主目录
cd . 保持当前目录
cd .. 切换到上级目录
cd - 切换到最近使用目录
```
## 文件操作相关
```bash
touch 创建文件
vim/gvim 创建并编辑文件
sublime 创建并编辑文件
code . 当前目录下打开vscode
mkdir 创建文件夹 
    -p 回归创建
rm 删除
    -f 强制删除
    -r 递归删除，删除文件夹必须如此
mv 移动
    a b 重命名 a 为 b
tree 树状图
    -d 只显示目录
cp 拷贝
    -f 直接覆盖不提示
    -i 覆盖前提示
    -r 若源文件是目录文件，递归复制所有
```
## 查找
```bash
find 查找文件
    find ../name/README.md
grep 查找关键词
    grep -ri error
```
## 压缩
```bash
tar tar -cd ex.tar yf
```
## 解压
```bash
tar xvf simlib_questa10.6c.tar.gz
```
## 进程
```bash
kill
ps
```
## 其他
```bash
chmod   权限
ln  链接
|   管道符，|左边命令的输出作为命令右边的输入
tee 同时输出到屏幕和文件
```



# 界面快捷操作
Ctrl + Shift + T - 新建标签页  
Ctrl + PgUp/PgDn - 向左/右切换标签页




