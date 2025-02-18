// `include "full_adder.v"
// `include "register.v"
// `include "memory_cntrl.v"

module design97_6_5_top #(parameter WIDTH=32,CHANNEL=6) (clk, rst, in, out);

	localparam OUT_BUS=CHANNEL*WIDTH;
	input clk,rst;
	input [WIDTH-1:0] in;
	output [WIDTH-1:0] out;

	reg [WIDTH-1:0] d_in0;
	reg [WIDTH-1:0] d_in1;
	reg [WIDTH-1:0] d_in2;
	reg [WIDTH-1:0] d_in3;
	reg [WIDTH-1:0] d_in4;
	reg [WIDTH-1:0] d_in5;
	wire [WIDTH-1:0] d_out0;
	wire [WIDTH-1:0] d_out1;
	wire [WIDTH-1:0] d_out2;
	wire [WIDTH-1:0] d_out3;
	wire [WIDTH-1:0] d_out4;
	wire [WIDTH-1:0] d_out5;

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
		d_in3 <= tmp[(WIDTH*4)-1:WIDTH*3];
		d_in4 <= tmp[(WIDTH*5)-1:WIDTH*4];
		d_in5 <= tmp[(WIDTH*6)-1:WIDTH*5];
	end

	design97_6_5 #(.WIDTH(WIDTH)) design97_6_5_inst(.d_in0(d_in0),.d_in1(d_in1),.d_in2(d_in2),.d_in3(d_in3),.d_in4(d_in4),.d_in5(d_in5),.d_out0(d_out0),.d_out1(d_out1),.d_out2(d_out2),.d_out3(d_out3),.d_out4(d_out4),.d_out5(d_out5),.clk(clk),.rst(rst));

	assign out = d_out0^d_out1^d_out2^d_out3^d_out4^d_out5;

endmodule

module design97_6_5 #(parameter WIDTH=32) (d_in0, d_in1, d_in2, d_in3, d_in4, d_in5, d_out0, d_out1, d_out2, d_out3, d_out4, d_out5, clk, rst);
	input clk;
	input rst;
	input [WIDTH-1:0] d_in0; 
	input [WIDTH-1:0] d_in1; 
	input [WIDTH-1:0] d_in2; 
	input [WIDTH-1:0] d_in3; 
	input [WIDTH-1:0] d_in4; 
	input [WIDTH-1:0] d_in5; 
	output [WIDTH-1:0] d_out0; 
	output [WIDTH-1:0] d_out1; 
	output [WIDTH-1:0] d_out2; 
	output [WIDTH-1:0] d_out3; 
	output [WIDTH-1:0] d_out4; 
	output [WIDTH-1:0] d_out5; 

	wire [WIDTH-1:0] wire_d0_0;
	wire [WIDTH-1:0] wire_d0_1;
	wire [WIDTH-1:0] wire_d0_2;
	wire [WIDTH-1:0] wire_d0_3;
	wire [WIDTH-1:0] wire_d1_0;
	wire [WIDTH-1:0] wire_d1_1;
	wire [WIDTH-1:0] wire_d1_2;
	wire [WIDTH-1:0] wire_d1_3;
	wire [WIDTH-1:0] wire_d2_0;
	wire [WIDTH-1:0] wire_d2_1;
	wire [WIDTH-1:0] wire_d2_2;
	wire [WIDTH-1:0] wire_d2_3;
	wire [WIDTH-1:0] wire_d3_0;
	wire [WIDTH-1:0] wire_d3_1;
	wire [WIDTH-1:0] wire_d3_2;
	wire [WIDTH-1:0] wire_d3_3;
	wire [WIDTH-1:0] wire_d4_0;
	wire [WIDTH-1:0] wire_d4_1;
	wire [WIDTH-1:0] wire_d4_2;
	wire [WIDTH-1:0] wire_d4_3;
	wire [WIDTH-1:0] wire_d5_0;
	wire [WIDTH-1:0] wire_d5_1;
	wire [WIDTH-1:0] wire_d5_2;
	wire [WIDTH-1:0] wire_d5_3;

	memory_cntrl #(.WIDTH(WIDTH)) memory_cntrl_instance100(.data_in(d_in0),.data_out(wire_d0_0),.clk(clk),.rst(rst));            //channel 1
	register #(.WIDTH(WIDTH)) register_instance101(.data_in(wire_d0_0),.data_out(wire_d0_1),.clk(clk),.rst(rst));
	register #(.WIDTH(WIDTH)) register_instance102(.data_in(wire_d0_1),.data_out(wire_d0_2),.clk(clk),.rst(rst));
	memory_cntrl #(.WIDTH(WIDTH)) memory_cntrl_instance103(.data_in(wire_d0_2),.data_out(wire_d0_3),.clk(clk),.rst(rst));
	full_adder_top #(.WIDTH(WIDTH)) full_adder_instance104(.data_in(wire_d0_3),.data_out(d_out0),.clk(clk),.rst(rst));

	memory_cntrl #(.WIDTH(WIDTH)) memory_cntrl_instance210(.data_in(d_in1),.data_out(wire_d1_0),.clk(clk),.rst(rst));            //channel 2
	register #(.WIDTH(WIDTH)) register_instance211(.data_in(wire_d1_0),.data_out(wire_d1_1),.clk(clk),.rst(rst));
	full_adder_top #(.WIDTH(WIDTH)) full_adder_instance212(.data_in(wire_d1_1),.data_out(wire_d1_2),.clk(clk),.rst(rst));
	full_adder_top #(.WIDTH(WIDTH)) full_adder_instance213(.data_in(wire_d1_2),.data_out(wire_d1_3),.clk(clk),.rst(rst));
	register #(.WIDTH(WIDTH)) register_instance214(.data_in(wire_d1_3),.data_out(d_out1),.clk(clk),.rst(rst));

	full_adder_top #(.WIDTH(WIDTH)) full_adder_instance320(.data_in(d_in2),.data_out(wire_d2_0),.clk(clk),.rst(rst));            //channel 3
	full_adder_top #(.WIDTH(WIDTH)) full_adder_instance321(.data_in(wire_d2_0),.data_out(wire_d2_1),.clk(clk),.rst(rst));
	register #(.WIDTH(WIDTH)) register_instance322(.data_in(wire_d2_1),.data_out(wire_d2_2),.clk(clk),.rst(rst));
	register #(.WIDTH(WIDTH)) register_instance323(.data_in(wire_d2_2),.data_out(wire_d2_3),.clk(clk),.rst(rst));
	register #(.WIDTH(WIDTH)) register_instance324(.data_in(wire_d2_3),.data_out(d_out2),.clk(clk),.rst(rst));

	memory_cntrl #(.WIDTH(WIDTH)) memory_cntrl_instance430(.data_in(d_in3),.data_out(wire_d3_0),.clk(clk),.rst(rst));            //channel 4
	memory_cntrl #(.WIDTH(WIDTH)) memory_cntrl_instance431(.data_in(wire_d3_0),.data_out(wire_d3_1),.clk(clk),.rst(rst));
	memory_cntrl #(.WIDTH(WIDTH)) memory_cntrl_instance432(.data_in(wire_d3_1),.data_out(wire_d3_2),.clk(clk),.rst(rst));
	full_adder_top #(.WIDTH(WIDTH)) full_adder_instance433(.data_in(wire_d3_2),.data_out(wire_d3_3),.clk(clk),.rst(rst));
	register #(.WIDTH(WIDTH)) register_instance434(.data_in(wire_d3_3),.data_out(d_out3),.clk(clk),.rst(rst));

	register #(.WIDTH(WIDTH)) register_instance540(.data_in(d_in4),.data_out(wire_d4_0),.clk(clk),.rst(rst));            //channel 5
	memory_cntrl #(.WIDTH(WIDTH)) memory_cntrl_instance541(.data_in(wire_d4_0),.data_out(wire_d4_1),.clk(clk),.rst(rst));
	memory_cntrl #(.WIDTH(WIDTH)) memory_cntrl_instance542(.data_in(wire_d4_1),.data_out(wire_d4_2),.clk(clk),.rst(rst));
	register #(.WIDTH(WIDTH)) register_instance543(.data_in(wire_d4_2),.data_out(wire_d4_3),.clk(clk),.rst(rst));
	full_adder_top #(.WIDTH(WIDTH)) full_adder_instance544(.data_in(wire_d4_3),.data_out(d_out4),.clk(clk),.rst(rst));

	full_adder_top #(.WIDTH(WIDTH)) full_adder_instance650(.data_in(d_in5),.data_out(wire_d5_0),.clk(clk),.rst(rst));            //channel 6
	register #(.WIDTH(WIDTH)) register_instance651(.data_in(wire_d5_0),.data_out(wire_d5_1),.clk(clk),.rst(rst));
	memory_cntrl #(.WIDTH(WIDTH)) memory_cntrl_instance652(.data_in(wire_d5_1),.data_out(wire_d5_2),.clk(clk),.rst(rst));
	register #(.WIDTH(WIDTH)) register_instance653(.data_in(wire_d5_2),.data_out(wire_d5_3),.clk(clk),.rst(rst));
	full_adder_top #(.WIDTH(WIDTH)) full_adder_instance654(.data_in(wire_d5_3),.data_out(d_out5),.clk(clk),.rst(rst));


endmodule