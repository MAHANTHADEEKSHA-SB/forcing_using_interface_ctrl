interface flop_force_interface(input logic clk, input logic rst);
  logic [31 : 0] addr[2];
  logic [31 : 0] data[2];
  
  
endinterface : flop_force_interface