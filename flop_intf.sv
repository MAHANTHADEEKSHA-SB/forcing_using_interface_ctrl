interface flop_intf(input logic clk);
  logic rst;
  logic [31 : 0] addr;
  logic [31 : 0] data;
  logic [31 : 0] addr_o;
  logic [31 : 0] data_o;
endinterface : flop_intf