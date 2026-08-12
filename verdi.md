# verdi学习笔记

## verdi compile
```bash
vlib work
vmap work work
#verilog
vericom -work work -64 
#systemverilog
vericom -work work -64 -sv
#vhdl
vhdlcom -work work -64
```
## 生成fsdb并查看
```systemverilog
//tb顶层添加
initial begin
    $fsdbDumpfile("Test.fsdb");
    $fsdbDumpvars(0,tb_top);
    $fsdbDumpMDA();
end
```

```makefile
run:
    vsim -c -pli.../.so -do "run -all;quit"$(TOP) #就是仿真加上verdi的.so库
verdi:
    verdi -ssf Test.fsdb -top $(SIM_TOP) &
```
## 常用波形操作

### 基础
● 直接拖入波形/Ctrl+W  
● 点击波形右键可切换Digital/Analog  
● view -> Compress Time Range 折叠时间区间
● trace drive/load
● 双击波形变化可以追溯到导致变化的代码

### 两波型对比
● window -> Dock to -> 新建一个Dock(第一个波形自动放进去)  
● 新建波形并打开第二个波形  
● window -> Dock to -> 刚刚建立的Dock  
● 右下角改成上下布局  
● window -> Sync All waveforms by -> All
就可以拖动光标统一时间对比波形
![verdi](https://github.com/Lesson927/IC-verification/blob/main/images/verdi.png)


<img width="1938" height="853" alt="image" src="https://github.com/user-attachments/assets/ec88b3d2-c6ff-4ceb-acee-1de9675cb082" />  
顶栏导入文件或者跳转被驱、驱动模块，信号，查找等等  
中键拖入波形  
底部波形 顶部波形操作      

verdi 保存波形信号  
波形界面->File->Save Signal  
verdi 导入波形信号  
波形界面->File->Restore Signal

### 计算波形方波信息
- 设置好cursor和marker光标
- 波形任务栏->view->signal event report
<img width="514" height="121" alt="image" src="https://github.com/user-attachments/assets/ddee342e-0fb7-4017-9d65-dbe66bf778ff" />  

### 总线操作
<img width="554" height="447" alt="image" src="https://github.com/user-attachments/assets/8938600f-3ee6-4f99-af32-5985df7836c8" />  
  
- signal->bus operation->expend ad Sub-bus
- 可以把总线的bits拆分或者合并

### 信号比对
<img width="779" height="411" alt="image" src="https://github.com/user-attachments/assets/5b39eae2-b614-4a35-8e83-d7830c318222" />
  
- ctr选中两个信号
- tools -> waveform compare -> compare 2 signals

### 信号逻辑操作
<img width="355" height="448" alt="image" src="https://github.com/user-attachments/assets/911c22f4-5d1e-4e7e-a4a8-814c8cc16791" />

- signals -> logical operation

### 原理图状态机跳转
<img width="903" height="485" alt="image" src="https://github.com/user-attachments/assets/c61cc3ac-2037-4873-84a1-9f87d2b9f1d2" />
<img width="225" height="241" alt="image" src="https://github.com/user-attachments/assets/a311c09f-2a77-4401-8ad7-abc55594267e" />
状态机静态显示选项<br>
<img width="330" height="314" alt="image" src="https://github.com/user-attachments/assets/39ecc0cd-f549-4b2d-9173-a766bee7d829" />
状态机跳转动画开关<br>
   
- 双击原理图中的转态机
- 拉取相关状态机state信号
- 勾选显示选项
- 点击波形查看状态机跳转
- 将状态机波形命名去除 对应信号值跳转窗口（中间）右键 -> remove local alias

## 查看覆盖率
```
verdi -cov -covdir xxx.vdb
```

