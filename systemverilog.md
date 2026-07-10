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
### 

