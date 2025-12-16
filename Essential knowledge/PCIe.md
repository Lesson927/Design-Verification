# PCIe手册笔记总结

## PCIe Introduction

### A Third Generation I/O Interconnect（第三代IO接口）

第三代IO接口的一些高级需求  

### PCI Express Link

<img width="934" height="434" alt="image" src="https://github.com/user-attachments/assets/1a9db5ee-8f23-43da-9ca9-c3648a22f028" />  
lanes,GT/s,  

### PCI Express Fabric Topology(拓扑结构)
<img width="954" height="626" alt="image" src="https://github.com/user-attachments/assets/23cf66e9-7fa1-4648-8779-6520f32158df" />  

#### Root Complex（RC）

An RC denotes the root of an I/O hierarchy that connects the CPU/memory subsystem to the I/O  

#### Endpoints

Endpoint refers to a type of Function that can be the Requester or Completer of a PCI Express transaction either on its own behalf or on behalf of a distinct non-PCI Express device (other than a PCI device or host CPU)  

RULES  

#### switch(交换机)

<img width="1024" height="617" alt="image" src="https://github.com/user-attachments/assets/9c613d95-dd61-46e7-8e52-46320a98dbeb" />  

A Switch is defined as a logical assembly of multiple virtual PCI-to-PCI Bridge devices


#### Root Complex Event Collector

#### PCI Express to PCI/PCI-X Bridge

### Hardware/Software Model for Discovery, Configuration and Operation

###  PCI Express Layering Overview 
<img width="663" height="584" alt="image" src="https://github.com/user-attachments/assets/be2086b7-3228-4ece-b2e1-7f7789c64248" />  
<img width="875" height="377" alt="image" src="https://github.com/user-attachments/assets/14927607-6a5c-46e8-9e01-8e3f4d87d17e" />  

#### Transaction Layer
事务层的主要职责是组装和拆解TLPs。TLPs用于传达事务，例如读写操作，以及某些类型的事件。事务层还负责管理基于信用的TLP流量控制。

#### Data Link Layer
数据链路层，作为事务层和物理层之间的中间阶段。数据链路层的主要职责包括链路管理和数据完整性，包括错误检测和错误纠正。

#### Physical Layer
物理层包括用于接口操作的所有电路，包括驱动器和输入缓冲器、并行到串行和串行到并行转换、锁相环（PLL）以及阻抗匹配电路。它还包括与接口初始化和维护相关的逻辑功能。物理层以实现特定的格式与数据链路层交换信息。该层负责将从数据链路层接收到的信息转换为适当的串行格式，并以与连接到链路另一侧设备兼容的频率和宽度通过PCI Express链路进行传输。  

#### Layer Functions and Services













