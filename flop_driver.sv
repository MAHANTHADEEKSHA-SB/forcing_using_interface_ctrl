class flop_driver extends uvm_driver #(flop_txn);
  virtual flop_intf vif;
  
  `uvm_component_utils(flop_driver#(flop_txn))
  function new(string name = "flop_driver",uvm_component parent);
    super.new(name,parent);
  endfunction : new
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual flop_intf) :: get(this,"*","vif",vif))begin
      `uvm_fatal("INTERFACE_GET_FAIL",$sformatf("Unable to get the interface in the driver"))
    end
  endfunction : build_phase
  
  virtual task run_phase(uvm_phase phase);
    @(negedge vif.rst);
    vif.addr <= '0;
    vif.data <= '0;
    @(posedge vif.rst);
    repeat(6)begin
      @(posedge vif.clk);
    end
    forever begin
      @(posedge vif.clk)
      seq_item_port.get_next_item(req);
      @(posedge vif.clk);
      vif.addr <= req.addr;
      vif.data <= req.data;
      @(posedge vif.clk);
      #1ps;
      req.addr_o = vif.addr_o;
      req.data_o = vif.data_o;
      seq_item_port.item_done(req);
    end
  endtask : run_phase
endclass : flop_driver