/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : R-2020.09-SP4
// Date      : Tue Oct  7 08:44:21 2025
/////////////////////////////////////////////////////////////


module switch ( clk, rstn, vld, addr, data, addr_a, data_a, addr_b, data_b );
  input [7:0] addr;
  input [15:0] data;
  output [7:0] addr_a;
  output [15:0] data_a;
  output [7:0] addr_b;
  output [15:0] data_b;
  input clk, rstn, vld;
  wire   N6, n54, n56, n57, n58, n59, n60, n61, n62, n63, n64, n66, n67, n68,
         n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82,
         n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96,
         n97, n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108,
         n109, n110, n111, n112, n113, n114, n115, n116, n117, n118, n119,
         n120, n121, n122, n123, n124, n125, n126, n127, n128, n129, n130,
         n131, n132, n133, n134, n135, n136, n137, n138, n139, n140, n141,
         n142, n143, n144, n145, n146, n147, n148, n149, n150, n151, n152,
         n153, n154, n155, n156, n157, n158, n159, n160, n161, n162;

  AN2P U54 ( .A(rstn), .B(n97), .Z(n56) );
  FD1 \addr_b_reg[7]  ( .D(n114), .CP(clk), .Q(addr_b[7]) );
  FD1 \addr_b_reg[6]  ( .D(n115), .CP(clk), .Q(addr_b[6]) );
  FD1 \addr_b_reg[5]  ( .D(n116), .CP(clk), .Q(addr_b[5]) );
  FD1 \addr_b_reg[4]  ( .D(n117), .CP(clk), .Q(addr_b[4]) );
  FD1 \addr_b_reg[3]  ( .D(n118), .CP(clk), .Q(addr_b[3]) );
  FD1 \addr_b_reg[2]  ( .D(n119), .CP(clk), .Q(addr_b[2]) );
  FD1 \addr_b_reg[1]  ( .D(n120), .CP(clk), .Q(addr_b[1]) );
  FD1 \addr_b_reg[0]  ( .D(n121), .CP(clk), .Q(addr_b[0]) );
  FD1 \data_a_reg[15]  ( .D(n138), .CP(clk), .Q(data_a[15]) );
  FD1 \data_a_reg[14]  ( .D(n139), .CP(clk), .Q(data_a[14]) );
  FD1 \data_a_reg[13]  ( .D(n140), .CP(clk), .Q(data_a[13]) );
  FD1 \data_a_reg[12]  ( .D(n141), .CP(clk), .Q(data_a[12]) );
  FD1 \data_a_reg[11]  ( .D(n142), .CP(clk), .Q(data_a[11]) );
  FD1 \data_a_reg[10]  ( .D(n143), .CP(clk), .Q(data_a[10]) );
  FD1 \data_a_reg[9]  ( .D(n144), .CP(clk), .Q(data_a[9]) );
  FD1 \data_a_reg[8]  ( .D(n145), .CP(clk), .Q(data_a[8]) );
  FD1 \data_a_reg[7]  ( .D(n146), .CP(clk), .Q(data_a[7]) );
  FD1 \data_a_reg[6]  ( .D(n147), .CP(clk), .Q(data_a[6]) );
  FD1 \data_a_reg[5]  ( .D(n148), .CP(clk), .Q(data_a[5]) );
  FD1 \data_a_reg[4]  ( .D(n149), .CP(clk), .Q(data_a[4]) );
  FD1 \data_a_reg[3]  ( .D(n150), .CP(clk), .Q(data_a[3]) );
  FD1 \data_a_reg[2]  ( .D(n151), .CP(clk), .Q(data_a[2]) );
  FD1 \data_a_reg[1]  ( .D(n152), .CP(clk), .Q(data_a[1]) );
  FD1 \data_a_reg[0]  ( .D(n153), .CP(clk), .Q(data_a[0]) );
  FD1 \data_b_reg[15]  ( .D(n122), .CP(clk), .Q(data_b[15]) );
  FD1 \data_b_reg[14]  ( .D(n123), .CP(clk), .Q(data_b[14]) );
  FD1 \data_b_reg[13]  ( .D(n124), .CP(clk), .Q(data_b[13]) );
  FD1 \data_b_reg[12]  ( .D(n125), .CP(clk), .Q(data_b[12]) );
  FD1 \data_b_reg[11]  ( .D(n126), .CP(clk), .Q(data_b[11]) );
  FD1 \data_b_reg[10]  ( .D(n127), .CP(clk), .Q(data_b[10]) );
  FD1 \data_b_reg[9]  ( .D(n128), .CP(clk), .Q(data_b[9]) );
  FD1 \data_b_reg[8]  ( .D(n129), .CP(clk), .Q(data_b[8]) );
  FD1 \data_b_reg[7]  ( .D(n130), .CP(clk), .Q(data_b[7]) );
  FD1 \data_b_reg[6]  ( .D(n131), .CP(clk), .Q(data_b[6]) );
  FD1 \data_b_reg[5]  ( .D(n132), .CP(clk), .Q(data_b[5]) );
  FD1 \data_b_reg[4]  ( .D(n133), .CP(clk), .Q(data_b[4]) );
  FD1 \data_b_reg[3]  ( .D(n134), .CP(clk), .Q(data_b[3]) );
  FD1 \data_b_reg[2]  ( .D(n135), .CP(clk), .Q(data_b[2]) );
  FD1 \data_b_reg[1]  ( .D(n136), .CP(clk), .Q(data_b[1]) );
  FD1 \data_b_reg[0]  ( .D(n137), .CP(clk), .Q(data_b[0]) );
  FD1 \addr_a_reg[7]  ( .D(n154), .CP(clk), .Q(addr_a[7]) );
  FD1 \addr_a_reg[6]  ( .D(n155), .CP(clk), .Q(addr_a[6]) );
  FD1 \addr_a_reg[5]  ( .D(n156), .CP(clk), .Q(addr_a[5]) );
  FD1 \addr_a_reg[4]  ( .D(n157), .CP(clk), .Q(addr_a[4]) );
  FD1 \addr_a_reg[3]  ( .D(n158), .CP(clk), .Q(addr_a[3]) );
  FD1 \addr_a_reg[2]  ( .D(n159), .CP(clk), .Q(addr_a[2]) );
  FD1 \addr_a_reg[1]  ( .D(n160), .CP(clk), .Q(addr_a[1]) );
  FD1 \addr_a_reg[0]  ( .D(n161), .CP(clk), .Q(addr_a[0]) );
  NR2P U106 ( .A(n97), .B(N6), .Z(n106) );
  OR2P U107 ( .A(n162), .B(n97), .Z(n107) );
  IVP U108 ( .A(n107), .Z(n113) );
  IVP U109 ( .A(n112), .Z(n109) );
  IVP U110 ( .A(n112), .Z(n110) );
  IVP U111 ( .A(n112), .Z(n111) );
  IVP U112 ( .A(N6), .Z(n162) );
  IVP U113 ( .A(n112), .Z(n108) );
  IVP U114 ( .A(n56), .Z(n112) );
  IVP U115 ( .A(n54), .Z(n161) );
  AO2 U116 ( .A(n113), .B(addr[0]), .C(addr_a[0]), .D(n108), .Z(n54) );
  IVP U117 ( .A(n57), .Z(n160) );
  AO2 U118 ( .A(n113), .B(addr[1]), .C(addr_a[1]), .D(n108), .Z(n57) );
  IVP U119 ( .A(n58), .Z(n159) );
  AO2 U120 ( .A(n113), .B(addr[2]), .C(addr_a[2]), .D(n108), .Z(n58) );
  IVP U121 ( .A(n59), .Z(n158) );
  AO2 U122 ( .A(n113), .B(addr[3]), .C(addr_a[3]), .D(n108), .Z(n59) );
  IVP U123 ( .A(n60), .Z(n157) );
  AO2 U124 ( .A(n113), .B(addr[4]), .C(addr_a[4]), .D(n108), .Z(n60) );
  IVP U125 ( .A(n61), .Z(n156) );
  AO2 U126 ( .A(n113), .B(addr[5]), .C(addr_a[5]), .D(n108), .Z(n61) );
  IVP U127 ( .A(n62), .Z(n155) );
  AO2 U128 ( .A(n113), .B(addr[6]), .C(addr_a[6]), .D(n108), .Z(n62) );
  IVP U129 ( .A(n63), .Z(n154) );
  AO2 U130 ( .A(n113), .B(addr[7]), .C(addr_a[7]), .D(n108), .Z(n63) );
  IVP U131 ( .A(n81), .Z(n153) );
  AO2 U132 ( .A(n113), .B(data[0]), .C(data_a[0]), .D(n110), .Z(n81) );
  IVP U133 ( .A(n82), .Z(n152) );
  AO2 U134 ( .A(n113), .B(data[1]), .C(data_a[1]), .D(n110), .Z(n82) );
  IVP U135 ( .A(n83), .Z(n151) );
  AO2 U136 ( .A(n113), .B(data[2]), .C(data_a[2]), .D(n110), .Z(n83) );
  IVP U137 ( .A(n84), .Z(n150) );
  AO2 U138 ( .A(n113), .B(data[3]), .C(data_a[3]), .D(n110), .Z(n84) );
  IVP U139 ( .A(n85), .Z(n149) );
  AO2 U140 ( .A(n113), .B(data[4]), .C(data_a[4]), .D(n110), .Z(n85) );
  IVP U141 ( .A(n86), .Z(n148) );
  AO2 U142 ( .A(n113), .B(data[5]), .C(data_a[5]), .D(n110), .Z(n86) );
  IVP U143 ( .A(n87), .Z(n147) );
  AO2 U144 ( .A(n113), .B(data[6]), .C(data_a[6]), .D(n110), .Z(n87) );
  IVP U145 ( .A(n88), .Z(n146) );
  AO2 U146 ( .A(n113), .B(data[7]), .C(data_a[7]), .D(n110), .Z(n88) );
  IVP U147 ( .A(n89), .Z(n145) );
  AO2 U148 ( .A(n113), .B(data[8]), .C(data_a[8]), .D(n110), .Z(n89) );
  IVP U149 ( .A(n90), .Z(n144) );
  AO2 U150 ( .A(n113), .B(data[9]), .C(data_a[9]), .D(n110), .Z(n90) );
  IVP U151 ( .A(n91), .Z(n143) );
  AO2 U152 ( .A(n113), .B(data[10]), .C(data_a[10]), .D(n110), .Z(n91) );
  IVP U153 ( .A(n92), .Z(n142) );
  AO2 U154 ( .A(n113), .B(data[11]), .C(data_a[11]), .D(n110), .Z(n92) );
  IVP U155 ( .A(n93), .Z(n141) );
  AO2 U156 ( .A(n113), .B(data[12]), .C(data_a[12]), .D(n111), .Z(n93) );
  IVP U157 ( .A(n94), .Z(n140) );
  AO2 U158 ( .A(n113), .B(data[13]), .C(data_a[13]), .D(n111), .Z(n94) );
  IVP U159 ( .A(n95), .Z(n139) );
  AO2 U160 ( .A(n113), .B(data[14]), .C(data_a[14]), .D(n111), .Z(n95) );
  IVP U161 ( .A(n96), .Z(n138) );
  AO2 U162 ( .A(n113), .B(data[15]), .C(data_a[15]), .D(n111), .Z(n96) );
  IVP U163 ( .A(n64), .Z(n137) );
  AO2 U164 ( .A(n106), .B(data[0]), .C(data_b[0]), .D(n108), .Z(n64) );
  IVP U165 ( .A(n66), .Z(n136) );
  AO2 U166 ( .A(n106), .B(data[1]), .C(data_b[1]), .D(n108), .Z(n66) );
  IVP U167 ( .A(n67), .Z(n135) );
  AO2 U168 ( .A(n106), .B(data[2]), .C(data_b[2]), .D(n108), .Z(n67) );
  IVP U169 ( .A(n68), .Z(n134) );
  AO2 U170 ( .A(n106), .B(data[3]), .C(data_b[3]), .D(n108), .Z(n68) );
  IVP U171 ( .A(n69), .Z(n133) );
  AO2 U172 ( .A(n106), .B(data[4]), .C(data_b[4]), .D(n109), .Z(n69) );
  IVP U173 ( .A(n70), .Z(n132) );
  AO2 U174 ( .A(n106), .B(data[5]), .C(data_b[5]), .D(n109), .Z(n70) );
  IVP U175 ( .A(n71), .Z(n131) );
  AO2 U176 ( .A(n106), .B(data[6]), .C(data_b[6]), .D(n109), .Z(n71) );
  IVP U177 ( .A(n72), .Z(n130) );
  AO2 U178 ( .A(n106), .B(data[7]), .C(data_b[7]), .D(n109), .Z(n72) );
  IVP U179 ( .A(n73), .Z(n129) );
  AO2 U180 ( .A(n106), .B(data[8]), .C(data_b[8]), .D(n109), .Z(n73) );
  IVP U181 ( .A(n74), .Z(n128) );
  AO2 U182 ( .A(n106), .B(data[9]), .C(data_b[9]), .D(n109), .Z(n74) );
  IVP U183 ( .A(n75), .Z(n127) );
  AO2 U184 ( .A(n106), .B(data[10]), .C(data_b[10]), .D(n109), .Z(n75) );
  IVP U185 ( .A(n76), .Z(n126) );
  AO2 U186 ( .A(n106), .B(data[11]), .C(data_b[11]), .D(n109), .Z(n76) );
  IVP U187 ( .A(n77), .Z(n125) );
  AO2 U188 ( .A(n106), .B(data[12]), .C(data_b[12]), .D(n109), .Z(n77) );
  IVP U189 ( .A(n78), .Z(n124) );
  AO2 U190 ( .A(n106), .B(data[13]), .C(data_b[13]), .D(n109), .Z(n78) );
  IVP U191 ( .A(n79), .Z(n123) );
  AO2 U192 ( .A(n106), .B(data[14]), .C(data_b[14]), .D(n109), .Z(n79) );
  IVP U193 ( .A(n80), .Z(n122) );
  AO2 U194 ( .A(n106), .B(data[15]), .C(data_b[15]), .D(n109), .Z(n80) );
  IVP U195 ( .A(n98), .Z(n121) );
  AO2 U196 ( .A(addr[0]), .B(n106), .C(addr_b[0]), .D(n111), .Z(n98) );
  IVP U197 ( .A(n99), .Z(n120) );
  AO2 U198 ( .A(addr[1]), .B(n106), .C(addr_b[1]), .D(n111), .Z(n99) );
  IVP U199 ( .A(n100), .Z(n119) );
  AO2 U200 ( .A(addr[2]), .B(n106), .C(addr_b[2]), .D(n111), .Z(n100) );
  IVP U201 ( .A(n101), .Z(n118) );
  AO2 U202 ( .A(addr[3]), .B(n106), .C(addr_b[3]), .D(n111), .Z(n101) );
  IVP U203 ( .A(n102), .Z(n117) );
  AO2 U204 ( .A(addr[4]), .B(n106), .C(addr_b[4]), .D(n111), .Z(n102) );
  IVP U205 ( .A(n103), .Z(n116) );
  AO2 U206 ( .A(addr[5]), .B(n106), .C(addr_b[5]), .D(n111), .Z(n103) );
  IVP U207 ( .A(n104), .Z(n115) );
  AO2 U208 ( .A(addr[6]), .B(n106), .C(addr_b[6]), .D(n111), .Z(n104) );
  IVP U209 ( .A(n105), .Z(n114) );
  AO2 U210 ( .A(addr[7]), .B(n106), .C(addr_b[7]), .D(n111), .Z(n105) );
  ND2 U211 ( .A(vld), .B(rstn), .Z(n97) );
  NR2 U212 ( .A(addr[7]), .B(addr[6]), .Z(N6) );
endmodule

