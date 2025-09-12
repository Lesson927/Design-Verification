# VCS 的命令（配合makefile）

VCS仿真分两步法和三步法，两步法包含：Compiling、Simulating；三步法包含：Analyzing、Elaborating、Simulating。
两步法只支持Verilog和systemVerilog语言编写的工程，不支持带vhdl语言的工程编译。三步法支持VHDL、Verilog和混合HDL编译。本文阐述三步法仿真方式

## Analyzing
VCS提供了vhdlan和vlogan可执行文件，用于analyze VHDL代码和verilog代码，并将分析后的中间文件存储到设计中或者工作库中。
默认情况下，vhdlan选项与VHDL-93兼容，vlogan与Verilog-2000兼容。可以使用vhdlan的-vhdl87选项切换到VHDL-87。类似地，可以分别使用-vhdl02或-vhdl08选项切换到VHDL 2002或VHDL 2008。可以使用vlogan的选项-sverilog 切换到SystemVerilog模式。语法如下
```makefile
vlogan [vlogan_options] <Verilog_source_filename>
vhdlan [vhdlan_options] <VHDL_filename_list>
```
## Elaborate
vcs命令执行设计的编译/细化，并创建模拟可执行文件。默认情况下生成并使用编译的事件代码。生成的模拟可执行文件simv可用于运行多个模拟。语法如下
```makefile
vcs [libname.]design_unit [options]
```
## Simulation
Elaboration过程中，VCS使用生成的中间文件创建一个二进制可执行文件simv。可以使用simv运行模拟。根据设计的详细说明，可以使用以下两种模式运行仿真：交互模式和批处理（batch）模式。
交互模式（调试模式）：支持交互模式下的仿真，需要在Elaboration 时使用-debug_access+r, -debug_access+all选项；
批处理模式：使用-debug_access选项会降低运行性能，仅当需要debug时，选用该选项；
仿真语法如下：
```makefile
./simv [ runtime_options]
```
## makfile示例
```makefile
############# BASI VARIABLE

TB_TOP      = a664_tb_top
TC          ?= 
DUT_DEFINE  ?=

############# DIRECTOR PATHS
BUILD_DIR       := 
LIB_DIR         := simlib/libero_lib

############# COMPILE

DEFINE = 
VHDLAN_OPTS =
VLOGAN_OPTS = 

EXE = simv

############# FILELIST

TB_FILELIST              = -f ../../tb/filelist/top_filelist
TB_FILELIST_VHD          = -f ../../tb/filelist/
TB_FILELIST_PCIE         = -f ../../tb/filelist/


############# BUILD & RUN 
#### ALSO YOU CAN SAY
############# COMPILE ELABORATE SIMULATION

all: build run
    @echo "Simulation Done"

build:
    @mkdir -p $(TC) $(BUILD_DIR)
    @cp

    @(cd $(TC); \
    mkdir -p 

    #compile
    vlogan $(VLOGAN_OPTS) -work work -sverilog $(TB_FLIST_PCIE) -l pcie_vlogan.log; \
    vhdlan
    vlogan $(VLOGAN_OPTS) +define+$(TB_DEFINE) +incdir+$(HOST_TASK) +incdir+$(TC_DIR) -work work $(DEFINE) -timescale=1ps/1fs -sverilog +v2k -ntb_opts uvm-1.2 $(TB_FLIST_ETH) $(TB_FLIST) -l eth_vlogan.log; \

    #elaborate
    vcs $(VCS_OPTS) work.$(TB_TOP) work.glbl -Mdir=../$(BUILD_DIR) -o ./$(EXE) | tee run.log)

run:

    #simulate
    @(cd $(TC); \   ##接下来操作生成文件都在该文件目录下
    ./$(EXE) -ucli -do sim.do -l $(SIM_LOG_FILE);
    grep "\*E" $(SIM_LOG_FILE) || echo "PASSED")

############# VERDI
verdi:

    @(cd $(TC); \
    vericom -work work ...; \
    chdlcom -work work ...; \
    verdi -lib work -top $(TB_TOP))

clean:
    rm -rf novas.conf verdilog $(TC)
    #使用make clean 要带 TC=ABC



```
