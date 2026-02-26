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

# 环境变量配置
## 方法一：export PATH
```shell
export PATH=/home/uusama/mysql/bin:$PATH
#或者把PATH放在前面
export PATH=$PATH:/home/uusama/mysql/bin
```
- 生效时间：立即生效
- 生效期限：当前终端有效，窗口关闭后无效
- 生效范围：仅对当前用户有效
## 方法二： gvim ~/.bashrc
```shell
vim ~/.bashrc
# 在最后一行加上
export PATH=$PATH:/home/uusama/mysql/bin
```
- 生效时间：`source ~/.bashrc`生效
- 生效期限：永久有效
- 生效范围：仅对当前用户有效
## 方法三：gvim ~/.bash_profile
和方法二类似  
## 方法四：gvim /etc/bashrc
```shell
# 如果/etc/bashrc文件不可编辑，需要修改为可编辑
chmod -v u+w /etc/bashrc
 
vim /etc/bashrc
# 在最后一行加上
export PATH=$PATH:/home/uusama/mysql/bin
```
- 生效时间：`source /etc/bashrc`生效
- 生效期限：永久有效
- 生效范围：对所有用户有效

# 环境变量文件加载
系统环境变量 -> 用户自定义环境变量 /etc/environment -> /etc/profile -> ~/.profile
```
/etc/environment
/etc/profile
/etc/profile.d/test.sh，新建文件，没有文件夹可略过
/etc/bashrc，或者/etc/bash.bashrc
~/.bash_profile，或者~/.profile
~/.bashrc
```

# 命令别名 alias





















