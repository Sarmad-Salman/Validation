
module co_sim_bytewrite_sp_ram_wf_block;
    //--------------------------------------------------------------------------
    parameter NUM_COL = 2; // 2 columns of 1 byte each make : 16 bits
    parameter COL_WIDTH = 8; //1 byte
    parameter ADDR_WIDTH = 10; // Addr Width in bits : 2 *ADDR_WIDTH = RAM Depth ---> 2^10 = 1024
    parameter DATA_WIDTH = NUM_COL*COL_WIDTH; // Data Width in bits
    //--------------------------------------------------------------------------

    reg clk;
    reg ena;
    reg [NUM_COL-1:0] we;
    reg [ADDR_WIDTH-1:0] addr;
    reg [DATA_WIDTH-1:0] din;
    wire [DATA_WIDTH-1:0] dout, dout_netlist;

    integer mismatch=0;
    reg [6:0]cycle, i;

    bytewrite_sp_ram_wf_block golden(.*);
    `ifdef PNR
    `else
        bytewrite_sp_ram_wf_block_post_synth netlist(.*, .dout(dout_netlist));
    `endif


    always #10 clk = ~clk;
    initial begin
        for(integer i = 0; i<1024; i=i+1) begin 
            golden.ram[i] ='b0;
        end  
    end 
    initial begin
    {clk, ena, we, addr ,din, cycle, i} = 0;


    repeat (1) @ (negedge clk);
    ena = 1'b1;
    //write and reads whats being written 
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <= i; we <=4'b1111; din<= $random;
        cycle = cycle +1;
       
        compare(cycle);

    end

    //not writing and reading simulatneously from given addr
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <= i; we <=0;
        cycle = cycle +1;
       
        compare(cycle);

    end
//repeat for ena 0
    ena = 1'b0;
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <= i; we <=4'b1111; din<= $random;
        cycle = cycle +1;
       
        compare(cycle);

    end

   
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <= i; we <=0;
        cycle = cycle +1;
       
        compare(cycle);

    end

     for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <=$random; we <=$random; din<= $random; ena = $random;
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