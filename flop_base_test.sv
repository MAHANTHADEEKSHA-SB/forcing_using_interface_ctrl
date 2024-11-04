class flop_base_test extends uvm_test;
  virtual flop_force_interface fvif;
  flop_env env;
  flop_sequence seq;
  `uvm_component_utils(flop_base_test)
  
  function new(string name = "flop_base_test",uvm_component parent);
    super.new(.name(name),.parent(parent));
  endfunction : new
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = flop_env :: type_id :: create("env",this);
    seq = flop_sequence :: type_id :: create("seq");
    if(!uvm_config_db#(virtual flop_force_interface) :: get(this,"*","fvif",fvif))begin
      `uvm_fatal("CFG_DB_INTERFACE_TEST",$sformatf("Unable to get the virtual interface from the cfg"))
    end
  endfunction : build_phase
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    if(!seq.randomize()with {addr == 'h8;data == 'ha;})begin
      `uvm_fatal("RANDOMIZATION_TEST",$sformatf("Test randomization issue"))
    end
    fvif.addr[1] = 'h4;
    fvif.addr[0] = 'h0;
    fvif.data[1] = 'h10;
    fvif.data[0] = 'h0;
    seq.start(env.agent.sequencer);
    repeat(6)begin
      @(posedge fvif.clk);
    end
    fvif.addr[1] = 'h4;
    fvif.addr[0] = 'h1;
    fvif.data[1] = 'h10;
    fvif.data[0] = 'h1;
    seq.start(env.agent.sequencer);
    repeat(6)begin
      @(posedge fvif.clk);
    end
    phase.drop_objection(this);
  endtask : run_phase
endclass : flop_base_test