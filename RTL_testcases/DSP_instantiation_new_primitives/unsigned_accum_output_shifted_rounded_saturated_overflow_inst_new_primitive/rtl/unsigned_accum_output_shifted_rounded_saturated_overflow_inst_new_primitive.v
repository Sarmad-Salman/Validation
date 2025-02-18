module unsigned_accum_output_shifted_rounded_saturated_overflow_inst_new_primitive (
	input  wire [19:0] a,
    input  wire [17:0] b,
    input  wire [5:0] shift_right,
	input wire clk, reset,
    output wire [37:0] z_out
    );

    parameter [79:0] MODE_BITS = 80'd0;
    
    wire [37:0] z_w;
	//wire reset;
DSP38 #(
  .DSP_MODE("MULTIPLY_ACCUMULATE"), // DSp arithmetic mode (MULTIPLY/MULTIPLY_ADD_SUB/MULTIPLY_ACCUMULATE)
  .COEFF_0(20'h00000), // 20-bit A input coefficient 0
  .COEFF_1(20'h00000), // 20-bit A input coefficient 1
  .COEFF_2(20'h00000), // 20-bit A input coefficient 2
  .COEFF_3(20'h00000), // 20-bit A input coefficient 3
  .OUTPUT_REG_EN("FALSE"), // Enable output register (TRUE/FALSE)
  .INPUT_REG_EN("FALSE") // Enable input register (TRUE/FALSE)
) DSP_inst(
  .A(a), // 20-bit data input for multipluier or accumulator loading
  .B(b), // 18-bit data input for multiplication
  .ACC_FIR(ACC_FIR), // 6-bit left shift A input
  .Z(z_w), // 38-bit data output
  .DLY_B(DLY_B), // 18-bit B registered output
  .CLK(clk), // Clock
  .RESET(reset), // None
  .FEEDBACK(3'd0), // 3-bit feedback input selects coefficient
  .LOAD_ACC(1'b1), // Load accumulator input
  .SATURATE(1'b1), // Saturate enable
  .SHIFT_RIGHT(shift_right), // 6-bit Shift right
  .ROUND(1'b1), // Round
  .SUBTRACT(1'b1), // Add or subtract
  .UNSIGNED_A (1'b1), // Selects signed or unsigned data for A input
  .UNSIGNED_B (1'b1) 
);		
    assign z_out = z_w;

endmodule