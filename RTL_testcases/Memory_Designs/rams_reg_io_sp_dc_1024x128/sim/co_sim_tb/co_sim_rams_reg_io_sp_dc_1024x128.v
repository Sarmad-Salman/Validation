
module co_sim_rams_reg_io_sp_dc_1024x128;
    reg clkA;
    reg clkB;
    reg we;
    reg [9:0] addr;
    reg [127:0] di;
    wire [127:0] dout, dout_netlist;

    integer mismatch=0;
    reg [6:0] cycleA, cycleB, i;

    rams_reg_io_sp_dc_1024x128 golden(.*);
    `ifdef PNR
    `else
        rams_reg_io_sp_dc_1024x128_post_synth netlist(.*, .dout(dout_netlist));
    `endif


      //clock//
    initial begin
        clkA = 1'b0;
        forever #5 clkA = ~clkA;
    end
    initial begin
        
        clkB = 1'b0;
        forever #10 clkB = ~clkB;
    end

    initial begin
    {clkA, clkB, we, addr ,di, cycleA, cycleB, i} = 0;

    for(integer i = 0; i<1024; i=i+1) begin 
        golden.RAM[i] ='b0;
    end    

    // repeat (1) @ (negedge clk);
      for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clkA)
        addr <= i; we <=1; di<= $random;

    end
    //write
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clkA)
        addr <= i; we <=1; di<= $random;
        cycleA = cycleA +1;
        #1;
        compare(cycleA, cycleB);

    end

    //will always read last registered address in previous for loop
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clkB)
        addr <= i; we <=0;
        cycleB = cycleB +1;
        #1;
        compare(cycleA, cycleB);

    end

    //write and then read from addr clkA register during negedge of clkB
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clkA)
        addr <= i; we <=1; di<= $random;
        cycleA = cycleA +1;
        repeat (1) @ (negedge clkB)
        addr <= i; we <=0; di<= $random;
        cycleB = cycleB +1;
        #1;
        compare(cycleA, cycleB);

    end
   if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
    

    repeat (10) @(negedge clkA); $finish;
    end

    task compare(input integer cycle1, cycle2);
    //$display("\n Comparison at cycleA %0d and cycleB %0d", cycle1, cycle2);
    if(dout !== dout_netlist) begin
        $display("dout mismatch. Golden: %0h, Netlist: %0h, Time: %0t", dout, dout_netlist,$time);
        mismatch = mismatch+1;
    end
    
    endtask


initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule