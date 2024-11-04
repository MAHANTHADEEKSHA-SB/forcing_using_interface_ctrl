// Code your design here
module flop(clk,rst,addr,data,addr_o,data_o);
  input wire clk;
  input wire rst;
  input wire[31 : 0] addr;
  input wire[31 : 0] data;
  output reg[31 : 0] addr_o;
  output reg[31 : 0] data_o;
  
  always@(posedge clk or negedge rst)begin
    if(!rst)begin
      addr_o <= '0;
      data_o <= '0;
    end
    else begin
      addr_o <= addr;
      data_o <= data;
    end
  end
endmodule : flop