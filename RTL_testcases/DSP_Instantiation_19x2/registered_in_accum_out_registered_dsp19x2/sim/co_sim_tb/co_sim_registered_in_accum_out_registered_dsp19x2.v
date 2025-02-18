module co_sim_registered_in_accum_out_registered_dsp19x2;
	reg  [19:0] a;
	reg  [17:0] b;
	reg clk, reset;
	wire  [37:0] z_out;
	reg [31:0]mult1, mult2;
	reg  [37:0] expected_out;

	integer mismatch=0;
`ifdef PNR
`else

registered_in_accum_out_registered_dsp19x2 golden(.*);
`endif


//clock initialization
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end
initial begin
	{reset, a, b, expected_out, mult1, mult2} = 'd0;
	@(negedge clk);
	reset = 1;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");

	reset = 0;
	@(negedge clk);

	$display ("\n\n***Directed Functionality Test is applied ***\n\n");
	a = 20'h7ffff;
	b = 18'h1ffff;
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	@(negedge clk);
	mult1 = a[9:0]*b[8:0];
	mult2 = a[19:10]*b[17:9];
	expected_out = {mult2[18:0],mult1[18:0]};
	@(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test  is ended***\n\n");

	
	$display ("\n\n*** Random Functionality Tests with random inputs are applied ***\n\n");
	repeat (600) begin
		a = $urandom( );
		b = $urandom( );
		@(negedge clk);
		mult1 = a[9:0]*b[8:0];
		mult2 = a[19:10]*b[17:9];
		expected_out = {mult2[18:0],mult1[18:0]}; //calculate the result at every negedge
		display_stimulus();
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		compare();
	end
	$display ("\n\n***Random Functionality Tests with random inputs  are ended***\n\n");

    if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
	$finish;
end
	

task compare();
 	if ((z_out !== expected_out)) begin
    	$display("Data Mismatch, Netlist: %0d, Expected output: %0d, Time: %0t", z_out, expected_out, $time);
    	mismatch = mismatch+1;
 	end
  	else
  		$display("Data Matched: Netlist: %0d,  Expected output: %0d, Time: %0t", z_out, expected_out, $time);
endtask

task display_stimulus();
	$display ($time,," Test stimulus is: a=%0d, b=%0d", a, b);
endtask

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule