module soc_fpga_intf_axi_m0_m1 (
    
    input  [31:0] M0_ARADDR,
    input  [ 1:0] M0_ARBURST,
    input  [ 3:0] M0_ARCACHE,
    input  [ 3:0] M0_ARID,
    input  [ 2:0] M0_ARLEN,
    input         M0_ARLOCK,
    input  [ 2:0] M0_ARPROT,
    output        M0_ARREADY,
    input  [ 2:0] M0_ARSIZE,
    input         M0_ARVALID,
    input  [31:0] M0_AWADDR,
    input  [ 1:0] M0_AWBURST,
    input  [ 3:0] M0_AWCACHE,
    input  [ 3:0] M0_AWID,
    input  [ 2:0] M0_AWLEN,
    input         M0_AWLOCK,
    input  [ 2:0] M0_AWPROT,
    output        M0_AWREADY,
    input  [ 2:0] M0_AWSIZE,
    input         M0_AWVALID,
    output [ 3:0] M0_BID,
    input         M0_BREADY,
    output [ 1:0] M0_BRESP,
    output        M0_BVALID,
    output [63:0] M0_RDATA,
    output [ 3:0] M0_RID,
    output        M0_RLAST,
    input         M0_RREADY,
    output [ 1:0] M0_RRESP,
    output        M0_RVALID,
    input  [63:0] M0_WDATA,
    input         M0_WLAST,
    output        M0_WREADY,
    input  [ 7:0] M0_WSTRB,
    input         M0_WVALID,
    input  [31:0] M1_ARADDR,
    input  [ 1:0] M1_ARBURST,
    input  [ 3:0] M1_ARCACHE,
    input  [ 3:0] M1_ARID,
    input  [ 3:0] M1_ARLEN,
    input         M1_ARLOCK,
    input  [ 2:0] M1_ARPROT,
    output        M1_ARREADY,
    input  [ 2:0] M1_ARSIZE,
    input         M1_ARVALID,
    input  [31:0] M1_AWADDR,
    input  [ 1:0] M1_AWBURST,
    input  [ 3:0] M1_AWCACHE,
    input  [ 3:0] M1_AWID,
    input  [ 3:0] M1_AWLEN,
    input         M1_AWLOCK,
    input  [ 2:0] M1_AWPROT,
    output        M1_AWREADY,
    input  [ 2:0] M1_AWSIZE,
    input         M1_AWVALID,
    output [ 3:0] M1_BID,
    input         M1_BREADY,
    output [ 1:0] M1_BRESP,
    output        M1_BVALID,
    output [31:0] M1_RDATA,
    output [ 3:0] M1_RID,
    output        M1_RLAST,
    input         M1_RREADY,
    output [ 1:0] M1_RRESP,
    output        M1_RVALID,
    input  [31:0] M1_WDATA,
    input         M1_WLAST,
    output        M1_WREADY,
    input  [ 3:0] M1_WSTRB,
    input         M1_WVALID,
    input         M0_ACLK,
    input         M1_ACLK,
    output        M0_ARESETN_I, 
    output        M1_ARESETN_I        
);

SOC_FPGA_INTF_AXI_M0_M1 inst(
    .M0_ARADDR(M0_ARADDR)   ,
    .M0_ARBURST(M0_ARBURST)  ,
    .M0_ARCACHE(M0_ARCACHE)  ,
    .M0_ARID(M0_ARID)     ,
    .M0_ARLEN(M0_ARLEN)    ,
    .M0_ARLOCK(M0_ARLOCK)   ,
    .M0_ARPROT(M0_ARPROT)   ,
    .M0_ARREADY(M0_ARREADY)  ,
    .M0_ARSIZE(M0_ARSIZE)   ,
    .M0_ARVALID(M0_ARVALID)  ,
    .M0_AWADDR(M0_AWADDR)   ,
    .M0_AWBURST(M0_AWBURST)  ,
    .M0_AWCACHE(M0_AWCACHE)  ,
    .M0_AWID(M0_AWID)     ,
    .M0_AWLEN(M0_AWLEN)    ,
    .M0_AWLOCK(M0_AWLOCK)   ,
    .M0_AWPROT(M0_AWPROT)   ,
    .M0_AWREADY(M0_AWREADY)  ,
    .M0_AWSIZE(M0_AWSIZE)   ,
    .M0_AWVALID(M0_AWVALID)  ,
    .M0_BID(M0_BID)      ,
    .M0_BREADY(M0_BREADY)   ,
    .M0_BRESP(M0_BRESP)    ,
    .M0_BVALID(M0_BVALID)   ,
    .M0_RDATA(M0_RDATA)    ,
    .M0_RID(M0_RID)      ,
    .M0_RLAST(M0_RLAST)    ,
    .M0_RREADY(M0_RREADY)   ,
    .M0_RRESP(M0_RRESP)    ,
    .M0_RVALID(M0_RVALID)   ,
    .M0_WDATA(M0_WDATA)    ,
    .M0_WLAST(M0_WLAST)    ,
    .M0_WREADY(M0_WREADY)   ,
    .M0_WSTRB(M0_WSTRB)    ,
    .M0_WVALID(M0_WVALID)   ,
    .M1_ARADDR(M1_ARADDR)   ,
    .M1_ARBURST(M1_ARBURST)  ,
    .M1_ARCACHE(M1_ARCACHE)  ,
    .M1_ARID(M1_ARID)     ,
    .M1_ARLEN(M1_ARLEN)    ,
    .M1_ARLOCK(M1_ARLOCK)   ,
    .M1_ARPROT(M1_ARPROT)   ,
    .M1_ARREADY(M1_ARREADY)  ,
    .M1_ARSIZE(M1_ARSIZE)   ,
    .M1_ARVALID(M1_ARVALID)  ,
    .M1_AWADDR(M1_AWADDR)   ,
    .M1_AWBURST(M1_AWBURST)  ,
    .M1_AWCACHE(M1_AWCACHE)  ,
    .M1_AWID(M1_AWID)     ,
    .M1_AWLEN(M1_AWLEN)    ,
    .M1_AWLOCK(M1_AWLOCK)   ,
    .M1_AWPROT(M1_AWPROT)   ,
    .M1_AWREADY(M1_AWREADY)  ,
    .M1_AWSIZE(M1_AWSIZE)   ,
    .M1_AWVALID(M1_AWVALID)  ,
    .M1_BID(M1_BID)      ,
    .M1_BREADY(M1_BREADY)   ,
    .M1_BRESP(M1_BRESP)    ,
    .M1_BVALID(M1_BVALID)   ,
    .M1_RDATA(M1_RDATA)    ,
    .M1_RID(M1_RID)      ,
    .M1_RLAST(M1_RLAST)    ,
    .M1_RREADY(M1_RREADY)   ,
    .M1_RRESP(M1_RRESP)    ,
    .M1_RVALID(M1_RVALID)   ,
    .M1_WDATA(M1_WDATA)    ,
    .M1_WLAST(M1_WLAST)    ,
    .M1_WREADY(M1_WREADY)   ,
    .M1_WSTRB(M1_WSTRB)    ,
    .M1_WVALID(M1_WVALID)   ,
    .M0_ACLK(M0_ACLK)     ,
    .M1_ACLK(M1_ACLK)     ,
    .M0_ARESETN_I(M0_ARESETN_I),
    .M1_ARESETN_I(M1_ARESETN_I)        
);

endmodule 
