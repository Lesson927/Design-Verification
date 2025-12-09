# Shell 教程

## Shell 变量

### 定义变量  
只包含字母、数字和下划线  
不能以数字开头  
避免使用shell关键字：（例如 if、then、else、fi、for、while 等）  
使用大写字母表示常量  
避免使用特殊符号  
避免使用空格（等号两侧也是）  

### 使用变量

使用一个定义过的变量用如下格式：  
**${var}**
只读变量：  
readonly VAR  
删除变量：  
unset variable_name  
unset 命令不可删除只读变量  
变量类型：  
字符整数数组环境变量  
### Shell 字符串
单引号里任何字符串都会原样输出，不可有变量  
双引号可以有变量，可以出现转义字符  

### Shell注释  
单行注释：#  
多行注释：: + 空格 + 单引号
```
: '
这是注释的部分。
可以有多行内容。
'
```

## Shell 传递参数

## Shell 数组

## Shell 运算符
### 算术运算符
<img width="853" height="421" alt="image" src="https://github.com/user-attachments/assets/f71bbc10-9b1f-4835-9cc3-2ced2d7d54be" />  
### 关系运算符
<img width="851" height="308" alt="image" src="https://github.com/user-attachments/assets/ef984a1f-728f-4d40-b993-3b050c208b33" />  
### 布尔运算符
<img width="849" height="179" alt="image" src="https://github.com/user-attachments/assets/7d60fa6c-f4b1-4491-ae41-2472588dbff3" />  
### 逻辑运算符
<img width="843" height="131" alt="image" src="https://github.com/user-attachments/assets/7cff4458-3e9f-4f36-9083-b3ed55f97443" />  
### 字符串运算符
<img width="845" height="264" alt="image" src="https://github.com/user-attachments/assets/2bccdfd5-dce2-4c23-82e0-20da9286351a" />  
### 文件测试运算符
<img width="848" height="610" alt="image" src="https://github.com/user-attachments/assets/f9438a10-3337-4116-85e0-3dc77da32bad" />  
### 自增和自减操作符
<img width="838" height="348" alt="image" src="https://github.com/user-attachments/assets/d5c9fa40-1048-4282-b0ce-83044de22e0c" />  

## Shell echo 命令

### 基本用法
```
echo "Welcome, $name!"
```
### 常用选项
-n 不换行输出  
-e 启用转义字符解释  

### 高级用法
输出到文件  
```
echo "This will be saved to file" > output.txt
echo "Additional content" >> output.txt # 追加内容
```

## Shell printf 命令

### 基本使用
```
# 简单字符串输出
printf "Hello, World!\n"

# 带变量的输出
name="Alice"
printf "Hello, %s\n" "$name"
```

### 常用格式说明
```
# 整数
printf "Decimal: %d\nHex: %x\nOctal: %o\n" 255 255 255
# 浮点数
printf "Float: %f\nScientific: %e\n" 3.14159 3.14159
# 字符串
printf "Name: %s\n" "Bob"
# 字符
printf "First letter: %c\n" "A"
```
## Shell test 命令

## Shell 流程控制
### if else
```
num1=$[2*3]
num2=$[1+5]
if test $[num1] -eq $[num2]
then
    echo '两个数字相等!'
else
    echo '两个数字不相等!'
fi
```
### for循环
```
for var in item1 item2 ... itemN
do
    command1
    command2
    ...
    commandN
done

```
### while语句
```
while condition
do
    command
done
```
```
#!/bin/bash
while :
do
    echo -n "输入 1 到 5 之间的数字: "
    read aNum
    case $aNum in
        1|2|3|4|5) echo "你输入的数字为 $aNum!"
        ;;
        *) echo "你输入的数字不是 1 到 5 之间的!"
            continue
            echo "游戏结束"
        ;;
    esac
done
```

## Shell 输入输出重定向

## 运行Shell脚本
```
./test.sh
```


























