class flop_sequence extends uvm_sequence#(flop_txn);
  flop_txn txn;
  rand bit[31 : 0] addr;
  rand bit[31 : 0] data;
  constraint c_basic{addr [1 : 0] == 2'b00;addr inside {[0 : 'hfc]};data[31 : 30] == 2'b00;}
  `uvm_object_utils(flop_sequence)
  function new(string name = "flop_sequence");
    super.new(name);
  endfunction : new
  
  virtual task body();
    txn = flop_txn :: type_id :: create("txn");
    start_item(txn);
    assert(txn.randomize() with {addr == local::addr;data == local::data;})else `uvm_fatal("RANDOMISATION_SEQ",$sformatf("Randomisation failure"));
    finish_item(txn);
    txn.print();
  endtask : body
endclass : flop_sequence