module co_sim_signed_accum_output_shifted_rounded_saturated_overflow_underflow_inst_new_primitive;
	reg signed [19:0] a;
	reg signed [17:0] b;
	reg [5:0] shift_right;
	reg clk, reset;
	wire signed [37:0] z_out;
	reg  signed [37:0] expected_out;
	reg  signed [63:0] expected_out2, mult, expected_out_shifted;
	

	integer mismatch=0;

`ifdef PNR
`else

signed_accum_output_shifted_rounded_saturated_overflow_underflow_inst_new_primitive golden(.*);
`endif

//clock initialization
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end
initial begin
	{reset, a, b, shift_right, expected_out, expected_out2} = 'd0;
	@(negedge clk);
	reset = 1;
	$display ("\n\n***Reset Test is applied***\n\n");
	@(negedge clk);
	@(negedge clk);
	display_stimulus();
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");

	reset = 0;
	@(negedge clk);
	@(negedge clk);
        //@(posedge clk);
	$display ("\n\n***Directed Functionality Test is applied for shifted output of  z_out = z_out + a*b***\n\n");
	a = 20'h7;
	b = 18'h3;
	shift_right = 6'h0;
	mult = (a*b);
	@(posedge clk)
	expected_out2 = expected_out2 - mult;
	expected_out_shifted = expected_out2>>>shift_right;
	expected_out = expected_out_shifted;
	#2;
	//display_stimulus();
	//compare();
	@(negedge clk)
	$display ("\n\n***Directed Functionality Test for shifted output of  z_out = z_out + a*b is ended***\n\n");

	$display ("\n\n***Directed Functionality Test is applied for shifted output of  z_out = z_out + a*b***\n\n");
	a = 20'h1;
	b = 18'h2;
	shift_right = 6'h3;
	mult = (a*b);
	@(posedge clk)
	expected_out2 = expected_out2 - mult;
	expected_out_shifted = expected_out2>>>shift_right;
	expected_out = expected_out_shifted;
	#2;
	display_stimulus();
	compare();
	@(negedge clk)
	$display ("\n\n***Directed Functionality Test for shifted output of  z_out = z_out + a*b is ended***\n\n");

	$display ("\n\n***Directed Functionality Test is applied for shifted output of  z_out = z_out + a*b***\n\n");
	a = 20'h80000;
	b = 18'h20000;
	shift_right = 6'h1;
	mult = (a*b);
	@(posedge clk)
	$display ("mult value:%0d", mult);
	expected_out2 = expected_out2 - mult;
	expected_out_shifted = expected_out2>>>shift_right;
	expected_out = expected_out_shifted;
	#2;
	display_stimulus();
	compare();
	@(negedge clk)
	$display ("\n\n***Directed Functionality Test for shifted output of  z_out = z_out + a*b is ended***\n\n");

	$display ("\n\n***Directed Functionality Test is applied for shifted output of  z_out = z_out + a*b***\n\n");
	a = 417393;
	b = 109048;
	shift_right = 6'd55;
	mult = (a*b);
	@(posedge clk)
	expected_out2 = expected_out2 - mult;
	expected_out_shifted = expected_out2>>>shift_right;
	expected_out = expected_out_shifted;
	#2;
	display_stimulus();
	compare();
	@(negedge clk)
	$display ("\n\n***Directed Functionality Test for shifted output of  z_out = z_out + a*b is ended***\n\n");

	$display ("\n\n*** Random Functionality Tests with random inputs are applied for shifted output of  z_out = z_out + a*b***\n\n");
	
	repeat (100) begin
		a = $random( );
		b = $random( );
		shift_right = $urandom( );
		mult = (a*b);
		@(posedge clk)
		expected_out2 = expected_out2 - mult;
		expected_out_shifted = expected_out2>>>shift_right;
		expected_out = expected_out_shifted;
		#2;
		display_stimulus();
		compare();
		@(negedge clk);
	end
	$display ("\n\n***Random Functionality Tests with random inputs for shifted output of  z_out = z_out + a*b are ended***\n\n");

	$display ("\n\n***tests for underflow***\n\n");
	a = -524280;
	b = 131070;
	shift_right = 1;

	repeat (100) begin
		mult = (a*b);
		@(posedge clk)
		expected_out2 = expected_out2 - mult;
		expected_out_shifted = expected_out2>>>shift_right;
		expected_out = expected_out_shifted;
		#2;
		display_stimulus();
		compare();
		@(negedge clk);
	end
	$display ("\n\n***tests for underflow ended***\n\n");

	$display ("\n\n***tests for overflow***\n\n");
	a = 524280;
	b = 131070;
	shift_right = 1;

	repeat (100) begin
		mult = (a*b);
		@(posedge clk)
		expected_out2 = expected_out2 - mult;
		expected_out_shifted = expected_out2>>>shift_right;
		expected_out = expected_out_shifted;
		#2;
		display_stimulus();
		compare();
		@(negedge clk);
	end
	$display ("\n\n***tests for overflow ended***\n\n");

    if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
	$finish;
end
	

task compare();
	if (expected_out2[shift_right -1]==1) begin //Rounding logic
		expected_out = expected_out + 1'b1;
	end
	if ((expected_out_shifted) >= $signed (64'd137438953471)) begin //Saturation overflow logic
		expected_out = 38'd137438953471;
	end
	if ((expected_out_shifted) <= $signed (-64'd137438953472)) begin //Saturation overflow logic
		expected_out = -38'd137438953472;
	end
 	
	if ((z_out !== expected_out)) begin
    	$display("Data Mismatch, Netlist: %0d, Expected output: %0d, Time: %0t", z_out, expected_out, $time);
    	mismatch = mismatch+1;
 	end
  	else
  		$display("Data Matched: Netlist: %0d,  Expected output: %0d, Time: %0t", z_out, expected_out, $time);
endtask

task display_stimulus();
	$display ($time,," Test stimulus is: a=%0d, b=%0d, shift_right=%0d", a, b, shift_right);
endtask

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule