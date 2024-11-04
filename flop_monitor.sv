class flop_monitor extends uvm_monitor;
  `uvm_component_utils(flop_monitor)
  
  function new(string name = "flop_monitor",uvm_component parent);
    super.new(name,parent);
  endfunction : new
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction : build_phase
endclass : flop_monitor