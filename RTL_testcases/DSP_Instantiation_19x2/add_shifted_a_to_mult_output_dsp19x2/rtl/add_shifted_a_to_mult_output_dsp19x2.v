module add_shifted_a_to_mult_output_dsp19x2 (
	input  wire [19:0] a,
    input  wire [17:0] b,
    input wire clk,
    input wire reset,
    input  wire [4:0] acc_fir,
    output wire [37:0] z_out
    );

DSP19X2 #(
  .DSP_MODE("MULTIPLY_ADD_SUB"), // DSP arithmetic mode (MULTIPLY/MULTIPLY_ACCUMULATE)
  .COEFF1_0(10'h000), // Multiplier 1 10-bit A input coefficient 0
  .COEFF1_1(10'h000), // Multiplier 1 10-bit A input coefficient 1
  .COEFF1_2(10'h000), // Multiplier 1 10-bit A input coefficient 2
  .COEFF1_3(10'h000), // Multiplier 1 10-bit A input coefficient 3
  .COEFF2_0(10'h001), // Multiplier 2 10-bit A input coefficient 0
  .COEFF2_1(10'h000), // Multiplier 2 10-bit A input coefficient 1
  .COEFF2_2(10'h000), // Multiplier 2 10-bit A input coefficient 2
  .COEFF2_3(10'h000), // Multiplier 2 10-bit A input coefficient 3
  .OUTPUT_REG_EN("FALSE"), // Enable output register (TRUE/FALSE)
  .INPUT_REG_EN("FALSE") // Enable input register (TRUE/FALSE)
) DSP_inst(
  .A1(a[9:0]), // Multiplier 1 10-bit data input for multiplier or accumulator loading
  .B1(b[8:0]), // 9-bit data input for multiplication
  .Z1(z_out[18:0]), // Multiplier 1 19-bit data output
  .DLY_B1(DLY_B1), // Multiplier 1 9-bit B registered output
  .A2(a[19:10]), // Multiplier 2 10-bit data input for multiplier or accumulator loading
  .B2(b[17:9]), // Multiplier 2 9-bit data input for multiplication
  .Z2(z_out[37:19]), // Multiplier 2 19-bit data output
  .DLY_B2(DLY_B2), // Multiplier 2 9-bit B registered output
  .CLK(clk), // Clock
  .RESET(reset), // Reset input
  .ACC_FIR(acc_fir), // 5-bit left shift A input
  .FEEDBACK(3'd4), // 3-bit feedback input selects coefficient
  .LOAD_ACC(1'd0), // Load accumulator input
  .UNSIGNED_A(1'b1), // Selects signed or unsigned data for A input
  .UNSIGNED_B(1'b1), // Selects signed or unsigned data for B input
  .SATURATE(1'b0), // Saturate enable
  .SHIFT_RIGHT(6'd0), // 5-bit Shift right
  .ROUND(1'd0), // Round
  .SUBTRACT(1'b0) // Add or subtract
);

    //assign z_out = z_w;

endmodule