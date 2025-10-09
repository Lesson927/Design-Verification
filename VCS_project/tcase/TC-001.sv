// 在文件顶部定义约束类
class constrained_switch_item extends switch_item;
	constraint c_addr { addr inside {[8'h01:8'h0F]}; } 
	constraint c_data { data inside {[16'h0001:16'h00FF]}; } 
endclass

class generator_tc001;
	mailbox drv_mbx;
	event drv_done;
	int num = 20;
 
	task run();
		for(int i = 0; i < num; i++)
		begin
			constrained_switch_item item = new;
			item.randomize();
			$display("T = %0t [Generator] Loop : %0d/%0d creat next item",$time,i+1,num);
			drv_mbx.put(item);
			@(drv_done);
		end
		$display("T = %0t [Generator] Done generation of %0d items",$time,num);
	endtask
endclass
// ---- ---- Environment
// 简介：
class env_tc001;
	driver d1;
	monitor m1;
	generator_tc001 g1;
	scoreboard s1;
 
	mailbox drv_mbx;
	mailbox scb_mbx;
	event drv_done;
 
	virtual switch_if vif;
 
	function new ();
		d1 = new;
		m1 = new;
		g1 = new;
		s1 = new;
		drv_mbx = new();
		scb_mbx = new();
 
		d1.drv_mbx = drv_mbx;
		g1.drv_mbx = drv_mbx;
		m1.scb_mbx = scb_mbx;
		s1.scb_mbx = scb_mbx;
 
		d1.drv_done = drv_done;
		g1.drv_done = drv_done;
	endfunction 
 
	virtual task run();
		d1.vif = vif;
		m1.vif = vif;
 
		fork
			d1.run();
			m1.run();
			g1.run();
			s1.run();
		join_any
	endtask
endclass
// ---- ---- Test
class test_tc001;
	env_tc001 e1;
 
	function new ();
		e1 = new;
	endfunction 
	task run();
		e1.run();
	endtask
endclass
////////////////TC-001//////////////////////
initial begin
    test_tc001 t1;
    t1 = new;
    t1.e1.vif = _if;
    t1.run();
    #50 $finish;
end

