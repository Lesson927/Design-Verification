# Questasim
基于脚本的Questasim自动化仿真

## 编译
**compile.do**
```bash
vlib work
vmap work work
#VHDL
vcom -work work -64 -debug +acc \
"../../hdl/file.vhd" \
...
#verilog
vlog -work work -64 -debug +acc \
"../../rtl/file.v" \
...
#systemverilog
vlog -work work -64 -sv -debug +acc \
+incdir+"../../" \
"../../rtl/file.v" \
...
#覆盖率
-cover bsectf
```
b：分支覆盖率（Branch Coverage）  
c：条件覆盖率（Condition Coverage）  
e：表达式覆盖率（Expression Coverage）  
s：语句覆盖率（Statement Coverage）  
t: 翻转覆盖率（Toggle Coverage）  
f：函数覆盖率（Function Coverage）  
x：FSM 覆盖率（eXtended FSM Coverage）  
## 优化
**elaborate.do**
```bash
vopt -64 +acc -l elaborate.log -L work -L unisims_ver -L unimacro_ver -L secureip -L xpm -work work work.tb_top work .glbl -o tb_top_opt
```
## 仿真
```bash
vsim -t 1ps -lib work tb_top_opt -coverage -sv_lib ../../.. -pli /tools/synopsys/verdi/U-2023.03/share/PLI/MODELSIM/linux64/novas_fli.so
coverage save -onexit test.ucdb

do {wave.do}

view wave
view structure
view signals

run -all
```
## 波形
**wave.do**
```bash
add wave *
add wave -poisition insertpoint sim:/tb_top/_if/s_axis_a_tvalid
```
## Makefile
```bash
all:compile elaborate simulate

#Run compilation
compile:
    @echo "Running compile.do"
    vsim -c -do "source compile.do;exit" | tee -a compile.log

#Run elaboration
simulate:
    @echo "Running elaborate.do..."
    vsim -c -do "source elaborate.do;exit"

#Run simulation
simulate:
    @echo "Running simulate.do"
    vsim -c -do "source simulate.do" | tee simulate.log

#Open wlf file
viewwlf:
    vsim -gui -view test.wlf &

#VERDI
verdi:
    @echo "Running verdi..."
    . verdi_compile.do
    verdi -lib work -ssf tb_top.fsdb -top tb_top &
#clean
clean:
    @echo "Cleanning simulation outputs"
    rm -rf ...

.PHONY: all compile elaborate simulate clean
```
