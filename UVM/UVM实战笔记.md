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













