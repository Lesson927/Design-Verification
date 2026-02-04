# Questasim
基于脚本的Questasim自动化仿真

## 编译
**compile.do**
```do
vlib work                   #创建仿真库
vmap work work              #链接逻辑库到物理库
#VHDL
vcom -work work -64 -debug +acc \         #-work 编译库
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
`vcover merge -out merged_coverage.ucdb test1.ucdb test2.ucdb test3.ucdb`用于合并多个ucdb文件  
## 优化
**elaborate.do**
```do
vopt -64 +acc -l elaborate.log -L work -L unisims_ver -L unimacro_ver -L secureip -L xpm -work work work.tb_top work .glbl -o tb_top_opt  #-L 引用仿真库
```
## 仿真
```do
vsim -t 1ps -lib work tb_top_opt -coverage -sv_lib ../../.. -pli /tools/synopsys/verdi/U-2023.03/share/PLI/MODELSIM/linux64/novas_fli.so  #-sv_lib -pli 引用第三方库
coverage save -onexit test.ucdb

do {wave.do}

view wave
view structure
view signals

run -all
```
## 波形
**wave.do**
```do
add wave *
add wave -poisition insertpoint sim:/tb_top/_if/s_axis_a_tvalid
```
## Makefile
```makefile
all:compile elaborate simulate

#Run compilation
compile:
    @echo "Running compile.do"
    vsim -c -do "source compile.do;exit" | tee -a compile.log

#Run elaboration
elaborate:
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

#help
help:
    @echo "Cmomand list"
    @echo "make compile"
    @echo "make elaborate"
    @echo "make simulate"

.PHONY: all compile elaborate simulate clean
```

<img width="2542" height="746" alt="image" src="https://github.com/user-attachments/assets/99315b7d-db58-4b3a-b8da-68b95f7fbfab" />
<img width="2530" height="1078" alt="image" src="https://github.com/user-attachments/assets/fe32a377-b607-4142-8189-33ce767a540f" />
<img width="2560" height="649" alt="image" src="https://github.com/user-attachments/assets/905df3a6-96dc-4e47-a85c-62577b256d47" />
<img width="2523" height="1154" alt="image" src="https://github.com/user-attachments/assets/472c1399-27ae-4795-af2b-b344de0abb57" />
<img width="2551" height="138" alt="image" src="https://github.com/user-attachments/assets/7f15f534-30ee-4e77-9bf2-fc09239d45b4" />
<img width="861" height="432" alt="image" src="https://github.com/user-attachments/assets/776b664f-da9b-4315-8eb4-f22585db668f" />
<img width="1075" height="292" alt="image" src="https://github.com/user-attachments/assets/ab0b9f04-9e76-4522-bd68-456e5ab108a5" />










