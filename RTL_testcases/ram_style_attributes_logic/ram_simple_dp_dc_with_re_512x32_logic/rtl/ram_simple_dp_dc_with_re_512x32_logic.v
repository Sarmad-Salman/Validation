module ram_simple_dp_dc_with_re_512x32_logic(
   input      [31:0] din,
   input     [8:0] read_addr, write_addr,       // two addresses
   input     we,re, read_clock, write_clock, // two clocks
   output [31:0] dout);

reg [31:0] dout;

   (* ram_style = "logic" *)
   reg        [31:0] ram[0:512];
   always @ (posedge write_clock)                // write clock
     begin
        if (we)
           ram[write_addr] <= din;
     end
   always @ (posedge read_clock)                 // read clock
     begin
     if (re)
        dout <= ram[read_addr];                     // register output
     end
endmodule