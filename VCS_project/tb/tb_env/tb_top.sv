// Top level testbench module to instantiate design, interface
// start clocks and run the test
module tb_top;
  reg clk;

  always #10 clk =~ clk;
  switch_if 	_if (clk);
  switch u0 ( 	.clk(clk),
             .rstn(_if.rstn),
             .addr(_if.addr),
             .data(_if.data),
             .vld (_if.vld),
             .addr_a(_if.addr_a),
             .data_a(_if.data_a),
             .addr_b(_if.addr_b),
             .data_b(_if.data_b));
 
`include "TC-001.sv"
  initial begin
    {clk, _if.rstn} <= 0;

    // Apply reset
    #20 _if.rstn <= 1;
  end

initial begin
    $fsdbDumpfile("top.fsdb");
    $fsdbDumpvars(0,tb_top);
    $fsdbDumpMDA();
end

initial begin
    `ifdef GATE_SIM
        // 后仿真专用代码
        $sdf_annotate("../../prj/gate/tb_switch_time_impl.sdf", u0);
        $display("GATE simulation with SDF annotation");
    `else
        // 前仿真专用代码
        $display("RTL simulation");
    `endif
end

endmodule
