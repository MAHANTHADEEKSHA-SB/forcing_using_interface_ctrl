class flop_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(flop_scoreboard)
  function new(string name = "flop_scoreboard",uvm_component parent);
    super.new(name,parent);
  endfunction : new
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction : build_phase
endclass : flop_scoreboard