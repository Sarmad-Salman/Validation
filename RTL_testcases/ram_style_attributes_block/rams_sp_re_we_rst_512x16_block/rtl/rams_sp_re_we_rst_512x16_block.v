
module rams_sp_re_we_rst_512x16_block (clk, rst, we, re, addr, di, dout);
input clk, rst;
input we, re;
input [8:0] addr;
input [15:0] di;
output reg [15:0] dout;

(* ram_style = "block" *)
reg [15:0] RAM [511:0];
// reg [31:0] dout;

always @(posedge clk)
    begin
        if (rst)
            dout <= 0;
        else if (we)
            RAM[addr] <= di;
        else if (re)
            dout <= RAM[addr];
    end

endmodule