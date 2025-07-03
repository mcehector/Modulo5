//Course: Certificacion en dise;o de circuitos integrados digitales
//Client: COCYTEN 2024
//Owner: Miguel Angel Rivera Acosta
//Laboratory 10: interface_bfm_sv
`timescale 1ns / 1ps

//RTL module {
module adder (
	input logic clk,
	input logic rstn,
	input logic ivalid,
	input logic [31:0] a,
	input logic [31:0] b,
	output logic [31:0] osum,
	output logic osum_valid	
);

	always_ff @(posedge clk, negedge rstn) begin
		if(!rstn) begin
			 osum <= '0;
			 osum_valid <= 1'b0;
		end else begin
			if (ivalid)
				osum <= a + b;
				osum_valid <= ivalid;
		end
	end

endmodule

interface adder_interface (input logic clk, input logic rstn);

	logic[31:0] a, b;
	logic data_valid;
	logic [31:0] odata;
	logic odata_valid;

	//bus functional model (BFM) {
	task initialize();
		a <= '0;
		b <= '0;
		data_valid <= 1'b0;
	endtask

	task drive_random_data();
		std::randomize(a);
		std::randomize(b);
		data_valid <= 1'b1;
		@(posedge clk);
		a <= '0;
		b <= '0;
		data_valid <= 1'b0;
	endtask
	
	task drive_data(bit [31:0] data_a, bit [31:0] data_b);
		a <= data_a;
		b <= data_b;
		data_valid <= 1'b1;
		@(posedge clk);
		a <= '0;
		b <= '0;
		data_valid <= 1'b0;
	endtask
	// }

endinterface

module tb ();

	bit clk, rstn;

	always #5 clk = !clk;
	assign #20 rstn = 1'b1;

	adder_interface intf(clk, rstn);

	adder DUT(
		.clk(clk),
		.rstn(rstn),
		.ivalid(intf.data_valid),
		.a(intf.a),
		.b(intf.b),
		.osum(intf.odata),
		.osum_valid(intf.odata_valid)
		);

	initial begin
		@(posedge rstn);
		intf.initialize();
		repeat(10) begin
			repeat($urandom_range(1,5)) @(posedge clk);
			intf.drive_random_data();
		end
		repeat(10) @(posedge clk);
		$finish;
	end

endmodule