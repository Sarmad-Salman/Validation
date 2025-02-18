

module tdp_split_ram_1024x18_1R1W2_2R1W2 (
  input clock0, clock1, we1A, we1B,
  input [9:0] addr1A, addr1B,
  input  [1:0] din1A, din1B, 
  output dout1A, dout1B,
  input clock2, clock3, we2A, we2B,
  input [9:0] addr2A, addr2B,
  input  [1:0] din2A, din2B, 
  output dout2A, dout2B);

parameter [80:0] MODE_BITS =81'hb5b00000005ad8000001;

 RS_TDP36K  #(.MODE_BITS(MODE_BITS))
  inst1(
    .ADDR_A1({ 5'h00, addr1A }),
    .ADDR_A2({ 4'h0, addr2A }),
    .ADDR_B1({ 5'h00, addr1B }),
    .ADDR_B2({ 4'h0, addr2B }),
    // .ADDR_A1({1'b0, addr1A, 4'h0}),
    // .ADDR_A2({addr2A, 4'h0}),
    // .ADDR_B1({1'b0, addr1B, 4'h0}),
    // .ADDR_B2({addr2B, 4'h0}),
    .BE_A1(3),
    .BE_A2(3),
    .BE_B1(3),
    .BE_B2(3),
    .CLK_A1(clock0),
    .CLK_A2(clock2),
    .CLK_B1(clock1),
    .CLK_B2(clock3),
    .FLUSH1(0),
    .FLUSH2(0),
    .RDATA_A1(dout1A),
    .RDATA_A2(dout2A),
    .RDATA_B1(dout1B),
    .RDATA_B2(dout2B),
    .REN_A1(~we1A),  // all ones for read
    .REN_A2(~we2A),  // all ones for read
    .REN_B1(~we1B),  // all ones for read
    .REN_B2(~we2B),  // all ones for read
    .WDATA_A1(din1A),
    .WDATA_A2(din2A),
    .WDATA_B1(din1B),
    .WDATA_B2(din2B),
    .WEN_A1(we1A),
    .WEN_A2(we2A),
    .WEN_B1(we1B),
    .WEN_B2(we2B)
  );
 

endmodule
