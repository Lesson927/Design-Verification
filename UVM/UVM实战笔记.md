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
