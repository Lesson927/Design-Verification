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
```
`define uvm_field_int(ARG,FLAG) 整数  
`define uvm_field_real(ARG,FLAG) 实数  
`define uvm_field_enum(T,ARG,FLAG) 枚举类型  
`define uvm_field_object(ARG,FLAG) object  
`define uvm_field_event(ARG,FLAG) 事件  
`define uvm_field_string(ARG,FLAG) 字符串
```
与动态数组有关的uvm_field系列宏有：  
```
`define uvm_field_array_enum(ARG,FLAG)
`define uvm_field_array_int(ARG,FLAG)
`define uvm_field_array_object(ARG,FLAG)
`define uvm_field_array_string(ARG,FLAG)
```
与静态数组相关的uvm_field系列宏有：  
```
`define uvm_field_sarray_int(ARG,FLAG)
`define uvm_field_sarray_enum(ARG,FLAG)
`define uvm_field_sarray_object(ARG,FLAG)
`define uvm_field_sarray_string(ARG,FLAG)
```
与队列相关的uvm_field系列宏有：  
```
`define uvm_field_queue_enum(ARG,FLAG)
`define uvm_field_queue_int(ARG,FLAG)
`define uvm_field_queue_object(ARG,FLAG)
`define uvm_field_queue_string(ARG,FLAG)
```
与联合数组相关的uvm_field宏有：  
```
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

```
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

```
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
```
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
```
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

```
function void my_env::connect_phase(uvm_phase phase);
super.connect_phase(phase);
A_inst.A_port.connect(B_inst.B_export);
endfunction
```

### IMP
UVM中的IMP：  
```
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
```
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
```
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
```
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
```
my_sequence my_seq;
my_seq = my_sequence::type_id::create("my_seq");
my_seq.start(sequencer);
```
default_sequence启动:  
```
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
```
`uvm_do_pri(m_trans, 100)
`uvm_do_pri_with(m_trans, 200, {m_trans.pload.size < 500;})
```
要使优先级仲裁起作用需要设置sequencer的仲裁算法：  
```
env.i_agt.sqr.set_arbitration(SEQ_ARB_STRICT_FIFO);
```
除transaction有优先级外，sequence也有优先级的概念  
```
fork
  seq0.start(env.i_agt.sqr, null, 100);
  seq1.start(env.i_agt.sqr, null, 200);
join
```
### sequencer的lock操作
所谓lock，就是sequence向sequencer发送一个请求，这个请求与其他sequence发送transaction的请求一同被放入sequencer的仲裁队列中。当其前面的所有请求被处理完毕后，sequencer就开始响应这个lock请求，此后sequencer会一直连续发送此sequence的transaction，直到unlock操作被调用。  
```
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
```
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
```
`uvm_do_on_pri_with(tr, this, 100, {tr.pload.size == 100;})
```
uvm_do系列的其他七个宏其实都是用uvm_do_on_pri_with宏来实现的。  
### uvm_create与uvm_send
```
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
```
`uvm_rand_send(SEQ_OR_ITEM)
`uvm_rand_send_pri(SEQ_OR_ITEM, PRIORITY)
`uvm_rand_send_with(SEQ_OR_ITEM, CONSTRAINTS)
`uvm_rand_send_pri_with(SEQ_OR_ITEM, PRIORITY, CONSTRAINTS)
```
uvm_rand_send宏与uvm_send宏类似，唯一的区别是它会对transaction进行随机化。这个宏使用的前提是transaction已经被分配了空间，换言之，即已经实例化了。  
```
m_trans = new("m_trans");
`uvm_rand_send_pri_with(m_trans, 100, {m_trans.pload.size == 100;})
```
### start_item与finish_item
```
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
```
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
```
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





























