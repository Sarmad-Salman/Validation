module ram_simple_dp_synch_rf_1024x32_neg (clk, we,re, read_addr, write_addr, din, dout);
    input clk, we, re;
    input [9:0] read_addr, write_addr;
    input [31:0] din;
    output reg [31:0] dout=0;
    
    reg [31:0] ram [1023:0];

    always @(negedge clk)
    begin
        if (we)
            ram[write_addr] <= din;
        if (re)
            dout <= ram[read_addr];
    end

endmodule