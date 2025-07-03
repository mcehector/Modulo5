//Course: Certificacion en dise;o de circuitos integrados digitales
//Client: COCYTEN 2024
//Owner: Miguel Angel Rivera Acosta
//Laboratory 9: interface_sv
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
// end of RTL module }

//interface {
interface adder_interface (input logic clk, input logic rstn);
	
	logic [31:0] a, b;
	logic data_valid;
	logic [31:0] odata;
	logic odata_valid;

endinterface
// end interface }

//Testbench module {
module tb ();

	bit  clk, rstn;

	always #5 clk = !clk;
	assign #20 rstn = 1'b1;

	adder_interface intf(clk, rstn); //interface instantiation

	adder DUT(      //DUT instantiation
		.clk(clk),
		.rstn(rstn),
		.ivalid(intf.data_valid),
		.a(intf.a),
		.b(intf.b),
		.osum(intf.odata),
		.osum_valid(intf.odata_valid)
		);

		initial begin    //Process to generate stimulus
			@(posedge rstn);
			repeat(10) begin
				repeat($urandom_range(1,5)) @(posedge clk);
				intf.data_valid <= 1'b1; //assign a value of 1 to data_valid signal of interface intf
				intf.a <= $random;       //Assign a random value to a variable of interface intf
				intf.b <= $random;       //Assign a random value to b variable of interface intf
				@(posedge clk);
				intf.data_valid <= 1'b0;
			end
			repeat(10) @(posedge clk);
			$finish;
		end
endmodule
// end of testbench module}