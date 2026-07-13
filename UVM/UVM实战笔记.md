# 第三章 UVM基础

## 与uvm_object相关的宏
uvm_object_utils：它用于把一个直接或间接派生自uvm_object的类注册到factory中。  
uvm_object_param_utils：它用于把一个直接或间接派生自uvm_object的参数化的类注册到factory中。
uvm_object_utils_begin/uvm_object_utils_end：当需要使用field_automation机制时，需要使用此宏  
uvm_object_param_utils_begin/uvm_object_param_utils_end: 带参数的field_automation机制宏  
## 与uvm_component相关的宏
uvm_component_utils：它用于把一个直接或间接派生自uvm_component的类注册到factory中。  
uvm_component_param_utils：它用于把一个直接或间接派生自uvm_component的参数化的类注册到factory中。  
uvm_component_param_utils_begin/uvm_component_param_utils_end:它用于同时需要使用factory机制和field_automation机制注册的类  
uvm_component_param_utils_begin/uvm_component_param_utils_end:它用于同时需要使用factory机制和field_automation机制注册的参数化类  
## uvm树的根
uvm_root::get():得到根  
get_parent():得到parent  
get_child():得到child  
get_children(ref uvm_component children[$]):得到所有child  
使用get_first_child和get_next_child的组合依次得到所有的child  
## field automation机制
```systemverilog
`define uvm_field_int(ARG,FLAG) 整数  
`define uvm_field_real(ARG,FLAG) 实数  
`define uvm_field_enum(T,ARG,FLAG) 枚举类型  
`define uvm_field_object(ARG,FLAG) object  
`define uvm_field_event(ARG,FLAG) 事件  
`define uvm_field_string(ARG,FLAG) 字符串
```
与动态数组有关的uvm_field系列宏有：  
```systemverilog
`define uvm_field_array_enum(ARG,FLAG)
`define uvm_field_array_int(ARG,FLAG)
`define uvm_field_array_object(ARG,FLAG)
`define uvm_field_array_string(ARG,FLAG)
```
与静态数组相关的uvm_field系列宏有：  
```systemverilog
`define uvm_field_sarray_int(ARG,FLAG)
`define uvm_field_sarray_enum(ARG,FLAG)
`define uvm_field_sarray_object(ARG,FLAG)
`define uvm_field_sarray_string(ARG,FLAG)
```
与队列相关的uvm_field系列宏有：  
```systemverilog
`define uvm_field_queue_enum(ARG,FLAG)
`define uvm_field_queue_int(ARG,FLAG)
`define uvm_field_queue_object(ARG,FLAG)
`define uvm_field_queue_string(ARG,FLAG)
```
与联合数组相关的uvm_field宏有：  
```systemverilog
`define uvm_field_aa_int_string(ARG, FLAG)
`define uvm_field_aa_string_string(ARG, FLAG)
`define uvm_field_aa_object_string(ARG, FLAG)
`define uvm_field_aa_int_int(ARG, FLAG)
`define uvm_field_aa_int_int_unsigned(ARG, FLAG)
`define uvm_field_aa_int_integer(ARG, FLAG)
`define uvm_field_aa_int_integer_unsigned(ARG, FLAG)
`define uvm_field_aa_int_byte(ARG, FLAG)
`define uvm_field_aa_int_byte_unsigned(ARG, FLAG)
`define uvm_field_aa_int_shortint(ARG, FLAG)
`define uvm_field_aa_int_shortint_unsigned(ARG, FLAG)
`define uvm_field_aa_int_longint(ARG, FLAG)
`define uvm_field_aa_int_longint_unsigned(ARG, FLAG)
`define uvm_field_aa_string_int(ARG, FLAG)
`define uvm_field_aa_object_int(ARG, FLAG)
```

### field automation机制的常用函数  
copy函数用于实例的复制  
compare函数用于比较两个实例是否一样  
pack_bytes函数用于将所有的字段打包成byte流  
unpack_bytes函数用于将一个byte流逐一恢复到某个类的实例中  
pack函数用于将所有的字段打包成bit流  
unpack函数用于将一个bit流逐一恢复到某个类的实例中  
pack_ints函数用于将所有的字段打包成int（4个byte，或者dword）流  
unpack_ints函数用于将一个int流逐一恢复到某个类的实例中  
print函数用于打印所有的字段  
clone函数  
### field automation机制中标志位的使用
`uvm_field_int(crc_err, UVM_ALL_ON | UVM_NOPACK)  
除了UVM_NOPACK之后，还有UVM_NOCOMPARE、UVM_NOPRINT、UVM_NORECORD、UVM_NOCOPY等选项，分别对应compare、print、record、copy等功能。  
### field automation中宏与if的结合

```systemverilog
`uvm_object_utils_begin(my_transaction)
`uvm_field_int(dmac, UVM_ALL_ON)
`uvm_field_int(smac, UVM_ALL_ON)
if(is_vlan)begin
  `uvm_field_int(vlan_info1, UVM_ALL_ON)
  `uvm_field_int(vlan_info2, UVM_ALL_ON)
  `uvm_field_int(vlan_info3, UVM_ALL_ON)
  `uvm_field_int(vlan_info4, UVM_ALL_ON)
end
`uvm_field_int(ether_type, UVM_ALL_ON)
`uvm_field_array_int(pload, UVM_ALL_ON)
`uvm_field_int(crc, UVM_ALL_ON | UVM_NOPACK)
`uvm_field_int(is_vlan, UVM_ALL_ON | UVM_NOPACK)
`uvm_object_utils_end
```

## UVM中打印信息的控制
### 设置打印信息的冗余度阈值
set_report_verbosity_level():  env.i_agt.drv.set_report_verbosity_level(UVM_HIGH);  
set_report_verbosity_level_hier():  env.i_agt.set_report_verbosity_level_hier(UVM_HIGH);
set_report_id_verbosity():  
env.i_agt.drv.set_report_id_verbosity("ID1", UVM_HIGH);  
env.i_agt.set_report_id_verbosity_hier("ID1", UVM_HIGH);  
命令行：  
+UVM_VERBOSITY=UVM_HIGH  
### 重载打印信息的严重性
env.i_agt.drv.set_report_severity_override(UVM_WARNING, UVM_ERROR);  
env.i_agt.drv.set_report_severity_id_override(UVM_WARNING, "my_driver", UVM_ERROR);  
命令行：  
<sim command> +uvm_set_severity=<comp>,<id>,<current severity>,<new severity>  
<sim command> +uvm_set_severity="uvm_test_top.env.i_agt.drv,my_driver,UVM_WARNING,UVM_ERROR"  
<sim command> +uvm_set_severity="uvm_test_top.env.i_agt.drv,_ALL_,UVM_WARNING,UVM_ERROR"
### UVM_ERROR达到一定数量结束仿真
set_report_max_quit_count(5);
命令行：  
<sim command> +UVM_MAX_QUIT_COUNT=6,NO  
### 设置计数的目标
set_report_severity_action():  
env.i_agt.drv.set_report_severity_action(UVM_WARNING,UVM_DISPLAY|UVM_COUNT);  
env.i_agt.set_report_severity_action_hier(UVM_WARNING, UVM_DISPLAY| UVM_COUNT);  
set_report_id_action():  
env.i_agt.drv.set_report_id_action("my_drv", UVM_DISPLAY| UVM_COUNT);  
env.i_agt.set_report_id_action_hier("my_drv", UVM_DISPLAY| UVM_COUNT);  
联合：env.i_agt.drv.set_report_severity_id_action(UVM_WARNING, "my_driver", UVM_DISPLAY| UVM_COUNT);  
命令行：  
<sim command> +uvm_set_action=<comp>,<id>,<severity>,<action>  
<sim command> +uvm_set_action="uvm_test_top.env.i_agt.drv,_ALL_,UVM_WARNING,UVM_DISPLAY|UVM_COUNT"
### UVM的断点功能
env.i_agt.drv.set_report_severity_action(UVM_WARNING, UVM_DISPLAY| UVM_STOP);
命令行：  
<sim command> +uvm_set_action="uvm_test_top.env.i_agt.drv,my_driver,UVM_WARNING,UVM_DISPLAY|UVM_STOP
### 将输出信息导入文件中
env.i_agt.drv.set_report_severity_file(UVM_INFO, info_log);  
env.i_agt.drv.set_report_severity_action(UVM_INFO, UVM_DISPLAY| UVM_LOG);  
env.i_agt.drv.set_report_id_file("my_drv", drv_log);  
env.i_agt.drv.set_report_id_action("my_drv", UVM_DISPLAY| UVM_LOG);  
### 控制打印信息的行为

```systemverilog
typedef enum
{
UVM_NO_ACTION = 'b000000,
UVM_DISPLAY = 'b000001,
UVM_LOG = 'b000010,
UVM_COUNT = 'b000100,
UVM_EXIT = 'b001000,
UVM_CALL_HOOK = 'b010000,
UVM_STOP = 'b100000
} uvm_action_type;
```

## config_db机制
uvm_config_db#(int)::set(this, "env.i_agt.drv", "pre_num", 100);  
uvm_config_db#(int)::get(this, "", "pre_num", pre_num);  
第一个和第二个参数联合起来组成目标路径，第三个参数表示一个记号，用以说明这个值是传给目标中的哪个成员的，第四个参数是要设置的值/变量  
check_config_usage();  
# 第四章 UVM中的TLM1.0通信
## TLM(Transaction Level Modeling)1.0

<img width="1003" height="667" alt="image" src="https://github.com/user-attachments/assets/59ada241-9b15-4a73-8db0-fa9f7738390c" />  
<img width="1021" height="380" alt="image" src="https://github.com/user-attachments/assets/ba93ed26-cbc0-449b-9fb8-11ca036fe341" />  

UVM中常用的PORT：
```systemverilog
uvm_blocking_put_port#(T);
uvm_nonblocking_put_port#(T);
uvm_put_port#(T);
uvm_blocking_get_port#(T);
uvm_nonblocking_get_port#(T);
uvm_get_port#(T);
uvm_blocking_peek_port#(T);
uvm_nonblocking_peek_port#(T);
uvm_peek_port#(T);
uvm_blocking_get_peek_port#(T);
uvm_nonblocking_get_peek_port#(T);
uvm_get_peek_port#(T);
uvm_blocking_transport_port#(REQ, RSP);
uvm_nonblocking_transport_port#(REQ, RSP);
uvm_transport_port#(REQ, RSP);
```
UVM中常用的EXPORT：  
```systemverilog
uvm_blocking_put_export#(T);
uvm_nonblocking_put_export#(T);
uvm_put_export#(T);
uvm_blocking_get_export#(T);
uvm_nonblocking_get_export#(T);
uvm_get_export#(T);
uvm_blocking_peek_export#(T);
uvm_nonblocking_peek_export#(T);
uvm_peek_export#(T);
uvm_blocking_get_peek_export#(T);
uvm_nonblocking_get_peek_export#(T);
uvm_get_peek_export#(T);
uvm_blocking_transport_export#(REQ, RSP);
uvm_nonblocking_transport_export#(REQ, RSP);
uvm_transport_export#(REQ, RSP);
```
**PORT和EXPORT体现的是一种控制流，在这种控制流中，PORT具有高优先级，而EXPORT具有低优先级。只有高优先级的端口才能向低优先级的端口发起三种操作。**  
## UVM中各种端口的互连
### PORT与EXPORT

```systemverilog
function void my_env::connect_phase(uvm_phase phase);
super.connect_phase(phase);
A_inst.A_port.connect(B_inst.B_export);
endfunction
```

### IMP
UVM中的IMP：  
```systemverilog
uvm_blocking_put_imp#(T, IMP);
uvm_nonblocking_put_imp#(T, IMP);
uvm_put_imp#(T, IMP);
uvm_blocking_get_imp#(T, IMP);
uvm_nonblocking_get_imp#(T, IMP);
uvm_get_imp#(T, IMP);
uvm_blocking_peek_imp#(T, IMP);
uvm_nonblocking_peek_imp#(T, IMP);
uvm_peek_imp#(T, IMP);
uvm_blocking_get_peek_imp#(T, IMP);
uvm_nonblocking_get_peek_imp#(T, IMP);
uvm_get_peek_imp#(T, IMP);
uvm_blocking_transport_imp#(REQ, RSP, IMP);
uvm_nonblocking_transport_imp#(REQ, RSP, IMP);
uvm_transport_imp#(REQ, RSP, IMP);
```
<img width="916" height="730" alt="image" src="https://github.com/user-attachments/assets/f69436a8-79c2-4db8-a4a7-2d0b26d65c73" />  

### PORT与IMP的连接
PORT > EXPORT > IMP  
<img width="980" height="347" alt="image" src="https://github.com/user-attachments/assets/4adbad5a-ffe2-4af3-8e0f-d48bc0652975" />  

### EXPORT与IMP的连接
和PORT与IMP连接几乎一致
### PORT与PORT的连接
C_inst.C_port.connect(this.A_port);
### EXPORT和EXPORT连接
this.C_export.connect(B_inst.B_export);  
### blocking_get端口的使用
<img width="931" height="384" alt="image" src="https://github.com/user-attachments/assets/30e317d0-1f7c-4a7c-8d47-a6f18fae7232" />  
搞清楚谁是动作发起者谁是动作接收者，IMP伴随动作接收者。  
### blocking_transport端口的使用
<img width="910" height="335" alt="image" src="https://github.com/user-attachments/assets/7d590aa2-d4f8-4e5d-82e7-e56099ce38f1" />  

### noblocking端口的使用
nonblocking端口的所有操作都是非阻塞的，换言之，必须用函数实现，而不能用任务实现。
blocking是可以等待值的到来，符合task中时序规定；noblocking是不用等待值的到来，在值到来之前可以去干别的事情。所以需要立即返回一个值（状态）。
### UVM中的通信方式
第一，默认情况下，一个analysis_port（analysis_export）可以连接多个IMP，也就是说，analysis_port（analysis_export）与IMP之间的通信是一对多的通信，而put和get系列端口与相应IMP的通信是一对一的通信（除非在实例化时指定可以连接的数量，参照4.2.1节A_port的new函数原型代码清单4-4）。analysis_port（analysis_export）更像是一个广播。  
第二，put与get系列端口都有阻塞和非阻塞的区分。但是对于analysis_port和analysis_export来说，没有阻塞和非阻塞的概念。因为它本身就是广播，不必等待与其相连的其他端口的响应，所以不存在阻塞和非阻塞。  
一个analysis_port可以和多个IMP相连接进行通信，但是IMP的类型必须是uvm_analysis_imp，否则会报错。  
对于analysis_port和analysis_export来说，只有一种操作：write。在analysis_imp所在的component，必须定义一个名字为write的函数。  
<img width="903" height="508" alt="image" src="https://github.com/user-attachments/assets/d554afb7-2233-4c1b-910c-ac13ee8310bb" />  

### 一个component内有多个IMP
```systemverilog
class my_agent extends uvm_agent ;
uvm_analysis_port #(my_transaction) ap;
…
function void my_agent::connect_phase(uvm_phase phase);
ap = mon.ap;
…
endfunction
endclass
function void my_env::connect_phase(uvm_phase phase);
o_agt.ap.connect(scb.scb_imp);
…
endfunction
```

### 使用FIFO通信  
<img width="983" height="673" alt="image" src="https://github.com/user-attachments/assets/b0ffe279-3138-42e4-8af6-4f18e2d2b602" />  

### FIFO上的端口及调试
<img width="986" height="472" alt="image" src="https://github.com/user-attachments/assets/6e6dfa59-40ae-424d-b8b4-8d2cb5a5dd20" />  
used函数：用于查询FIFO缓存中有多少transaction。  
is_empty函数：用于判断当前FIFO缓存是否为空。  
is_full函数：用于判断当前FIFO缓存是否为满。
flush函数：用于清空FIFO缓存中的所有数据，一般用于复位操作。 
### 用FIFO还是用IMP
各有优劣

# 第五章 UVM验证平台的运行 
## phase机制
function phase:build_phase、connect_phase等，这些phase都不耗费仿真时间，通过函数来实现  
task phase:如run_phase等，它们耗费仿真时间，通过任务来实现。给DUT施加激励、监测DUT的输出都是在这些phase中完成的。  
<img width="993" height="545" alt="image" src="https://github.com/user-attachments/assets/d2951c55-f849-4791-bf66-629d9247a3b9" />  

|phase|主要功能|
|:---:|:---:|
|build phase|✅实例化组件<br>✅实例化寄存器模型<br>✅获取正在构建中的组件的配置值<br>✅配置对应组件|
|connect phase|✅设置TLM端口<br>✅连接reg_model和reg_adapter<br>✅设置sequencer<br>✅分组管理组件phase执行|
### 动态运行phase
在reset_phase对DUT进行复位、初始化等操作，在configure_phase则进行DUT的配置，DUT的运行主要在main_phase完成，shutdown_phase则是做一些与DUT断电相关的操作。  
### phase的执行顺序
build_phase:自上而下  
function phase:自下而上  
task phase:自下而上(并行)  
### UVM树的遍历
深度优先
### super.phase的内容
除build_phase外，在写其他phase时，完全可以不必加上super.xxxx_phase语句，如第2章中所有的super.main_phase都可以去掉。当然，这个结论只适用于直接扩展自uvm_component的类。如果是扩展自用户自定义的类，如base_test类，且在其某个phase，如connect_phase中定义了一些重要内容，那么在具体测试用例的connect_phase中就不应该省略super.connect_phase。  
### build阶段出现UVM_ERROR停止仿真
### phase的跳转
跳转中最难的地方在于跳转前后的清理和准备工作。如上面的运行结果中的警告信息就是因为没有及时对objection进行清理。对于scoreboard来说，这个问题可能尤其严重。在跳转前，scoreboard的expect_queue中的数据应该清空，同时要容忍跳转后DUT可能输出一些异常数据。  
jump函数：function void uvm_phase::jump(uvm_phase phase);  
jump函数的参数必须是一个uvm_phase类型的变量。在UVM中，这样的变量共有如下几个：  
```systemverilog
uvm_build_phase::get();
uvm_connect_phase::get();
uvm_end_of_elaboration_phase::get();
uvm_start_of_simulation_phase::get();
uvm_run_phase::get();
uvm_pre_reset_phase::get();
uvm_reset_phase::get();
uvm_post_reset_phase::get();
uvm_pre_configure_phase::get();
uvm_configure_phase::get();
uvm_post_configure_phase::get();
uvm_pre_main_phase::get();
uvm_main_phase::get();
uvm_post_main_phase::get();
uvm_pre_shutdown_phase::get();
uvm_shutdown_phase::get();
uvm_post_shutdown_phase::get();
uvm_extract_phase::get();
uvm_check_phase::get();
uvm_report_phase::get();
uvm_final_phase::get();
```
uvm_pre_reset_phase：：get（）后的所有phase都可以作为jump的参数。
### phase的调试
<sim command> +UVM_PHASE_TRACE  
**超时退出**  
在UVM中通过uvm_root的set_timeout函数可以设置超时时间：  
uvm_top.set_timeout(500ns, 0);  
<sim command> +UVM_TIMEOUT=<timeout>,<overridable>
## objection机制
### objection和task phase
run_phase和12个动态运行的phase的objection机制，简单来说，run_phase独立于12个phase但是又是并行运行，12个phase中的objection控制着run_phase的运行时间，run_phase只能被动接受，反之，run_phase中的objection机制并不能影响12个phase的运行时间。  
先依次消灭12个phase中的objection，最后消灭run_phase的objection。  
### 参数phase的必要性
### 控制objection的最佳选择
一般来说，在一个实际的验证平台中，通常会在以下两种objection的控制策略中选择一种：  
第一种是在scoreboard中进行控制（fork...join_any）。  
第二种，如在第2章中介绍的例子那样，在sequence中提起sequencer的objection，当sequence完成后，再撤销此objection。  
### set_drain_time的使用
```systemverilog
task base_test::main_phase(uvm_phase phase);
  phase.phase_done.set_drain_time(this, 200);
endtask
```
drain_time属于uvm_objection的一个特性。如果只在main_phase中调用set_drain_time函数设置drain_time，但是在其他phase，如
configure_phase中没有设置，那么在configure_phase中所有的objection被撤销后，会立即进入post_configure_phase。换言之，一个
phase对应一个drain_time，并不是所有的phase共享一个drain_time。在没有设置的情况下，drain_time的默认值为0。  
### objection的调试
<sim command> +UVM_OBJECTION_TRACE  
## domain的应用

# 第六章 UVM中的sequence
## sequence基础
UVM为了解决设置和修改不同sequence问题，引入了sequence机制，在解决的过程中还使用了factory机制、config机制。使用sequence机制之后，在不同的测试用例中，将不同的sequence设置成sequencer的main_phase的default_sequence。当sequencer执行到main_phase时，发现有default_sequence，那么它就启动sequence。  
### sequence的启动与执行
直接启动：  
```systemverilog
my_sequence my_seq;
my_seq = my_sequence::type_id::create("my_seq");
my_seq.start(sequencer);
```
default_sequence启动:  
```systemverilog
uvm_config_db#(uvm_object_wrapper)::set(this,
"env.i_agt.sqr.main_phase",
"default_sequence",
case0_sequence::type_id::get());
```
当一个sequence启动后会自动执行sequence的body任务。其实，除了body外，还会自动调用sequence的pre_body与post_body  
## sequence的仲裁机制
### 在同一个sequencer上启动多个sequence
用fork join并行启动多个sequence  
可以通过uvm_do_pri及uvm_do_pri_with改变所产生的transaction的优先级  
```systemverilog
`uvm_do_pri(m_trans, 100)
`uvm_do_pri_with(m_trans, 200, {m_trans.pload.size < 500;})
```
要使优先级仲裁起作用需要设置sequencer的仲裁算法：  
```systemverilog
env.i_agt.sqr.set_arbitration(SEQ_ARB_STRICT_FIFO);
```
除transaction有优先级外，sequence也有优先级的概念  
```systemverilog
fork
  seq0.start(env.i_agt.sqr, null, 100);
  seq1.start(env.i_agt.sqr, null, 200);
join
```
### sequencer的lock操作
所谓lock，就是sequence向sequencer发送一个请求，这个请求与其他sequence发送transaction的请求一同被放入sequencer的仲裁队列中。当其前面的所有请求被处理完毕后，sequencer就开始响应这个lock请求，此后sequencer会一直连续发送此sequence的transaction，直到unlock操作被调用。  
```systemverilog
virtual task body();
…
  repeat (3) begin
  `uvm_do_with(m_trans, {m_trans.pload.size < 500;})
  `uvm_info("sequence1", "send one transaction", UVM_MEDIUM)
  end
  lock();
  `uvm_info("sequence1", "locked the sequencer ", UVM_MEDIUM)
  repeat (4) begin
  `uvm_do_with(m_trans, {m_trans.pload.size < 500;})
  `uvm_info("sequence1", "send one transaction", UVM_MEDIUM)
  end
  `uvm_info("sequence1", "unlocked the sequencer ", UVM_MEDIUM)
  unlock();
  repeat (3) begin
  `uvm_do_with(m_trans, {m_trans.pload.size < 500;})
  `uvm_info("sequence1", "send one transaction", UVM_MEDIUM)
end
…
54 endtask
```
### sequence的grab操作
与lock操作一样，grab操作也用于暂时拥有sequencer的所有权，只是grab操作比lock操作优先级更高。lock请求是被插入sequencer仲裁队列的最后面，等到它时，它前面的仲裁请求都已经结束了。grab请求则被放入sequencer仲裁队列的最前面，它几乎是一发出就拥有了sequencer的所有权  
可以这么说，lock是老弱病残用户，有序的优先权；grab是VIP用户，文明的占据。😄  
grab();和ungrab();
### sequence的有效性
sequencer在仲裁时，会查看sequence的is_relevant函数的返回结果。如果为1，说明此sequence有效，否则无效。  
除了is_relevant外，sequence中还有一个任务wait_for_relevant也与sequence的有效性相关：  
若全部的transaction都发送完毕。此时，没有可发送的transaction,sequencer发现sequence0无效，会调用其wait_for_relevant。也就是说，失效是自己控制，但是重新变得有效需要等其他transaction发完才行，如果其他transaction永远不结束那么sequence0将永远处于无效状态。
is_relevant与wait_for_relevant一般应成对重载，不能只重载其中的一个。  
wait_for_relevant是一种保护机制，如果自己的控制没有准确控制，那么出现没有transaction可发送的情况，触发保护机制。  
## sequence相关宏及其实现
### uvm_do系列宏
8个：  
```systemverilog
`uvm_do(SEQ_OR_ITEM)o
`uvm_do_pri(SEQ_OR_ITEM, PRIORITY)
`uvm_do_with(SEQ_OR_ITEM, CONSTRAINTS)
`uvm_do_pri_with(SEQ_OR_ITEM, PRIORITY, CONSTRAINTS)
`uvm_do_on(SEQ_OR_ITEM, SEQR)
`uvm_do_on_pri(SEQ_OR_ITEM, SEQR, PRIORITY)
`uvm_do_on_with(SEQ_OR_ITEM, SEQR, CONSTRAINTS)
`uvm_do_on_pri_with(SEQ_OR_ITEM, SEQR, PRIORITY, CONSTRAINTS)
```
uvm_do_on:用于显式地指定使用哪个sequencer发送此transaction。它有两个参数，第一个是transaction的指针，第二个是sequencer的指针。  
```systemverilog
`uvm_do_on_pri_with(tr, this, 100, {tr.pload.size == 100;})
```
uvm_do系列的其他七个宏其实都是用uvm_do_on_pri_with宏来实现的。  
### uvm_create与uvm_send
```systemverilog
virtual task body();
  int num = 0;
  int p_sz;
…
  repeat (10) begin
  num++;
  `uvm_create(m_trans)
  assert(m_trans.randomize());
  p_sz = m_trans.pload.size();
  {m_trans.pload[p_sz - 4],
   m_trans.pload[p_sz - 3],
   m_trans.pload[p_sz - 2],
   m_trans.pload[p_sz - 1]}
   = num;
  `uvm_send(m_trans)
  end
…
  endtask
```
uvm_send_pri:在将transaction交给sequencer时设定优先级  
### uvm_rand_send系列宏
```systemverilog
`uvm_rand_send(SEQ_OR_ITEM)
`uvm_rand_send_pri(SEQ_OR_ITEM, PRIORITY)
`uvm_rand_send_with(SEQ_OR_ITEM, CONSTRAINTS)
`uvm_rand_send_pri_with(SEQ_OR_ITEM, PRIORITY, CONSTRAINTS)
```
uvm_rand_send宏与uvm_send宏类似，唯一的区别是它会对transaction进行随机化。这个宏使用的前提是transaction已经被分配了空间，换言之，即已经实例化了。  
```systemverilog
m_trans = new("m_trans");
`uvm_rand_send_pri_with(m_trans, 100, {m_trans.pload.size == 100;})
```
### start_item与finish_item
```systemverilog
virtual task body();
…
  repeat (10) begin
  tr = new("tr");
  start_item(tr,100); //第二个参数为优先级
  assert(tr.randomize() with {tr.pload.size == 200;});
  finish_item(tr,100);
  end
…
endtask
```
### pre_do、mid_do与post_do
```systemverilog
sequencer.wait_for_grant(prior)   (task) \ start_item  \
parent_seq.pre_do(1)              (task) /              \
                                                    `uvm_do* macros
parent_seq.mid_do(item)           (func) \              /
sequencer.send_request(item)      (func)  \finish_item /
sequencer.wait_for_item_done()    (task)  /
parent_seq.post_do(item)          (func) /
```
## sequence的进阶应用
### 嵌套的sequence
```systemverilog
class case0_sequence extends uvm_sequence #(my_transaction);
…
  virtual task body();
    crc_seq cseq; //声明一个
    long_seq lseq;
…
    repeat (10) begin
    `uvm_do(cseq)  //包含实例化new
    `uvm_do(lseq)
  end
…
  endtask
…
endclass
```
### 在sequence中使用rand类型变量
在sequence中定义rand类型变量以向产生的transaction传递约束时，变量名字一定要与transaction中相应字段的名字不同。
### transaction类型的匹配
一个sequencer产生不同类型的transaction  
```systemverilog
class case0_sequence extends uvm_sequence;
  my_transaction m_trans;
  your_transaction y_trans;
…
  virtual task body();
…
    repeat (10) begin
      `uvm_do(m_trans)
      `uvm_do(y_trans)
    end
…
  endtask

  `uvm_object_utils(case0_sequence)
endclass
```
带给driver的选择问题就是必须用cast转换：
```systemverilog
task my_driver::main_phase(uvm_phase phase);
  my_transaction m_tr;
  your_transaction y_tr;
…
  while(1) begin
    seq_item_port.get_next_item(req);
    if($cast(m_tr, req)) begin
    drive_my_transaction(m_tr);
    `uvm_info("driver", "receive a transaction whose type is my_transaction",UVM_MEDIUM)
    end
    else if($cast(y_tr, req)) begin
    drive_your_transaction(y_tr);
    `uvm_info("driver", "receive a transaction whose type is your_transaction", UVM_MEDIUM)
    end
    else begin
    `uvm_error("driver", "receive a transaction whose type is unknown")
    end
    seq_item_port.item_done();
    end
endtask
```
**OK，需要总结一下，几个“多个不同”如何使用**  
1.一个sequencer,多个sequence,同一种transaction，需要使用仲裁机制相关的宏根据优先级来决定。以及相关的lock,grab，有效性等操作，主要是针对sequence之间的顺序问题。  
2.一个sequencer,一个sequence,不同的transaction,需要对driver进行cast操作分辨不同的transaction,主要针对一个sequence里面的数据类型。  

### p_sequencer的使用
m_sequencer是uvm_sequencer_base（uvm_sequencer的基类）类型的，而不是
my_sequencer类型的。  
uvm_declare_p_sequencer（SEQUENCER）。这个宏的本质是声明了一个SEQUENCER类型的成员变量，如在定义sequence时，使用此宏声明sequencer的类型  

### sequence的派生与继承
base_sequence可以将很多公用的函数或者任务写在base_sequence中。  

## virtual sequence的使用
### 带双路输入输出端口的DUT
声明两个env,并且两组input_if和output_if  
### sequence之间的简单同步
使用全局事件  
### sequence之间的复杂同步
**使用virtual sequence**  
<img width="1101" height="756" alt="image" src="https://github.com/user-attachments/assets/6c926c67-7a95-409d-a9ae-9b79a99de2a0" />  
```systemverilog
class my_vsqr extends uvm_sequencer;
  my_sequencer p_sqr0;
  my_sequencer p_sqr1;
…
endclass

class base_test extends uvm_test;

  my_env env0;
  my_env env1;
  my_vsqr v_sqr;
…
endclass

function void base_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  env0 = my_env::type_id::create("env0", this);
  env1 = my_env::type_id::create("env1", this);
  v_sqr = my_vsqr::type_id::create("v_sqr", this);
endfunction

function void base_test::connect_phase(uvm_phase phase);
  v_sqr.p_sqr0 = env0.i_agt.sqr;
  v_sqr.p_sqr1 = env1.i_agt.sqr;
endfunction

class case0_vseq extends uvm_sequence;
  `uvm_object_utils(case0_vseq)
  `uvm_declare_p_sequencer(my_vsqr)
…
  virtual task body();
  my_transaction tr;
  drv0_seq seq0;
  drv1_seq seq1;
…
  `uvm_do_on_with(tr, p_sequencer.p_sqr0, {tr.pload.size == 1500;})
  `uvm_info("vseq", "send one longest packet on p_sequencer.p_sqr0", UVM_MEDIUM)
  fork
  `uvm_do_on(seq0, p_sequencer.p_sqr0);
  `uvm_do_on(seq1, p_sequencer.p_sqr1);
  join
…
  endtask
endclass
```
  

### 仅在virtual sequence中控制objection
除了手工启动sequence时为starting_phase赋值外，只有将此sequence作为sequencer的某动态运行phase的default_sequence时，其starting_phase才不为null。如果将某sequence作为uvm_do宏的参数，那么此sequence中的starting_phase是为null的。在此sequence中使用starting_phase.raise_objection是没有任何用处的。  
换言之，要使starting_phase才不为null有效，要么在default_sequence中启动sequence，如果sequencer很多要用virtual sequence统一启动，那么这个starting_phase会无效，我们应该
在最顶层的virtual sequence中控制objection。  

### 在sequence中慎用fork join_none

## 在sequence中使用config_db

### 获取参数
```systemverilog
uvm_config_db#(int)::set(this, "env.i_agt.sqr.*", "count", 9);

uvm_config_db#(int)::get(null, get_full_name(), "count", count)
```
### 设置参数
```systemverilog
uvm_config_db#(bit)::set(uvm_root::get(), "uvm_test_top.env0.scb", "cmp_en", 0);
```

### wait_modified的使用
UVM中提供了wait_modified任务，它的参数有三个，与config_db：：get的前三个参数完
全一样。当它检测到第三个参数的值被更新过后，它就返回，否则一直等待在那里。  
```systemverilog
fork
  while(1) begin
  uvm_config_db#(bit)::wait_modified(this, "", "cmp_en");
  void'(uvm_config_db#(bit)::get(this, "", "cmp_en", cmp_en));
  `uvm_info("my_scoreboard", $sformatf("cmp_en value modified, the new value is %0d", cmp_en),
  end
join
```
## response的使用

### put_response和get_response
```systemverilog
virtual task body();
…
  repeat (10) begin
    `uvm_do(m_trans)
    get_response(rsp);
    `uvm_info("seq", "get one response", UVM_MEDIUM)
    rsp.print();
  end
…
endtask


task my_driver::main_phase(uvm_phase phase);
…
  while(1) begin
  seq_item_port.get_next_item(req);
  drive_one_pkt(req);
  rsp = new("rsp");
  rsp.set_id_info(req);
  seq_item_port.put_response(rsp);
  seq_item_port.item_done();
  end
endtask
```
除了使用put_response外，UVM还支持直接将response作为item_done的参数
```systemverilog
seq_item_port.item_done(rsp);
```
### response handler与另类的response

### rsp与req类型不同

## sequence library
### 随机选择sequence
```systemverilog
class simple_seq_library extends uvm_sequence_library#(my_transaction);
  function new(string name= "simple_seq_library");
    super.new(name);
    init_sequence_library();
  endfunction

  `uvm_object_utils(simple_seq_library)
  `uvm_sequence_library_utils(simple_seq_library);

endclass
```
在定义sequence library时有三点要特别注意：一是从uvm_sequence派生时要指明此sequence library所产生的transaction类型，这点与普通的sequence相同；二是在其new函数中要调用init_sequence_library，否则其内部的候选sequence队列就是空的；三是要调用uvm_sequence_library_utils注册。  
一个sequence在定义时使用宏uvm_add_to_seq_lib来将其加入某个sequence library中：  
```
class seq0 extends uvm_sequence#(my_transaction);
…systemverilog
  `uvm_object_utils(seq0)
  `uvm_add_to_seq_lib(seq0, simple_seq_library)
  virtual task body();
    repeat(10) begin
      `uvm_do(req)
      `uvm_info("seq0", "this is seq0", UVM_MEDIUM)
    end
  endtask
endclass
```
一个sequence可以加入多个不同的sequence library中：  
```
`uvm_add_to_seq_lib(seq0, simple_seq_library)
`uvm_add_to_seq_lib(seq0, hard_seq_library)
```
当sequence与sequence library定义好后，可以将sequence library作为sequencer的default sequence  
```systemverilog
function void my_case0::build_phase(uvm_phase phase);
  super.build_phase(phase);

  uvm_config_db#(uvm_object_wrapper)::set(this,
                                    "env.i_agt.sqr.main_phase",
                                    "default_sequence",
                                    simple_seq_library::type_id::get());
endfunction
```
### 控制选择算法
sequence library随机从其sequence队列中选择几个执行。这是由其变量selection_mode决定的
uvm_sequence_lib_mode selection_mode;  
```systemverilog
typedef enum
{
UVM_SEQ_LIB_RAND,
UVM_SEQ_LIB_RANDC,
UVM_SEQ_LIB_ITEM,
UVM_SEQ_LIB_USER
} uvm_sequence_lib_mode;
```
修改UVM_SEQ_LIB_RAND为UVM_SEQ_LIB_RANDC  
```systemverilog
function void my_case0::build_phase(uvm_phase phase);
…
  uvm_config_db#(uvm_sequence_lib_mode)::set(this,
                                    "env.i_agt.sqr.main_phase",
                                    "default_sequence.selection_mode",
                                    UVM_SEQ_LIB_RANDC);
endfunction
```
### 控制执行次数
```systemverilog
uvm_config_db#(int unsigned)::set(this,
  "env.i_agt.sqr.main_phase",
  "default_sequence.min_random_count",
  5);
uvm_config_db#(int unsigned)::set(this,
  "env.i_agt.sqr.main_phase",
  "default_sequence.max_random_count",
  20);
```
### 使用sequence_library_cfg
sequence_library_cfg  
```systemverilog
class uvm_sequence_library_cfg extends uvm_object;
  `uvm_object_utils(uvm_sequence_library_cfg)
  uvm_sequence_lib_mode selection_mode;
  int unsigned min_random_count;
  int unsigned max_random_count;
…
endclass
```
eg.  
```systemverilog
function void my_case0::build_phase(uvm_phase phase);
  uvm_sequence_library_cfg cfg;
  super.build_phase(phase);
  cfg = new("cfg", UVM_SEQ_LIB_RANDC, 5, 20);

  uvm_config_db#(uvm_object_wrapper)::set(this,
                                  "env.i_agt.sqr.main_phase",
                                  "default_sequence",
                                  simple_seq_library::type_id::get());
uvm_config_db#(uvm_sequence_library_cfg)::set(this,
                                  "env.i_agt.sqr.main_phase",
                                  "default_sequence.config",
                                  cfg);
endfunction
```
简单的配置方法--实例化后赋值  
```systemverilog
function void my_case0::build_phase(uvm_phase phase);
  simple_seq_library seq_lib;
  super.build_phase(phase);

  seq_lib = new("seq_lib");
  seq_lib.selection_mode = UVM_SEQ_LIB_RANDC;
  seq_lib.min_random_count = 10;
  seq_lib.max_random_count = 15;
  uvm_config_db#(uvm_sequence_base)::set(this,
                                  "env.i_agt.sqr.main_phase",
                                  "default_sequence",
                                  seq_lib);
endfunction
```
**OK，我们来总结一下，不同sequence场景下的启动方式**  
|sequencer数量|sequence数量|启动方式|  
|:---:|:---:|:---:|  
|1|1|start直接启动,default_sequence启动|  
|1|>1|start逐个启动，default_sequence逐个启动，virtual sequence，sequence library|
|>1|>1|start启动，default_sequence启动，virtual sequence(指定好sequencer对应的参数)|  

# 第七章 UVM中的寄存器模型
这里指的DUT参数指的是DUT内部的寄存器。
## 寄存器模型简介
DUT中除了input和output的reg,即中间变量  
```systemverilog
task my_model::main_phase(uvm_phase phase);
…
reg_model.INVERT_REG.read(status, value, UVM_FRONTDOOR);
…
endtask
```
只能启动sequence通过前门（FRONTDOOR）访问的方式来读取寄存器，局限较大，在
scoreboard（或者其他component）中难以控制。而有了寄存器模型之后，scoreboard只与寄存器模型打交道，无论是发送读的指令还是获取读操作的返回值，都可以由寄存器模型完成。有了寄存器模型后，可以在任何耗费时间的phase中使用寄存器模型以前门访问或后门（BACKDOOR）访问的方式来读取寄存器的值，同时还能在某些不耗费时间的phase（如check_phase）中使用后门访问的方式来读取寄存器的值。  
|uvm_reg_field|uvm_reg|uvm_reg_block|uvm_reg_map|  
|:---:|:---:|:---:|:---:|  
|最小单位|小单位，比uvm_reg_field高一个级别，一个寄存器至少包含一个|大单位，可以加入uvm_reg或者uvm_reg_block。至少包含一个|存储寄存器地址，转换成可访问的物理地址（绝对地址）|  
## 简单的寄存器模型
```systemverilog
class reg_invert extends uvm_reg;

  rand uvm_reg_field reg_data;

  virtual function void build();
    reg_data = uvm_reg_field::type_id::create("reg_data");
    // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually
    reg_data.configure(this, 1, 0, "RW", 1, 0, 1, 1, 0);
  endfunction

  `uvm_object_utils(reg_invert)

  function new(input string name="reg_invert");
    //parameter: name, size, has_coverage
    super.new(name, 16, UVM_NO_COVERAGE);
  endfunction
endclass
```
config参数说明：  
|||
|:---:|:---:|
|parent|此域的父辈|
|size|宽度|
|lsb_pos|最低位在整个寄存器的位置，0开始|
|access|25种存取方式，RO、RW、RC、RS... 支持自定义|
|volatitle|一般不使用，1|
|reset value|上电复位后的默认值，例如复位低电平有效，这边就是0|
|has_reset|是否有复位，一般有，1|
|is_rand|是否可以随机化，当且仅当第四个参数为RW、WRC、WRS、WO、W1、WO1时才有效|
|individually|是否可以单独存取|  

```systemverilog
class reg_model extends uvm_reg_block;
  rand reg_invert invert;

  virtual function void build();
    default_map = create_map("default_map", 0, 2, UVM_BIG_ENDIAN, 0);

    invert = reg_invert::type_id::create("invert", , get_full_name());
    invert.configure(this, null, "");
    invert.build();
    default_map.add_reg(invert, 'h9, "RW");
  endfunction

  `uvm_object_utils(reg_model)

  function new(input string name="reg_model");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

endclass
```
create_map有众多的
参数，其中第一个参数是名字，第二个参数是基地址，第三个参数则是系统总线的宽度，这里的单位是byte而不是bit，第四个参数是大小端，最后一个参数表示是否能够按照byte寻址。  


最后一步则是将此寄存器加入default_map中。uvm_reg_map的作用是存储所有寄存器的地址，因此必须将实例化的寄存器加入default_map中，否则无法进行前门访问操作。add_reg函数的第一个参数是要加入的寄存器，第二个参数是寄存器的地址，这里是16’h9，第三个参数是此寄存器的存取方式。

### 在验证平台中使用寄存器模型
<img width="1077" height="696" alt="image" src="https://github.com/user-attachments/assets/416494d4-a0c5-407b-8afb-2e8923016e91" />  

必须要有一个转换器adapter并且定义好两个函数reg2bus和bus2reg：  
```systemverilog
`ifndef MY_ADAPTER__SV 
`define MY_ADAPTER__SV 
class my_adapter extends uvm_reg_adapter;
    string tID = get_type_name();

    `uvm_object_utils(my_adapter)

   function new(string name="my_adapter");
      super.new(name);
   endfunction : new

   function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
      bus_transaction tr;
      tr = new("tr"); 
      tr.addr = rw.addr;
      tr.bus_op = (rw.kind == UVM_READ) ? BUS_RD: BUS_WR;
      if (tr.bus_op == BUS_WR)
         tr.wr_data = rw.data; 
      return tr;
   endfunction : reg2bus

   function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
      bus_transaction tr;
      if(!$cast(tr, bus_item)) begin
         `uvm_fatal(tID,
          "Provided bus_item is not of the correct type. Expecting bus_transaction")
          return;
      end
      rw.kind = (tr.bus_op == BUS_RD) ? UVM_READ : UVM_WRITE;
      rw.addr = tr.addr;
      rw.byte_en = 'h3;
      rw.data = (tr.bus_op == BUS_RD) ? tr.rd_data : tr.wr_data;
      rw.status = UVM_IS_OK;
   endfunction : bus2reg

endclass : my_adapter
`endif
```



```systemverilog
`ifndef MY_MODEL__SV
`define MY_MODEL__SV

class my_model extends uvm_component;
   
   uvm_blocking_get_port #(my_transaction)  port;
   uvm_analysis_port #(my_transaction)  ap;

   reg_model p_rm;
   extern function new(string name, uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern virtual  task main_phase(uvm_phase phase);
   extern virtual  function void invert_tr(my_transaction tr);

   `uvm_component_utils(my_model)
endclass 

function my_model::new(string name, uvm_component parent);
   super.new(name, parent);
endfunction 

function void my_model::build_phase(uvm_phase phase);
   super.build_phase(phase);
   port = new("port", this);
   ap = new("ap", this);
endfunction

function void my_model::invert_tr(my_transaction tr);
    tr.dmac = tr.dmac ^ 48'hFFFF_FFFF_FFFF;
    tr.smac = tr.smac ^ 48'hFFFF_FFFF_FFFF;
    tr.ether_type = tr.ether_type ^ 16'hFFFF;
    tr.crc = tr.crc ^ 32'hFFFF_FFFF;
    for(int i = 0; i < tr.pload.size; i++)
      tr.pload[i] = tr.pload[i] ^ 8'hFF;
endfunction

task my_model::main_phase(uvm_phase phase);
   my_transaction tr;
   my_transaction new_tr;
   uvm_status_e status;
   uvm_reg_data_t value;
   super.main_phase(phase);
   p_rm.invert.read(status, value, UVM_FRONTDOOR); //读取值到value
   while(1) begin
      port.get(tr);
      new_tr = new("new_tr");
      new_tr.copy(tr);
      //`uvm_info("my_model", "get one transaction, copy and print it:", UVM_LOW)
      //new_tr.print();
      if(value)
         invert_tr(new_tr);
      ap.write(new_tr);
   end
endtask
`endif
```

```systemverilog
extern virtual task read(output uvm_status_e status,
						output uvm_reg_data_t value,
						input uvm_path_e path = UVM_DEFAULT_PATH,
						input uvm_reg_map map = null,
						input uvm_sequence_base parent = null,
						input int prior = -1,
						input uvm_object extension = null,
						input string fname = "",
						input int lineno = 0);
```
```systemverilog
extern virtual task write(output uvm_status_e status,
						input uvm_reg_data_t value,
						input uvm_path_e path = UVM_DEFAULT_PATH,
						input uvm_reg_map map = null,
						input uvm_sequence_base parent = null,
						input int prior = -1,
						input uvm_object extension = null,
						input string fname = "",
						input int lineno = 0);
```

## 后门访问与前门访问

### 前门访问
所谓前门访问操作就是通过寄存器配置总线（如APB协议、OCP协议、I2C协议等）来对DUT进行操作。无论在任何总线协议中，前门访问操作只有两种：读操作和写操作。  


### 后门访问
后门访问是与前门访问相对的操作，从广义上来说，所有不通过DUT的总线而对DUT内部的寄存器或者存储器进行存取的操作都是后门访问操作。所有后门访问操作都是不消耗仿真时间（即$time打印的时间）而只消耗运行时间的。这是后门访问操作的最大优势。  

### 使用interface进行后门访问操作

在interface中定义函数  

### UVM中后面访问操作的实现：DPI+VPI
**DPI-C**












# 第八章 UVM中的factory机制
## SystemVerilog对重载的支持
### 任务与函数的重载
当在父类中定义一个函数/任务时，如果将其设置为virtual类型，那么就可以在子类中重载这个函数/任务  
```systemverilog
class bird extends uvm_object;
  virtual function void hungry();
    $display("I am a bird, I am hungry");
  endfunction
  function void hungry2();
    $display("I am a bird, I am hungry2");
  endfunction
…
endclass

class parrot extends bird;
  virtual function void hungry();
    $display("I am a parrot, I am hungry");
  endfunction
  function void hungry2();
    $display("I am a parrot, I am hungry2");
  endfunction
…
endclass
```
```systemverilog
function void my_case0::print_hungry(bird b_ptr);
  b_ptr.hungry();
  b_ptr.hungry2();
endfunction

function void my_case0::build_phase(uvm_phase phase);
  bird bird_inst;
  parrot parrot_inst;
  super.build_phase(phase);

  bird_inst = bird::type_id::create("bird_inst");
  parrot_inst = parrot::type_id::create("parrot_inst");
  print_hungry(bird_inst);
  print_hungry(parrot_inst);
endfunction
/////////////////////////////
//"I am a bird, I am hungry"
//"I am a bird, I am hungry2"
/////////////////////////////
//"I am a parrot, I am hungry"
//"I am a bird, I am hungry2"
/////////////////////////////
```
这种函数/任务重载的功能在UVM中得到了大量的应用。其实最典型的莫过于各个phase。当各个phase被调用时，以build_phase为例，实际上系统是使用如下的方式调用：  
```systemverilog
c_ptr.build_phase();
```
这表示uvm_component基类中有build_phase()这个函数，在子类中不断地virtual,而super作用是调用父类的函数，所以调用最终以父类的函数原型实现自身子类的功能。  
至于如何形成验证环境的树状结构，就需要依靠子类build_phase中的实例化操作指定父类了。  
### 约束的重载
在测试一个接收MAC功能的DUT时，有多种异常情况需要测试，如preamble错误、sfd错误、CRC错误等。针对这些错误，在transaction中分别加入标志位，然后在针对标志位编写函数。
```systemverilog
uvm_do_with(tr, {tr.crc_err == 0; sfd_err == 0; pre_err == 0;})
```
每次产生transaction都要约束，比较麻烦。  
两种方法：  
1.定义错误为一种约束，通过控制约束的开关m_trans.crc_err_cons.constraint_mode(0)，然后使用\`uvm_rand_send_with宏去发送。  
打开约束为正常发送，关闭约束为异常发送。（其中tr需要实例化，不然会报错）  
2.约束重载，在基础transaction上派生一个新的transaction,然后直接用普通\`uvm_do宏启动  
```systemverilog
class new_transaction extends my_transaction;
    `uvm_object_utils(new_transaction)
    function new(string name= "new_transaction");
      super.new(name);
    endfunction

    constraint crc_err_cons{
    crc_err dist {0 := 2, 1 := 1};
    }
endclass
```
## 使用factory机制进行重载
### factory机制式的重载
```systemverilog
function void my_case0::build_phase(uvm_phase phase);
…
  set_type_override_by_type(bird::get_type(), parrot::get_type());

  bird_inst = bird::type_id::create("bird_inst");
  parrot_inst = parrot::type_id::create("parrot_inst");
  print_hungry(bird_inst);
  print_hungry(parrot_inst);
endfunction
/////////////////////////////
//"I am a parrot, I am hungry"
//"I am a bird, I am hungry2"
//"I am a parrot, I am hungry"
//"I am a bird, I am hungry2"
/////////////////////////////
```
为什么会导致以上的输出结果?🍋
<img width="1115" height="746" alt="image" src="https://github.com/user-attachments/assets/15c93650-cab0-4acd-abce-910ace18e827" />  
<img width="1129" height="753" alt="image" src="https://github.com/user-attachments/assets/b7d47403-b706-4caf-8dad-aea5371cb081" />  
这是因为bird_inst使用了UVM的factory机制式的实例化方式：`bird_inst = bird::type_id::create("bird_inst");`  
**当考虑此component需要重载时用这种方式实例化**
在实例化时，UVM会通过factory机制在自己内部的一张表格中查看是否有相关的重载记录。`set_type_override_by_type`语句相当于在factory机制的表格中加入了一条记录。当查到有重载记录时，会使用新的类型来替代旧的类型。  
使用factory机制的重载是有前提的，并不是任意的类都可以互相重载。要想使用重载的功能，必须满足以下要求：  
1.无论是重载的类还是被重载的类，都要在定义时注册到factory机制中。  
2.被重载的类在实例化时，要使用factory机制式的实例化方式，而不能使用传统的new方式。  
3.最重要的是，重载的类要与被重载的类有派生关系。重载的类必须派生自被重载的类，被重载的类必须是重载类的父类。  
4.component与object之间互相不能重载。虽然uvm_component是派生自uvm_object,但是这两者的血缘关系太远了，远到根本不能重载。从两者的new参数的函数就可以看出来，二者互相重载时，多出来的一个parent参数会使factory机制无所适从。  

### 重载的方式及种类
`set_type_override_by_type(uvm_object_wrapper original_type, uvm_object_wrapper override_type, bit replace=1);  `
只重载一部分：  
`set_inst_override_by_type(string relative_inst_path, uvm_object_wrapper original_type, uvm_object_wrapper override_type);`
无论是set_type_override_by_type还是set_inst_override_by_type，它们的参数都是一个uvm_object_wrapper型的类型参数，这种参数通过`xxx：：get_type（）`的形式获得。  
另一种简单的写法  
|set_type_override_by_type|set_type_override|
|:---:|:---:|
|set_inst_override_by_type|set_inst_override|  

上面的四种函数都是uvm_component的函数，但是如果在一个无法使用component的地方，如top_tb的initial语句里，就无法使用。为此UVM提供了另外的四种函数。  

|function|eg|
|:---:|:---:|
|set_type_override_by_type (uvm_object_wrapper original_type,uvm_object_wrapper override_type,bit replace=1);||
|set_inst_override_by_type (uvm_object_wrapper original_type,uvm_object_wrapper override_type,string full_inst_path);||
|set_type_override_by_name (string original_type_name,string override_type_name,bit replace=1);||
|set_inst_override_by_name (string original_type_name,string override_type_name,string full_inst_path);||
```systemverilog
initial begin
  factory.set_type_override_by_type(bird::get_type(), parrot::get_type()); //factory是全局变量
end
```
命令行重载
```
<sim command> +uvm_set_inst_override=<req_type>,<override_type>,<full_inst_path>
<sim command> +uvm_set_type_override=<req_type>,<override_type>[,<replace>]
////////////////////////////////////////////////////////////////
<sim command> +uvm_set_inst_override="my_monitor,new_monitor,uvm_test_top.env.o_agt.mon"
/////////////////////////////////////////////////////////////////
<sim command> +uvm_set_type_override="my_monitor,new_monitor"
```
### 复杂的重载
1.连续重载，B重载A,C又重载B，A实例化最终是C。  
2.替换重载，B重载A，C也重载A，按最新的重载记录，A实例化最终是C。  

### factory机制的调试
UVM提供了`print_override_info`和`debug_create_by_name`(全局变量factory)函数来输出所有的打印信息  
```systemverilog
function void my_case0::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	env.o_agt.mon.print_override_info("my_monitor");
endfunction
```
```systemverilog
factory.debug_create_by_type(my_monitor::get_type(), "uvm_test_top.env.o_agt.mon");
```
除了上述两个，还有`print`函数以及uvm_root的`print_topology`函数。值得一提的是，`print_topology`函数在build_phase之后调用来显示出整棵UVM树的拓扑结构。  

## 常用的重载
### 重载transaction
原先的方式：创造一个新的err_transaction，然后一个新的sequence,最后default_sequence启动，而现在利用重载只需要：  
```systemverilog
function void my_case0::build_phase(uvm_phase phase);
	super.build_phase(phase);

	factory.set_type_override_by_type(my_transaction::get_type(), crc_err_tr::get_type());
	uvm_config_db#(uvm_object_wrapper)::set(this,
									"env.i_agt.sqr.main_phase",
									"default_sequence",
									normal_sequence::type_id::get());
endfunction
```
这样就不需要再额外生成一个新的sequence  

### 重载sequence
如果使用约束的重载，在sequence中通过`m_trans.crc_err_cons.constraint_mode(0);`控制,则同样在default_sequence之前重载sequence  
```systemverilog
function void my_case0::build_phase(uvm_phase phase);
…
	factory.set_type_override_by_type(normal_sequence::get_type(), abnorma l_sequence::get_type());
	uvm_config_db#(uvm_object_wrapper)::set(this,
							"env.i_agt.sqr.main_phase",
							"default_sequence",
							case_sequence::type_id::get());
endfunction
```
### 重载component
甚至可以重载driver达到产生错误测试用例的目的，这就是UVM!!!☑️☑️☑️  
```systemverilog
class crc_driver extends my_driver;
…
	virtual function void inject_crc_err(my_transaction tr);
		tr.crc = $urandom_range(10000000, 0);
	endfunction

	virtual task main_phase(uvm_phase phase);
		vif.data <= 8'b0;
		vif.valid <= 1'b0;
		while(!vif.rst_n)
			@(posedge vif.clk);
		while(1) begin
			seq_item_port.get_next_item(req);
			inject_crc_err(req);
			drive_one_pkt(req);
			seq_item_port.item_done();
		end
	endtask
endclass
```
依旧是在my_case0(base_test)中重载
```systemverilog
factory.set_type_override_by_type(my_driver::get_type(), crc_driver::get_type());
```
**OK,让我们总结一下**  
||transaction|sequence|driver|
|:---:|:---:|:---:|:---:|
|transaction重载|2(添加约束)|1|1|
|sequence重载|1|2（关闭约束功能）|1|
|driver重载|1|1|2（函数改tr数值）|

## factory机制的实现
从本质上来看，factory机制其实是对SystemVerilog中new函数的重载。因为这个原始的new函数实在是太简单了，功能太少了。经过factory机制的改良之后，进行实例化的方法多了很多。这也体现了UVM编写的一个原则，一个好的库应该提供更多方便实用的接口，这种接口一方面是库自己写出来并开放给用户的，另外一方面就是改良语言原始的接口，使得更加方便用户的使用。

# 第九章 UVM中代码的可重用性

## callback机制

### 广义的callback机制
UVM已经给用户提供了一些广义的callback函数/任务：pre_body和post_body，除此之外还有pre_do、mid_do和post_do。

### callback机制的必要性
在没有factory机制的重载功能之前，使用callback函数构建异常测试用例是最好的实现方式。

### UVM中callback机制的原理
不考虑使用factory机制的重载功能情况下，callback机制的原理是派生另一个类（非driver这种component）,然后重写派生类中的函数（如pre_tran（））。  

### callback机制的使用

定义类A：  
```systemverilog
class A extends uvm_callback;
	virtual task pre_tran(my_driver drv, ref my_transaction tr);
	endtask
endclass
```
声明一个A_pool类：  
```systemverilog
typedef uvm_callbacks#(my_driver, A) A_pool;
```
将此pool声明为my_driver专用：
```systemverilog
typedef class A;

class my_driver extends uvm_driver#(my_transaction);
…
	`uvm_component_utils(my_driver)
	`uvm_register_cb(my_driver, A)
…
endclass
```
在my_driver的main_phase中调用pre_tran：  
```systemverilog
task my_driver::main_phase(uvm_phase phase);
…
	while(1) begin
		seq_item_port.get_next_item(req);
		`uvm_do_callbacks(my_driver, A, pre_tran(this, req))
		drive_one_pkt(req);
		seq_item_port.item_done();
	end
endtask
```
**以上是VIP开发者要做的事情，使用者需要做以下事情**  
从A派生一个类：  
```systemverilog
class my_callback extends A;

	virtual task pre_tran(my_driver drv, ref my_transaction tr);
		`uvm_info("my_callback", "this is pre_tran task", UVM_MEDIUM)
	endtask

	`uvm_object_utils(my_callback)
endclass
```
将my_callback实例化，并加入A_pool中：  
```systemverilog
function void my_case0::connect_phase(uvm_phase phase);
	my_callback my_cb;
	super.connect_phase(phase);

	my_cb = my_callback::type_id::create("my_cb");
	A_pool::add(env.i_agt.drv, my_cb);
endfunction
```
本节的my_driver是自己写的，my_case0也是自己写的。完全不存在VIP与VIP使用者的情况。不过换个角度来说，可能有两个验证人员共同开发一个项目，一个负责搭建测试平台（testbench）及my_driver等的代码，另外一位负责创建测试用例。负责搭建测试平台的验证人员为搭建测试用例的人员留下了callback函数/任务接口。即使my_driver与测试用例都由同一个人来写，也是完全可以接受的。因为不同的测试用例肯定会引起不同的driver的行为。这些不同的行为差异可以在sequence中实现，也可以在driver中实现。在driver中实现时既可以用driver的factory机制重载，也可以使用本节所讲的callback机制。9.1.6节将探讨只使用callback机制来搭建所有测试用例的可能。

### 子类继承父类的callback机制
```systemverilog
class new_driver extends my_driver;
	`uvm_component_utils(new_driver)
	`uvm_set_super_type(new_driver, my_driver)
…
endclass

task new_driver::main_phase(uvm_phase phase);
…
	while(1) begin
		seq_item_port.get_next_item(req);
		`uvm_info("new_driver", "this is new driver", UVM_MEDIUM)
		`uvm_do_callbacks(my_driver, A, pre_tran(this, req))
		drive_one_pkt(req);
		seq_item_port.item_done();
	end
endtask
```

### 使用callback函数/任务来实现所有的测试用例

### callback机制、sequence机制、factory机制
callback机制、sequence机制和factory机制并不是互斥的，三者都能分别实现同一目的。当这三者互相结合时，又会产生许多新的解决问题的方式。如果在建立验证平台和测试用例时，能够择优选择其中最简单的一种实现方式，那么搭建出来的验证平台一定是足够强大、足够简练的。实现同一事情有多种方式，为用户提供了多种选择，高扩展性是UVM取得成功的一个重要原因。  

## 功能的模块化：小而美

避免大量复制，使用继承。  
放弃建造强大sequence的想法  

## 参数化的类

注册需要参数化注册。  
interface中可用参数化。  
config_db机制  
sequence机制  

## 模块级到芯片级的代码重用

### 基于env的重用

### 寄存器模型的重用

### virtual sequence与virtual sequencer

# 第十章 UVM高级应用

## interface

添加函数和任务，可以用always和initial、assign语句，实例化其他interface  

**可变时钟**：  
要实现第一种可变的时钟(每个case时钟不一样)，可以使用config_db，在测试用例中设置时钟周期：  
```systemverilog
function void my_case0::build_phase(uvm_phase phase);
…
	uvm_config_db#(real)::set(this, "", "clk_half_period", 200.0);
endfunction
```
```systemverilog
initial begin
	static real clk_half_period = 100.0;
	clk = 0;
	#1;
	if(uvm_config_db#(real)::get(uvm_root::get(), "uvm_test_top", "clk_half_period", clk_half_period))
		`uvm_info("top_tb", $sformatf("clk_half_period is %0f", clk_half_per iod), UVM_MEDIUM)
	forever begin
		#(clk_half_period*1.0ns) clk = ~clk;
	end
end
```
第二种（同一个case时钟有变化）：  
wait_modified监控时钟参数的变化  
第三种（component完全体）：  

## layer sequence

### layer sequence的示例
端口连接两个sequencer,模仿driver在主sequencer中从次sequencer获取transaction数据。总之通过这种方式可以细致化创建想要的sequence。  

### layer sequence与try_next_item

### 错峰技术的使用

## sequence的其他问题


## DUT参数的随机化
这里指的DUT参数指的是DUT内部的寄存器参数，而不是parameter,parameter在编译时就需要确定，仿真阶段不可更改。
### 使用寄存器模型随机化参数


### 使用单独的参数类
针对DUT中需要随机化的参数建立一个dut_parm类，并在其中指定默认约束并定义函数write  

## 聚合参数
UVM中的参数有两种一种是DUT内部的寄存器参数，还有一种是验证环境需要的参数（config_db）。

验证环境的参数如果非常多的情况下，就需要将这些参数放进一个专门的类里面来实现：  
```systemverilog
class my_config extends uvm_object;
	rand int var1;
…
	rand int var1000;
	constraint default_cons{
		var1 = 7;
…
		var1000 = 999;
	}
	`uvm_object_utils_begin(my_config)
		`uvm_field_int(var1, UVM_ALL_ON)
…
		`uvm_field_int(var1000, UVM_ALL_ON)
	`uvm_object_utils_end
endclass
```
base_test中这么写：  
```systemverilog
classs base_test extends uvm_test;
	my_config cfg;
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		cfg = my_config::type_id::create("cfg");
		uvm_config_db#(my_config)::set(this, "env.i_agt.drv", "cfg", cfg);
		uvm_config_db#(my_config)::set(this, "env.i_agt.mon", "cfg", cfg);
…
	endfunction
endclass
```
在driver中就直接get并且使用其中的数值就行。  

### 聚合参数的优势和问题
聚合参数这个类可以放在virtual sequence中，这样，当sequence要动态地改变某个验证平台中的变量值，可以改变。


问题：降低可重用性。agent级别重用时实例化聚合参数导致90%在env级别的参数多余。  

## config_db


























