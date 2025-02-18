module co_sim_dsp_add_mul_output_to_accum_20lsb_neg;
	reg signed [19:0] A;
	reg signed [17:0] B;
	reg clk, reset;
	wire signed [37:0] P;
	wire signed [37:0] P_netlist;

	integer mismatch=0;

dsp_add_mul_output_to_accum_20lsb_neg golden(.*);
    `ifdef PNR
    `else
    dsp_add_mul_output_to_accum_20lsb_neg_post_synth netlist(.*, .P(P_netlist));
    `endif

//clock initialization
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end
initial begin
	reset = 0;
	A=0;
	B=0;
	@(negedge clk);
	reset = 1;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");

	reset = 0;
	@(posedge clk);

	$display ("\n\n***Directed Functionality Test is applied for P = P [19:0]+ A*B***\n\n");
	A = 20'h7ffff;
	B = 18'h1ffff;
	display_stimulus();
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for P = P [19:0]+ A*B is ended***\n\n");

	$display ("\n\n***Directed Functionality Test is applied for P = P [19:0]+ A*B***\n\n");
	A = 20'hfffff;
	B = 18'h3ffff;
	display_stimulus();
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for P = P [19:0]+ A*B is ended***\n\n");

	$display ("\n\n***Directed Functionality Test is applied for P = P [19:0]+ A*B***\n\n");
	A = 20'h80000;
	B = 18'h20000;
	display_stimulus();
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for P = P [19:0]+ A*B is ended***\n\n");

	$display ("\n\n*** Random Functionality Tests with signed inputs are applied for P = P [19:0]+ A*B***\n\n");
	repeat (600) begin
		A = $random( );
		B = $random( );
		@(posedge clk);
		display_stimulus();
		@(posedge clk);
		compare();
	end
	$display ("\n\n***Random Functionality Tests with signed inputs for P = P [19:0]+ A*B are ended***\n\n");

	reset =1;
	A=0;
	B=0;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");

	reset=0;
	@(posedge clk);
	$display ("\n\n***Reset Value is set zero again***\n\n");

	if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
	$finish;
end
	

task compare();
 	
  	if(P !== P_netlist) begin
    	$display("Data Mismatch. Golden: %0d, Netlist: %0d, Time: %0t", P, P_netlist, $time);
    	mismatch = mismatch+1;
 	end
  	else
  		$display("Data Matched. Golden: %0d, Netlist: %0d, Time: %0t", P, P_netlist, $time);
endtask

task display_stimulus();
	$display ($time,," Test stimulus is: A=%0d, B=%0d", A, B);
endtask

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule