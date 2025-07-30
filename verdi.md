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
● 直接拖入波形  
● 点击波形右键可切换Digital/Analog  
● view -> Compress Time Range 折叠时间区间
● trace drive/load

### 两波型对比
● window -> Dock to -> 新建一个Dock(第一个波形自动放进去)  
● 新建波形并打开第二个波形  
● window -> Dock to -> 刚刚建立的Dock  
● 右下角改成上下布局  
● window -> Sync All waveforms by -> All
就可以拖动光标统一时间对比波形
![verdi](https://github.com/Lesson927/IC-verification/blob/main/images/verdi.png)
