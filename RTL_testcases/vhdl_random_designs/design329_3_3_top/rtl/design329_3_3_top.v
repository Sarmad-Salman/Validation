// `include "register_vhd.v"
// `include "alu_top_vhd.v"
// `include "decoder_top_vhd.v"
// `include "mux_top_vhd.v"
// `include "shift_reg_top_vhd.v"
// `include "rom_top_vhd.v"

module design329_3_3_top #(parameter WIDTH=32,CHANNEL=3) (clk, rst, in, out);

	localparam OUT_BUS=CHANNEL*WIDTH;
	input clk,rst;
	input [WIDTH-1:0] in;
	output [WIDTH-1:0] out;

	reg [WIDTH-1:0] d_in0;
	reg [WIDTH-1:0] d_in1;
	reg [WIDTH-1:0] d_in2;
	wire [WIDTH-1:0] d_out0;
	wire [WIDTH-1:0] d_out1;
	wire [WIDTH-1:0] d_out2;

	reg [OUT_BUS-1:0] tmp;

	always @ (posedge clk or posedge rst) begin
		if (rst)
			tmp <= 0;
		else
			tmp <= {tmp[OUT_BUS-(WIDTH-1):0],in};
	end

	always @ (posedge clk) begin
		d_in0 <= tmp[WIDTH-1:0];
		d_in1 <= tmp[(WIDTH*2)-1:WIDTH*1];
		d_in2 <= tmp[(WIDTH*3)-1:WIDTH*2];
	end

	design329_3_3 #(.WIDTH(WIDTH)) design329_3_3_inst(.d_in0(d_in0),.d_in1(d_in1),.d_in2(d_in2),.d_out0(d_out0),.d_out1(d_out1),.d_out2(d_out2),.clk(clk),.rst(rst));

	assign out = d_out0^d_out1^d_out2;

endmodule

module design329_3_3 #(parameter WIDTH=32) (d_in0, d_in1, d_in2, d_out0, d_out1, d_out2, clk, rst);
	input clk;
	input rst;
	input [WIDTH-1:0] d_in0; 
	input [WIDTH-1:0] d_in1; 
	input [WIDTH-1:0] d_in2; 
	output [WIDTH-1:0] d_out0; 
	output [WIDTH-1:0] d_out1; 
	output [WIDTH-1:0] d_out2; 

	wire [WIDTH-1:0] wire_d0_0;
	wire [WIDTH-1:0] wire_d0_1;
	wire [WIDTH-1:0] wire_d1_0;
	wire [WIDTH-1:0] wire_d1_1;
	wire [WIDTH-1:0] wire_d2_0;
	wire [WIDTH-1:0] wire_d2_1;

	mux_top_vhd #(.WIDTH(WIDTH)) mux_top_vhd_instance100(.data_in(d_in0),.data_out(wire_d0_0),.clk(clk),.rst(rst));            //channel 1
	alu_top_vhd #(.WIDTH(WIDTH)) alu_top_vhd_instance101(.data_in(wire_d0_0),.data_out(wire_d0_1),.clk(clk),.rst(rst));
	rom_top_vhd #(.WIDTH(WIDTH)) rom_top_vhd_instance102(.data_in(wire_d0_1),.data_out(d_out0),.clk(clk),.rst(rst));

	mux_top_vhd #(.WIDTH(WIDTH)) mux_top_vhd_instance210(.data_in(d_in1),.data_out(wire_d1_0),.clk(clk),.rst(rst));            //channel 2
	rom_top_vhd #(.WIDTH(WIDTH)) rom_top_vhd_instance211(.data_in(wire_d1_0),.data_out(wire_d1_1),.clk(clk),.rst(rst));
	register_vhd #(.WIDTH(WIDTH)) register_vhd_instance212(.data_in(wire_d1_1),.data_out(d_out1),.clk(clk),.rst(rst));

	mux_top_vhd #(.WIDTH(WIDTH)) mux_top_vhd_instance320(.data_in(d_in2),.data_out(wire_d2_0),.clk(clk),.rst(rst));            //channel 3
	decoder_top_vhd #(.WIDTH(WIDTH)) decoder_top_vhd_instance321(.data_in(wire_d2_0),.data_out(wire_d2_1),.clk(clk),.rst(rst));
	shift_reg_top_vhd #(.WIDTH(WIDTH)) shift_reg_top_vhd_instance322(.data_in(wire_d2_1),.data_out(d_out2),.clk(clk),.rst(rst));


endmodule