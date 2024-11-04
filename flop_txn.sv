class flop_txn extends uvm_sequence_item;
  rand bit[31 : 0] addr;
  rand bit[31 : 0] data;
  bit [31 : 0] addr_o;
  bit [31 : 0] data_o;
  constraint c_basic{addr [1 : 0] == 2'b00;addr inside {[0 : 'hff]};data[31 : 30] == 2'b00;}
  `uvm_object_utils_begin(flop_txn)
  `uvm_field_int(addr,UVM_DEFAULT)
  `uvm_field_int(data,UVM_DEFAULT)
  `uvm_field_int(addr_o,UVM_DEFAULT)
  `uvm_field_int(data_o,UVM_DEFAULT)
  `uvm_object_utils_end
  function new(string name = "flop_sequence");
    super.new(name);
  endfunction : new
endclass : flop_txn