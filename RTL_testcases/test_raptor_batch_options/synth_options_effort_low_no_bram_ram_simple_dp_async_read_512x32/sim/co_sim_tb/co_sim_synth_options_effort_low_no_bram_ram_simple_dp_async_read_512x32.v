
module co_sim_synth_options_effort_low_no_bram_ram_simple_dp_async_read_512x32;

    reg clk, we;
    reg [8:0] read_addr, write_addr;
    reg [31:0] din;
    wire [31:0] dout, dout_netlist;

    integer mismatch=0;
    reg [6:0]cycle, i;

    synth_options_effort_low_no_bram_ram_simple_dp_async_read_512x32 golden(.*);
    `ifdef PNR
    `else
        synth_options_effort_low_no_bram_ram_simple_dp_async_read_512x32_post_synth netlist(.*, .dout(dout_netlist));
    `endif


    always #10 clk = ~clk;

    initial begin
    {clk, we, read_addr, write_addr, din, cycle, i} = 0;

    for(integer i = 0; i<512; i=i+1) begin 
        golden.ram[i] ='b0;
    end    

    repeat (1) @ (negedge clk);
    //write and reads simulatneously from same read and write addr 
    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk)
        read_addr <= i; write_addr <= i; we <=1'b1; din<= $random;
        cycle = cycle +1;
        #1;
        compare(cycle);

    end

    //not writing and reading simulatneously from given addr
    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk)
        read_addr <= i; write_addr <= i; we <=0;
        cycle = cycle +1;
        #1;
        compare(cycle);

    end

    //read from random and write to all
    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk)
        read_addr <= $random; write_addr <= i; we <=1'b1; din<= $random;
        cycle = cycle +1;
        #1;
        compare(cycle);

    end

    //read from all
    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk)
        read_addr <= i; we <=0;
        cycle = cycle +1;
        #1;
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