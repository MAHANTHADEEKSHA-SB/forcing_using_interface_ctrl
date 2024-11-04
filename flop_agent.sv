class flop_agent extends uvm_agent;
  flop_sequencer#(flop_txn) sequencer;
  flop_driver#(flop_txn) driver;
  flop_monitor monitor;
  `uvm_component_utils(flop_agent)
  function new(string name = "flop_agent",uvm_component parent);
    super.new(name,parent);
  endfunction : new
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sequencer = flop_sequencer#(flop_txn) :: type_id :: create("sequencer",this);
    driver = flop_driver#(flop_txn) :: type_id :: create("driver",this);
    monitor = flop_monitor :: type_id :: create("monitor",this);
  endfunction : build_phase
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
    driver.rsp_port.connect(sequencer.rsp_export);
  endfunction : connect_phase
endclass : flop_agent