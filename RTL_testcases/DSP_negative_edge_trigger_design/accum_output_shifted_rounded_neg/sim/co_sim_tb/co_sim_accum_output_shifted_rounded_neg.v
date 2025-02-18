module co_sim_accum_output_shifted_rounded_neg;
	reg signed [19:0] A;
	reg signed [17:0] B;
	reg clk, reset, subtract_i, load_acc_i ;
	reg [5:0] shift_right_i;
	reg round_i;
	wire signed [63:0] P;
	wire signed [63:0] P_netlist;

	integer mismatch=0;

accum_output_shifted_rounded_neg golden(.*);
    `ifdef PNR
    `else
    accum_output_shifted_rounded_neg_post_synth netlist(.*, .P(P_netlist));
    `endif

//clock initialization
initial begin
    clk = 1'b1;
    forever #5 clk = ~clk;
end
initial begin
	reset = 1;
	A=0;
	B=0;
	subtract_i = 0;
	shift_right_i = 0;
	round_i = 0;
	load_acc_i = 1;
	@(posedge clk);
	reset = 1;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(posedge clk);
	@(posedge clk);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");

	reset = 0;
	@(posedge clk);

	$display ("\n\n***Directed Functionality Test is applied for P = P + A*B***\n\n");
	A = 5;
	B = 2;
	display_stimulus();
	@(posedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for P = P + A*B is ended***\n\n");
        @(posedge clk);
	$display ("\n\n*** Random Functionality Tests with signed inputs are applied for P = P + A*B***\n\n");
	
        //@(posedge clk);
	A = $random( );
	B = $random( );
	@(posedge clk);
	repeat (32) begin
		display_stimulus();
		@(posedge clk);
		@(posedge clk);
		compare();
	end
	$display ("\n\n***Random Functionality Tests with signed inputs for P = P + A*B are ended***\n\n");
        
        //@(posedge clk);
	reset =1;
	A=0;
	B=0;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(posedge clk);
	@(posedge clk);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");

	subtract_i = 1;
	reset=0;
	@(posedge clk);
	$display ("\n\n***Reset Value is set zero again***\n\n");
                
	$display ("\n\n*** Random Functionality Tests with signed inputs are applied for P = P - A*B***\n\n");
	@(posedge clk);
	A = $random( );
	B = $random( );
	shift_right_i = $random( );
	round_i = 1;
	@(posedge clk);
	repeat (32) begin
		display_stimulus();
		@(posedge clk);
		@(posedge clk);
		compare();
	end
	$display ("\n\n***Random Functionality Tests with signed inputs for P = P - A*B are ended***\n\n");

	load_acc_i = 0;

	$display ("\n\n*** Random Functionality Tests with signed inputs are applied for P = P - A*B with load_acc_i = 0***\n\n");
	@(posedge clk);
	A = $random( );
	B = $random( );
	round_i = 0;
	@(posedge clk);
	repeat (32) begin
		display_stimulus();
		@(posedge clk);
		compare();
	end
	$display ("\n\n***Random Functionality Tests with signed inputs for P = P - A*B with load_acc_i = 0 are ended***\n\n");
	subtract_i = 0;

	$display ("\n\n*** Random Functionality Tests with signed inputs are applied for P = P + A*B with load_acc_i = 0***\n\n");
	@(posedge clk);
	A = $random( );
	B = $random( );
	@(posedge clk);
	repeat (32) begin
		display_stimulus();
		@(posedge clk);
		compare();
	end
	$display ("\n\n***Random Functionality Tests with signed inputs for P = P + A*B with load_acc_i = 0 are ended***\n\n");	
	if(mismatch == 0)
    	$display("\n**** All Comparison Matched ***\n");
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