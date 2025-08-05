# Post-simulation(后仿真也称时序仿真)
时序仿真分析经常被称作后仿真，是将电路的门延迟参数和各种电路单元之间的连线情况考虑在内后进行的仿真，得到的仿真结果接近真实的应用情况。时序仿真的输入文件包括可编程器件布局布线之后的门级网表以及布局布线之后抽取的时序文件。通过逻辑仿真工具，可以将时序文件反标到门级网表，使得门级网表上标注了真实的延时信息，因此时序仿真的情况跟真实芯片的运行环境类似。通过时序仿真，当功能验证的测试用例都能够正确运行，仿真结果没有错误时，说明复杂的电子系统设计，经过逻辑综合、布局布线后的电路功能是正确的，可以确保复杂电子系统的功能正确。
时序仿真需要对时序器件的建立时间和保持时间进行实时的检查，所以需要的编译和仿真时间都比较长。

## Vivado导出网表.v和sdf文件
### 1.启动Vivado并创建工程
### 2.导入设计源文件和测试平台文件  
通过仿真
### 3.添加约束文件
### 4.运行综合（synthesis）
在 Flow Navigator 中，点击 Run Synthesis。  
Vivado 将会开始综合设计，并将 HDL 代码转换为逻辑网表，等待综合完成。  
综合完成后，Vivado 会显示一个对话框，询问是否打开综合后的设计。选择 Open Synthesized Design 以查看综合结果。  
可以在 Schematic 窗口中查看逻辑网表的结构，验证综合的正确性。  
### 5.导出网表文件
在打开的综合设计中，点击 File > Export > Export Netlist。  
在弹出的对话框中设置以下参数：  
Export Type：选择 Synthesis，表示导出综合后的网表文件。  
Format：选择 Verilog（如果需要生成 VHDL 格式，可以选择 VHDL）。  
Directory：选择网表文件的保存位置，例如项目目录下的 netlist 文件夹。  
点击 OK，Vivado 会在指定位置生成一个 Verilog 文件（例如 counter_netlist.v），该文件就是综合后的网表文件，可以用于后续仿真。  
### 生成延时文件sdf
在 Flow Navigator 中，点击 Run Implementation 以运行实现流程。  
实现完成后，点击 Open Implemented Design 查看已实现的设计。  
在菜单栏中，选择 Tools > Timing > Write SDF。  
在弹出的对话框中，选择保存路径并指定文件名（例如 counter.sdf）。  
点击 OK，Vivado 将生成一个标准延时文件（SDF 文件）。  

### Vivado 运行后仿真
Run simulation  
Run Post-Implementation simulation  
通常来说后仿真脚本，网表，sdf在project.sim/sim1/impl/questa

### 导出vivado自带的后仿真脚本
点击 File > Export > Export Simulation
