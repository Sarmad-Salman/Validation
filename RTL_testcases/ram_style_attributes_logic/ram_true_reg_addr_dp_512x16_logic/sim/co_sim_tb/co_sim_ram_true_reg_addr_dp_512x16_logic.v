
module co_sim_ram_true_reg_addr_dp_512x16_logic;

    reg clk, weA, weB;
    reg [8:0] addrA, addrB;
    reg [15:0] dinA, dinB;
    wire [15:0] doutA, doutB, doutA_netlist, doutB_netlist;

    integer mismatch=0;
    reg [6:0]cycle, i;

    ram_true_reg_addr_dp_512x16_logic golden(.*);
    `ifdef PNR
    `else
        ram_true_reg_addr_dp_512x16_logic_post_synth netlist(.*, .doutA(doutA_netlist), .doutB(doutB_netlist));
    `endif


    always #10 clk = ~clk;

    initial begin
        
    {clk, weA,weB, addrA,addrB, dinA, dinB, cycle, i} = 0;

  
 
    repeat (1) @ (negedge clk);
    
    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk)

        addrA <= i; addrB <= {$random} % 512; weA <=1'b1; weB <=1'b1; dinA<= {$random}; dinB<= {$random};
        cycle = cycle +1;
        #1;
        compare(cycle);

    end

     for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk)
        addrA <= i; addrB <= i; weA <=1'b1; weB <=1'b0; dinA<= {$random}; dinB<= {$random};
        cycle = cycle +1;
        #1;
        compare(cycle);
    end

    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk)
        addrA <= i; addrB <= i; weA <=1'b1; weB <=1'b1; dinA<= {$random}; dinB<= {$random};
        cycle = cycle +1;
        #1;
        compare(cycle);
    end

   for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk)
        addrA <= i; addrB <= i; weA <=1'b0; weB <=1'b0; dinA<= {$random}; dinB<= {$random};
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
    if(doutA !== doutA_netlist) begin
        $display("doutA mismatch. Golden: %0h, Netlist: %0h, Time: %0t", doutA, doutA_netlist,$time);
        mismatch = mismatch+1;
    end

     if(doutB !== doutB_netlist) begin
        $display("doutB mismatch. Golden: %0h, Netlist: %0h, Time: %0t", doutB, doutB_netlist,$time);
        mismatch = mismatch+1;
    end
    
    
    endtask


initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule