//course:Certificación en diseño de circuitos integrados digitales
// Client: COCYTEN 2024
// Owner: Miguel Angel Rivera Acosta
//Laboratory: rand_member_class_sv

module alu (
	input [1:0] sel,
	input [31:0] a, 
	input [31:0] b,
	output logic [31:0] z
	
);

	always_comb begin
			case (sel)
				2'b00: z = a + b;
				2'b01: z = a * b;
				2'b10: z = a | b;
				2'b11: z = a & b;
			
			endcase
	end
endmodule

//This is a class, which is a user-defined data type
class base_class;

	rand bit [31:0] var1; //class property
	rand logic [31:0] var2; //Class property
	rand logic [1:0] sel_;
	bit [31:0] var3; //class property
	logic [31:0] var4; //class Property

		//Constrain arthmetic_only {sel_ inside {0,1};};
		constraint logical_only {sel_ inside {2,3};};

	//The new method is the constructor of the class in SystemVerilog
	//The constructor Method is used to create an object of this class type
	function new();
	 	//Do nothing
	 endfunction

	 //Method to print the message member
	 function void print_all();
	 	$display("the value of var1 is: %b, \
	 		the value of var2 is: %b, \
	 		the value of var3 is: %b, \
	 		the value of var4 is: %b",var1, var2, var3, var4);
	 endfunction

	 function logic [31:0] user_random();
	 	logic [31:0] rand_value;
	 	std::randomize(rand_value);
	 	return rand_value;
	 endfunction
	
endclass

module tb;
	
	// Creates Handler for a variable called obj1, of base_class type
	base_class obj1;

	logic [1:0] sel;
	logic [31:0] a;
	logic [31:0] b;
	logic [31:0] z;

	alu DUT(
		.sel(sel)
		.a  (a)
		.b  (b)
		.z  (z)
	);

	initial begin
		//creates an object of base_class type, and links the object obj1 handler using the constructor
		obj1 = new();

		// Invokes the print_all method of obj1 object for printing the messages members
		//obj1.print_all();

		repeat(100) begin
			// Invokes the default randomization method that is inherited in all classes created in SystemVerilog
			obj1.randomize();

			//Invokes the print_all method of obj1 object for printing the messages members again
			obj1.print_all();
			sel = obj1.sel_;
			a = obj1.var1;
			b = obj1.var2;
			#5ns;
		end

		//Finishes the simulation
		$finish;
	end

endmodule