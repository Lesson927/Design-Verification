SystemVerilog
===============

## 基本语法

[SV](https://blog.csdn.net/qq_43045275/article/details/129888840?ops_request_misc=%257B%2522request%255Fid%2522%253A%25224d2a7fb7ce828074d43d75219076903d%2522%252C%2522scm%2522%253A%252220140713.130102334.pc%255Fblog.%2522%257D&request_id=4d2a7fb7ce828074d43d75219076903d&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~blog~first_rank_ecpm_v1~rank_v31_ecpm-12-129888840-null-null.nonecase&utm_term=system%20verilog&spm=1018.2226.3001.4450)

<img width="1060" height="1236" alt="image" src="https://github.com/user-attachments/assets/43901f59-4506-4b93-a5f0-f3676827a10b" />

## 验证环境（verification env）
[env](https://www.chipverify.com/systemverilog/systemverilog-testbench-example-2)

## 作用域符::
### 定义外部函数
```systemverilog
class ABC;
  int data;
  extern virtual function void display();
endclass

function void ABC::display();
  $display("data = 0x%0h",data);
endfunction

module tb;
  initial begin
    ABC abc = new();
    abc.data = 32'hface_cafe;
    abc.display();
  end
endmodule
```
### 访问静态方法/函数
```systemverilog
drv = my_driver::type_id::create("drv",this);
```
### 使用package
```systemverilog
package my_pkg;
  typedef enum bit {FALSE, TRUE} e_bool;
endpackage

import my_pkg::*;

module tb;
  typedef enum bit {TRUE, FALSE} ebool;
  initial begin
    e_bool val;

    val = my_pkg::TRUE;
    $display("val = 0x%0h",val);
    
    val = TRUE;
    $display("val = 0x%0h",val);
  end

endmodule
```
### 类型转换
```systemverilog
  typedef enum logic [6:0] {
    IDLE         = 7'b0000001,
    READ_DESP    = 7'b0000010,
    CHECK_DESP   = 7'b0000100,
    READ_BUFFER1 = 7'b0001000,
    READ_BUFFER2 = 7'b0010000,
    WRITE_DESP   = 7'b0100000,
    SUSPEND      = 7'b1000000
  } dma_state_e;
......
cov.sample(dma_state_e'(cs), dma_state_e'(ns));  
// 枚举类型和普通整型/逻辑型在 SystemVerilog 中是强类型的，不能直接赋值，需要显式转换
```
### 结构体与枚举
```systemverilog
typedef struct {
bit  [31:0] addr;
bit  [31:0] data;
} addr_data_s;

typedef enum bit {
APB_READ  =  1'b0,
APB_WRITE =  1'B1
} apb_dir_e;

```
