# gVim常用命令
🦡😿
## 补全
**ctrl + P**
## 跳转
**gg** 顶端  
**G**  底端  
**：100** 跳转指定行  
## 搜索
__shift +*__  
**n** 向下  
**N** 向上  
或者:/abc  
## 删除/复制  
**dd d2d**  
**ggdG** 删除全部    
**yy y5y**  
## 替换
全局：**%s/xx/yy/gc**  
局部：**：63，72s/xx/yy/gc**  
## 查找删除带xxx的某一行
**:g/xxx/d**
## 列操作
**ctrl + q**  
    delete 删除  
    ctrl + c/v 复制粘贴  
    I 前插入/ A 后插入 ... esc 退出  

## 可视化
shift + v 行选择
ctrl  + v 行列选择
shift + </> 减少/添加缩进  

## 撤销/重做
撤销 u  
重做 ctr+r

## 正则表达式
[正则表达式详细](https://www.cnblogs.com/tlnshuju/p/19379845)  
+ 例子
```
:g/^\s*test.*_intr$/.,+4d
```
:g/正则/命令  
^\s*test.*_intr$ 匹配  
.,+4 当前行到往后4行共5行  
d    删除  
