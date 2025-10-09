#!/bin/bash
# 更稳妥的编译方法

# 方法1: 分开编译
vcs \
    -full64 \
    -sverilog \
    +v2k \
    -v ../lib/lsi_10k_FTGS.vhd \      # VHDL作为库文件
    ../prj/gate/switch_netlist.v \
    -f ../tb/filelist/tb_filelist \
    -top tb_top \
    -l compile.log

#./simv \
    +vcs+flush+all \
    +sdfverbose \
    -sdf max:tb_top/dut:top.sdf \
    -l post_simulation.log
