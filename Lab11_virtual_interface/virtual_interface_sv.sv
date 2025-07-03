//Course: Certificacion en dise;o de circuitos integrados digitales
//Client: COCYTEN 2024
//Owner: Miguel Angel Rivera Acosta
//Laboratory 11: virtual_interface
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

class adder_stimulus_class;

	logic[31:0] max;
	rand bit [31:0] a;
	rand bit [31:0] b;
	virtual adder_interface vif; //virtual handle of adder_interface type

	constraint a_b_max {a <= max; b <= max;};

	function new();
		max = '1; //
	endfunction

	task task_initialize();
		vif.initialize();
	endtask

	task task_drive_rand_data();
		this.randomize();
		vif.drive_data(this.a, this.b);
	endtask
	task task_drive_100_rand_data();
		repeat(100) begin
			this.randomize();
			vif.drive_data(this.a, this.b);
		end
	endtask

	function func_set_max_value(int max);
		this.max = max;
	endfunction

endclass

module tb ();

	bit clk, rstn;
	adder_stimulus_class add_stimulus;

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
	add_stimulus = new(); //creates an object of adder_stimulus_class type
	add_stimulus.vif = intf; //assign theintf (adder_interface_handle)
		@(posedge rstn);
	add_stimulus.task_initialize();
		
		repeat(10) begin
			repeat($urandom_range(1,5)) @(posedge clk);
			add_stimulus.task_drive_rand_data();
		end
		
		repeat($urandom_range(10,50)) @(posedge clk);
		add_stimulus.task_drive_100_rand_data();
		repeat($urandom_range(10,50)) @(posedge clk);
		add_stimulus.func_set_max_value(100);
		add_stimulus.task_drive_100_rand_data();
		repeat($urandom_range(10,50)) @(posedge clk);
		repeat(10) @(posedge clk);
		$finish;
	end

endmodule