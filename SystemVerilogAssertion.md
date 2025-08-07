# SystemVerilogAssertion学习笔记


## 两种断言

### 立即断言

立即被求值，类似于if

```systemverilog
always@(posedge clk) 
begin
    a_ia: assert (a && b);
end
```

### 同时断言

```systemverilog
a_cc:assert property (@(posedge clk) not (a&&b));
```

断言在clk的每个正沿上执行，并使用预置区域中的变量的值来计算表达式，该区域是时钟给定边沿之前的增量周期。因此，在时钟边缘采样，Take for Assertion的值将为时钟边沿之前的稳定值。

## 构造SVA块

时序
```systemverilog
sequence s_ab;
    a ##1 b;
endsequence
```

属性
```systemverilog
property p_expr;
    @(posedge clk) s_ab;
endproperty
```

断言
`s_a:assert property(p_expr);`

以上三部分构成一个完整的SVA块，但是实际使用可能不需要全部。

```systemverilog
property p_req_gnt;
    @(posedge clk) $rose (req) |->
                ##[2:5] $rose (gnt);
endproperty
```
```systemverilog
a_reg_gnt:
    assert property(p_req_gnt)
    else if(arb_sva_severity) $fatal;
```
```systemverilog
c_reg_gnt:cover property(p_req_gnt);
```

## 边沿定义
```
$rose 0->1  
$fell 1->0  
$stable 未跳变
```  

## 逻辑关系

在语句中使用逻辑关系运算符
```systemverilog
sequence s3;
    @(posedge clk) a || b;
endsequence
```

## 序列形参

```systemverilog
sequence s3_lib (a,b);
    @(posedge clk) a || b;
endsequence
```
```systemverilog
sequence s3_lib_inst1;
    @(posedge clk) s3_lib (req1, req2);
endsequence
```
实际的形参的用法在总的SVA构造module体现。

## 时序关系

SVA在sequence,property,assert其一需要有“时序检查”
通常情况下，在属性（property）的定义中指定时钟，并保持序列（sequence）独立于时钟是一种好的编码风格。这可以提高基本序列定义的可重用性。

## 禁止属性

`not` 期望某个属性为假，为假时断言成功。

## 蕴含（Implication）
先行算子（antecedent） 类似于if
后续算子（consequent） 类似于then

a 成功 b 成功  结果 成功  
a 成功 b 失败  结果 失败  
a 失败 b 都行  结果 空成功  
**！！！只能在属性（property）中使用蕴含！！！**  

### 交叠蕴含 “-|>”

```systemverilog
property p8;
    @(posedge clk) a |-> b;
endproperty
```
信号a为高则信号b在相同的时钟边沿也必须为高

### 非交叠蕴含 "|=>"

```systemverilog
property p8;
    @(posedge clk) a |=> b;
endproperty
```
信号a为高则信号b在下一个时钟边沿也必须为高

### 后续算子带固定延迟

```systemverilog
property p10;
    @(posedge clk) a |-> ##2 b;
endproperty
```

### 序列蕴含

```systemverilog
property p11;
    s11a |-> s11b;
endproperty
```

## 时序窗口

### 有限

```systemverilog
property p12;
    @(posedge clk) (a && b) |-> ##[1:3] c;
endproperty

a12: assert property(p12);
```
时序窗口可重叠##[0:3]

### 无限
```
##[1:$]
```
影响性能一般不使用

## ended结构
通常情况下是将多个序列以序列的起始点作为同步点，来组合成时间上连续的检查。ended使用序列的结束点作为同步点。
```systemverilog
sequence s15a;

endsequence

sequence s15b;

endsequence

property p15;
    s15a.ended |-> ##2 s15b.ended;
endproperty

a15: assert property(p15);
```

## 使用参数的SVA检验器

```systemverilog
module generic_chk (input logic a, b, clk);
parameter delay = 1;

property p16;
    @(posedge clk) a |-> ##delay b;
endproperty

a16: assert property(p16);

endmodule
```
后续会有进阶版本

## 使用选择运算符的SVA检验器

```systemverilog
property p17;
    @(posefge clk) c ? d == a: d == b;
endproperty

a17: assert property(p17);
```

## 使用true表达式的SVA检验器

```systemverilog
sequence s18;
    @(posedge clk) a ##1 b ##1 'true;
endsequence
```
延迟一个周期判定

## $past构造

```systemverilog
property p19; 
@(posedge clk) (c && d) |->  
            ($past((a&&b)，2) == 1'b1); 
endproperty

a19：assert property(p19); 
```
带时钟门控的$past构造
```systemverilog
roperty p20; 
@(posedge clk) (c && d) |->  
            ($past((a&&b)，2，e) == 1'b1); 
endproperty 

a20：assert property(p20); 
```
信号e在任意给定时钟上升沿有效时检验才被激活

## 重复运算符

### 连续重复运算符[*]

#### 普通[*]
```systemverilog
property p21; 
@(posedge clk) $rose(start) |->  
                ##2 (a[*3]) ##2 stop ##1 !stop; 
endproperty 
a21： assert property(p21); 
```
#### 用于序列的连续重复运算符[*]
```systemverilog
 property p22; 
@(posedge clk) $rose(start) |->  
                ##2 ((a ##2 b)[*3]) ##2 stop; 
endproperty 
a22： assert property(p22); 
```
#### 用于带延迟窗口的序列的连续重复运算符[*]
```systemverilog
property p23; 
@(posedge clk) $rose(start) |->  
                ##2 ((a ##[1:4] b)[*3]) ##2 stop; 
endproperty 
a23： assert property(p23); 
```
#### 连续运算符[*]和可能性运算符
```systemverilog
property p24; 
@(posedge clk) $rose(start) |->  
                ##2 (a[*1：$]) ##1 stop; 
endproperty 
a24： assert property(p24); 
```

### 跟随重复运算符[->]
```systemverilog
property p25; 
@(posedge clk) $rose(start) |->
                ##2 (a[->3]) ##1 stop; 
endproperty 
a25： assert property(p25); 
```
最后一次信号a ##1（延迟一个周期）stop为高

### 非连续重复运算符[=]
```systemverilog
Property p26; 
@(posedge clk) $rose(start) |->  
                ##2 (a[=3]) ##1 stop ##1 !stop; 
endproperty 
a26： assert property(p26); 
```
信号a第3次匹配成功后不需要信号stop为高不必在下一个时钟发生，往后有发生即可。

## and构造
```systemverilog
sequence s27a; 
    @(posedge clk) a##[1:2] b; 
endsequence 
sequence s27b; 
    @(posedge clk) c##[2:3] d; 
endsequence 
 
property p27; 
    @(posedge clk)  s27a and s27b; 
endproperty 
 
a27: assert property(p27); 
```
当两个序列都成功时整个属性才成功，两个序列必须有相同的起始点，但是可以有不同的结束点。

## intersect构造
```systemverilog
sequence s28a; 
    @(posedge clk) a##[1：2] b; 
endsequence 
sequence s28b; 
    @(posedge clk) c##[2：3] d; 
endsequence 
property p28; 
    @(posedge clk)  s28a intersect s28b; 
endproperty 
a28： assert property(p28); 
```
两个序列必须在相同时刻开始且结束于同一时刻。换句话说，两个序列的长度必须相等。

## or构造
```systemverilog
 sequence s29a; 
    @(posedge clk) a##[1:2] b; 
endsequence 
sequence s29b; 
    @(posedge clk) c##[2:3] d; 
endsequence 
property p29; 
    @(posedge clk)  s28a or s28b; 
endproperty 
a29： assert property(p29); 
```
只要其中一个序列成功，整个属性就成功。

## first_match构造
```systemverilog
sequence s30a; 
    @(posedge clk) a ##[1:3] b; 
endsequence 
sequence s30b; 
    @(posedge clk) c ##[2:3] d; 
endsequence 
property p30; 
    @(posedge clk) first_match(s30a or s30b); 
endproperty 
a30： assert property(p30); 
```
任何时候使用了逻辑运算符(如“and”和“or”)的序列中指定了时间窗，就有可能出现同一个检验具有多个匹配的情况。“first_match”构造可以确保只用第一次序列匹配，而丢弃其他的匹配。当多个序列被组合在一起，其中只需时间窗内的第一次匹配来检验属性剩余的部分时，“first_match”构造非常有用。

## throughout构造
```systemverilog
property p31; 
    @(posedge clk) $fell(start) |->  
        (!start) throughout  
        (##1 (!a&&!b) ##1 (c[->3]) ##1 (a&&b)); 
endproperty 
a31： assert property(p31); 
```
为了保证某些条件在整个序列的验证过程中一直为真，可以使用“throughout”运算符。

## 内建系统函数

$onehot(expression)—— 检验表达式满足“one-hot”，换句话说，就是在任意给定的时钟沿，表达式只有一位为高。  
$onehot0(expression)—— 检验表达式满足“zero one-hot”，换句话说，就是在任意给定的时钟沿，表达式只有一位为高或者没有任何位为高。  
$isunknown(expression)—— 检验表达式的任何位是否是 X或者Z。  
$countones(expression)—— 计算向量中为高的位的数量。  

## disable iff构造
```systemverilog
property p34; 
    @(posedge clk)  
    disable iff (reset)  
    $rose(start) |=> a[=2] ##1 b[=2] ##1 !start ; 
endproperty 
a34： assert property(p34);
```
若信号reset为高则不执行后续检验。

## intersect构造控制长度
```systemverilog
property p35; 
    (@(posedge clk)  1[*2:5] intersect  
                        (a ##[1:$] b ##[1:$] c)); 
endproperty 
a35： assert property(p35); 
```
这个intersect 的定义检查从序列的有效开始点(信号“a”为高)，到序列成功的结束点(信号“c”为高)，一共经过2~5个时钟周期。 

## 属性中使用形参
```systemverilog
property arb (a，b，c，d); 
    @(posedge clk) ($fell(a) ##[2:5] $fell(b)) |->
                    ##1 ($fell(c) && $fell(d)) ##0  
                    (!c&&!d) [*4] ##1 (c&&d) ##1 b; 
endproperty 
a36_1： assert property(arb(a1，b1，c1，d1)); 
a36_2： assert property(arb(a2，b2，c2，d2)); 
a36_3： assert property(arb(a3，b3，c3，d3)); 
```

## 嵌套的蕴含
```systemverilog
`define free (a && b && c && d) 
property p_nest; 
    @(posedge clk) $fell(a) |->  
                    ##1 (!b && !c && !d) |->  
                                    ##[6：10] `free;
endproperty 
a_nest： assert property(p_nest); 
```
## 在蕴含中使用if/else
```systemverilog
property p_if_else; 
    @(posedge clk)  
    ($fell(start) ##1 (a||b)) |-> 
        if(a)  
            (c[->2] ##1 e) 
        else  
            (d[->2] ##1 f); 
endproperty 
a_if_else： assert property(p_if_else); 
```
## SVA中的多时钟定义
```systemverilog
sequence s_multiple_clocks; 
    @(posedge clk1) a ##1 @(posedge clk2) b; 
endsequence 
```
当在一个序列中使用了多个时钟信号时，只允许使用“##1”延迟构造。使用“##0”会产生混淆，即在信号“a”匹配后究竟哪个时钟信号才是最近的时钟。这将引起竞争，因此不允许使用。使用##2 也不允许，因为不可能同步到时钟“clk2”的最近的上升沿。
禁止在两个不同时钟驱动的序列之间使用交叠蕴含运算符。因为先行算子的结束和后续算子的开始重叠，可能引起竞争的情况，这是非法的。下面的代码显示了这种非法的编码方式：
```systemverilog
property p_multiple_clocks_implied_illegal; 
    @(posedge clk1) s1 |-> @(posedge clk2) s2; 
endproperty 
```
## matched构造
```systemverilog
sequence s_a; 
    @(posedge clk1) $rose(a); 
endsequence 
sequence s_b; 
    @(posedge clk2) $rose(b); 
endsequence 
property p_match; 
    @(posedge clk2) s_a.matched |=> s_b; 
endproperty 
a_match： assert property(p_match); 
```
匹配最近的clk2
## expect构造
```systemverilog
initial 
begin 
@(posedge clk); 
#2ns cpu_ready = 1'b1; 
expect(@(posedge clk) ##[1：16]  
                    memory_ready == 1'b1) 
    $display("Hand shake successful\n"); 
else 
begin
    $display("Hand shake failed： exiting\n") 
    $finish(); 
end 
for(i=0; i<64; i++) 
begin 
    send_packet(); 
    $display("PACKET %0d sent\n"，i); 
end 
end 
```
## 使用局部变量的SVA
```systemverilog
property p_local_var1; 
int lvar1; 
@(posedge clk)  
($rose(enable1)，lvar1 = a) |->  
                ##4 (aa == (lvar1*lvar1*lvar1)); 
endproperty 
a_local_var1： assert property(p_local_var1); 
```
## 在序列匹配时调用子程序
```systemverilog
sequence s_display1; 
@(posedge clk)  
    ($rose(a)，$display("Signal a arrived at %t\n"，$time)); 
endsequence 
sequence s_display2; 
@(posedge clk)  
    ($rose(b)，$display("Signal b arrived at %t\n"，$time)); 
endsequence 
property p_display_window; 
@(posedge clk)  
    s_display1 |-> ##[2：5] s_display2; 
endproperty 
a_display_window ： assert property(p_display_window); 
```
## 将SVA与设计连接
design RTL
```systemverilog
module inline(clk，a，b，d1，d2，d); 
input logic clk，a，b; 
input logic [7：0] d1，d2; 
output logic [7：0] d;    //个人习惯合并写在module声明里

always@(posedge clk) 
begin 
if(a) 
    d <= d1; 
if(b) 
    d <= d2; 
end 
endmodule
```
SVA检验器
```systemverilog
module mutex_chk(a，b，clk); 
input logic a，b，clk;      //个人习惯合并写在module声明里
property p_mutex; 
    @(posedge clk) not (a && b); 
endproperty 
a_mutex： assert property(p_mutex); 
endmodule 
```
顶层
```systemverilog
module top (..); 
inline u1 (clk，a，b，in1，in2，out1); 
inline u2 (clk，c，d，in3，in4，out2); 
endmodule
```
连接SVA检验器与顶层
```systemverilog
bind top.u1 mutex_chk i1(a，b，clk); 
bind top.u2 mutex_chk i2(c，d，clk); 
```
## SVA与功能覆盖
```systemverilog
c_mutex： cover property(p_mutex); 
```

## 一个例子
这是一个简单的计数器，帮助我们很好的掌握SVA在验证中的架构。  
设计模块 simple_counter.sv
```systemverilog
module simple_counter #(
    parameter WIDTH = 4
)(
    input logic clk,
    input logic rst_n,
    input logic en,        // 计数使能
    input logic load,      // 同步加载
    input logic [WIDTH-1:0] load_data, // 加载数据
    output logic [WIDTH-1:0] count     // 计数器输出
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= '0;
        end else if (load) begin
            count <= load_data;
        end else if (en) begin
            count <= count + 1;
        end
    end

endmodule
```
断言属性定义 counter_props.sv
```systemverilog
module counter_assertions #(
    parameter WIDTH = 4
)(
    input logic clk,
    input logic rst_n,
    input logic en,
    input logic load,
    input logic [WIDTH-1:0] load_data,
    input logic [WIDTH-1:0] count
);

        // 序列定义 - 仅包含时序关系，不含蕴含
    sequence s_reset_sequence;
        (!rst_n) ##1 rst_n;
    endsequence
    
    sequence s_load_sequence;
        load ##1 !load;
    endsequence
    
    sequence s_increment_sequence;
        (en && !load) ##1 !en;
    endsequence
    
    sequence s_no_overflow_sequence;
        (count != '1) or (!en);
    endsequence
    
    // 属性定义 - 在这里使用蕴含
    property p_reset_count_zero;
        @(posedge clk) 
        s_reset_sequence |-> (count == 0);
    endproperty
    
    property p_load_operation;
        @(posedge clk) disable iff (!rst_n)
        s_load_sequence |-> (count == $past(load_data));
    endproperty
    
    property p_increment_operation;
        @(posedge clk) disable iff (!rst_n)
        s_increment_sequence |-> (count == ($past(count) + 1));
    endproperty
    
    property p_no_overflow;
        @(posedge clk) disable iff (!rst_n)
        s_no_overflow_sequence;
    endproperty
    
    // 覆盖率属性
    property p_cov_load_operation;
        @(posedge clk) load;
    endproperty
    
    property p_cov_max_count;
        @(posedge clk) (count == '1);
    endproperty

    // 并发断言
    assert property (p_reset_count_zero) else $error("Counter not zero after reset");
    assert property (p_load_operation) else $error("Load operation failed");
    assert property (p_increment_operation) else $error("Increment operation failed");
    assert property (p_no_overflow) else $error("Counter overflow");
    
    // 覆盖点
    cover property (p_reset_count_zero);
    cover property (p_load_operation);
    cover property (p_increment_operation);
    cover property (p_no_overflow);
    
    cover property (p_cov_load_operation);
    cover property (p_cov_max_count);
    


endmodule


```
tb顶层 counter_tb.sv
```systemverilog
`timescale 1ns/1ps
module counter_tb;
    
    
    // 参数
    parameter WIDTH = 4;
    
    // 时钟和复位
    logic clk;
    logic rst_n;
    
    // DUT接口
    logic en;
    logic load;
    logic [WIDTH-1:0] load_data;
    logic [WIDTH-1:0] count;
    
    // 实例化DUT
    simple_counter #(
        .WIDTH(WIDTH)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .load(load),
        .load_data(load_data),
        .count(count)
    );
    
    // 时钟生成
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // 测试序列
    initial begin
        // 初始化
        en = 0;
        load = 0;
        load_data = 0;
        rst_n = 0;
        
        // 复位测试
        #10 rst_n = 1;
        
        // 测试1: 简单计数
        $display("Test 1: Simple counting");
        repeat(5) begin
            @(posedge clk);
            en = 1;
        end
        @(posedge clk);
        en = 0;
        
        // 测试2: 加载操作
        $display("Test 2: Load operation");
        @(posedge clk);
        load = 1;
        load_data = 4'hA;
        @(posedge clk);
        load = 0;
        
        // 测试3: 计数到最大值
        $display("Test 3: Count to max value");
        repeat(2**WIDTH) begin
            @(posedge clk);
            en = 1;
        end
        @(posedge clk);
        en = 0;
        
        // 测试4: 随机操作
        $display("Test 4: Random operations");
        repeat(10) begin
            @(posedge clk);
            en = $urandom_range(0,1);
            load = $urandom_range(0,1);
            load_data = $urandom_range(0, 2**WIDTH-1);
        end
        
        
        $display("All test finished");
        // 结束仿真
        #100 $finish;
    end
    

    
    // 断言绑定
    // 绑定模块到设计
    bind simple_counter counter_assertions #(
        .WIDTH(WIDTH)
    ) counter_assert_inst (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .load(load),
        .load_data(load_data),
        .count(count)
    );
    
endmodule
```





