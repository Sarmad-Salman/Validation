module ram_primitive_tdp_no_split_BE_18_rstn (
  input rstn, clock0, clock1, weA, weB, 
  input [1:0] beA, beB,
  input [9:0] addrA, addrB,
  input [17:0] dinA, dinB, 
  output reg [17:0] doutA, doutB);

wire [17:0] doutA_reg, doutB_reg;

TDP_RAM36K #(.INIT({32768{1'b0}}), // Initial Contents of memory
  .INIT_PARITY({2048{1'b0}}), // Initial Contents of memory
  .WRITE_WIDTH_A(18), // Write data width on port A (1-36)
  .READ_WIDTH_A(18), // Read data width on port A (1-36)
  .WRITE_WIDTH_B(18), // Write data width on port B (1-36)
  .READ_WIDTH_B(18) // Read data width on port B (1-36)
) inst ( 
  .WEN_A(weA), // Write-enable port A
  .WEN_B(weB), // Write-enable port B
  .REN_A(~weA), // Read-enable port A
  .REN_B(~weB)), // Read-enable port B
  .CLK_A(clock0), // Clock port A
  .CLK_B(clock1), // Clock port B
  .BE_A({2'b00,beA}), // Byte-write enable port A
  .BE_B({2'b00,beB}), // Byte-write enable port B
  .ADDR_A(addrA), // Address port A, align MSBs and connect unused MSBs to logic 0
  .ADDR_B(addrB), // Address port B, align MSBs and connect unused MSBs to logic 0
  .WDATA_A(dinA[15:0]), // Write data port A
  .WPARITY_A(dinA[17:16]), // Write parity data port A
  .WDATA_B(dinB[15:0]), // Write data port B
  .WPARITY_B(dinB[17:16]), // Write parity port B
  .RDATA_A(doutA[15:0]), // Read data port A
  .RPARITY_A(doutA[17:16]), // Read parity port A
  .RDATA_B(doutB[15:0]), // Read data port B
  .RPARITY_B(doutB[17:16]) // Read parity port B
);
 always @(posedge clock0  or negedge rstn)
        if (rstn == 1'b0)
            doutA <= 1'b0;
        else 
            doutA <= doutA_reg;

always @(posedge clock1  or negedge rstn)
        if (rstn == 1'b0)
            doutB <= 1'b0;
        else 
            doutB <= doutB_reg;
 

endmodule