// Code your testbench here
// or browse Examples
`include "flop_intf.sv"
`include "flop_force_interface.sv"
`include "flop_txn.sv"
`include "flop_sequence.sv"
`include "flop_sequencer.sv"
`include "flop_driver.sv"
`include "flop_monitor.sv"
`include "flop_agent.sv"
`include "flop_scoreboard.sv"
`include "flop_env.sv"
`include "flop_base_test.sv"
module tb_top;
  reg clk;
  
  flop_intf intf(.clk(clk));
  flop_force_interface f_intf(.clk(clk),.rst(intf.rst));
  
  initial begin
    clk = 1'b0;
    intf.rst = 1'b1;
  end
  
  always #5 clk = ~clk;
  
  flop DUT(.clk(clk),
           .rst(intf.rst),
           .addr(intf.addr),
           .data(intf.data),
           .addr_o(intf.addr_o),
           .data_o(intf.data_o));
  
  always@(posedge clk or negedge intf.rst)begin
    if(!intf.rst)begin
      if(f_intf.addr[0] == 'h1)begin
        force DUT.addr = '0;
        #1ns;
        release DUT.addr;
      end
      if(f_intf.data[0] == 'h1)begin
        force DUT.data = '0;
        #1ns;
        release DUT.addr;
      end
    end
    else begin
      if(f_intf.addr[0] == 'h1)begin
        force DUT.addr = f_intf.addr[1];
      end
      else if(f_intf.addr[0] != 'h1)begin
        release DUT.addr;
      end
      if(f_intf.data[0] == 'h1)begin
        force DUT.data = f_intf.data[1];
      end
      else if(f_intf.addr[0] != 'h1)begin
        release DUT.data;
      end
      //else begin
        //#1ns
        //release DUT.addr;
        //release DUT.data;
      //end
    end
    
  end
  
  initial begin
    @(posedge clk) intf.rst <= 1'b0;
    repeat(6)begin
      @(posedge clk);
    end
    intf.rst <= 1'b1;
  end
  initial begin
    run_test("flop_base_test");
  end
  initial begin
    uvm_config_db #(virtual flop_intf) :: set(null,"*.driver.*","vif",intf);
    uvm_config_db #(virtual flop_force_interface) :: set(null,"*","fvif",f_intf);
    $dumpfile("dump.vcd"); 
    $dumpvars(0, tb_top);
  end
endmodule : tb_top