
module co_sim_rams_sp_rf_sync_1024x64;
    reg clk;
    reg we;
    reg [9:0] addr;
    reg [63:0] di;
    wire [63:0] dout, dout_netlist;

    integer mismatch=0;
    reg [6:0]cycle, i;

    rams_sp_rf_sync_1024x64 golden(.*);
    `ifdef PNR
    `else
        rams_sp_rf_sync_1024x64_post_synth netlist(.*, .dout(dout_netlist));
    `endif


    always #10 clk = ~clk;
    initial begin
        for(integer i = 0; i<1024; i=i+1) begin 
            golden.RAM[i] ='b0;
        end 
    end
    initial begin
    {clk, we, addr ,di, cycle, i} = 0;

     repeat (1) @ (negedge clk);

    //write, but will read zero as those locations are not written yet and are initialized to zero (always reading irrespective of we)
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <= i; we <=1; di<= $random;
        cycle = cycle +1;
 
        compare(cycle);

    end

    //not writing
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <= i; we <=0;
        cycle = cycle +1;

        compare(cycle);

    end

    //random
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        we<=$random;  addr<=$random; di<=$random;
        cycle = cycle +1;
        compare(cycle);

    end

    if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
    

    repeat (10) @(negedge clk); $finish;
    end

    task compare(input integer cycle);
    //$display("\n Comparison at cycle %0d", cycle);
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
