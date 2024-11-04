class flop_env extends uvm_env;
  flop_agent agent;
  flop_scoreboard scoreboard;
  
  `uvm_component_utils(flop_env)
  function new(string name = "flop_env",uvm_component parent);
    super.new(name,parent);
  endfunction : new
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = flop_agent :: type_id :: create("agent",this);
    scoreboard = flop_scoreboard :: type_id :: create("scoreboard",this);
  endfunction : build_phase
endclass : flop_env