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


