class flop_sequencer extends uvm_sequencer #(flop_txn);
  `uvm_component_utils(flop_sequencer #(flop_txn))
  function new(string name = "flop_sequencer",uvm_component parent);
    super.new(name,parent);
  endfunction : new
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction : build_phase
endclass : flop_sequencer