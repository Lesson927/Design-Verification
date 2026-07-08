# 寄存器（register）
寄存器（Register）是中央处理器内部用于暂存指令、数据和地址的高速存储部件，由触发器或锁存器构成存储电路，
每个触发器存储1位二进制代码，n位寄存器需n个触发器组合实现。其分为基本寄存器和移位寄存器两类，前者支持并行输入输出，后者可通过移位脉冲实现串并行混合存取。  
## UVM定义的寄存器访问属性

## 寄存器访问属性的应用

### RW（读写）
<img width="455" height="210" alt="image" src="https://github.com/user-attachments/assets/4b110865-3045-4f91-a867-0e0345f8d7ca" />

### RO（只读）
<img width="538" height="211" alt="image" src="https://github.com/user-attachments/assets/7ab6e887-f847-4112-8caa-8e4babbbebea" />

### RC（读清）
读操作后，域段信息就被清除。  
RC寄存器和RO寄存器的结构基本一致，仅多了一步清除操作。

### RS（读置位）
读操作后，域段信息被置1。
### WC（写清）
与RC寄存器对比  
写操作后，域段信息就被清除。
### W1C（写1清）
最常用于"中断状态指示寄存器"  
<img width="456" height="206" alt="image" src="https://github.com/user-attachments/assets/19ac7dba-96e3-4f88-93ff-02a14f1033c0" />
当中断发生时，逻辑发送中断“脉冲”给寄存器域段缓存 。处理器收到中断线指示（中断使能场景）后，读取相应的“中断状态指示寄存器”，
获取是哪个信息导致的中断。处理器依次处理中断对应信息，完成中断处理程序后，向对应域段的写1，清除对应域段。

### W1T（写1翻转）

### W1（只写1次）
