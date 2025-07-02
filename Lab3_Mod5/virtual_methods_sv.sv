//course: certificacion en diseño de circuitos integrados digitales
//Client: COCYTEN 2024
//Owner: Miguel Angel Rivera Acosta
//Laboratory 3: virtual_methods_sv

// this is a class, wich us a user-defined data type
class addition_parent_class;
	int a, b; // class properties

	// The new method us the constructor of the class un Systemverilog
	//The constructor method us used to create an object of this class type
	function new();
		//do nothing
	endfunction

	//method to print the message member
	virtual function void print_operation();
		std::randomize(a) with {a <= 100;};
		std::randomize(b) with {b <= 100;};
		$display("The result of the sum of %0d + %0d is: %0d", a, b, a + b);
	endfunction
endclass

//This is a class, which is a user-defined data type
class multiplication_child_class extends addition_parent_class;  /* base class*/
	
	//The new method is te costructor of the class in systemVerilog
	//The new constructor method is used to create an object of this class type
	function new();
		//Do nothing
	endfunction

	//Mehotd to print the message member
	virtual function void print_operation();
		std::randomize(a) with {a <= 100;};
		std::randomize(b) with {b <= 100;};
		$display("The Result of the multiplication of %0d * %0d is: %0d", a, b, a * b);
	endfunction
endclass

// This is a class, which is a user-defined data type
class division_child_class extends addition_parent_class;  /* base class*/
	
	//The new method is the constructor of the class in SystemVerilog
	//The constructor method is used to create an object of this class type
	function new();
		//Do nothing
	endfunction

	//Method to print the message member
	virtual function void print_operation();
		std::randomize(a) with {a <= 100;};
		std::randomize(b) with {b <= 100;};
		$display("The Result of the division of %0d / %0d is: %0d", a, b, a / b);

	endfunction
endclass

module tb;
	//creates a handler for variable called parent_add_obj, of addition_parent_class type
	addition_parent_class parent_add_obj;
	//Creates a handler for a variable called child_mult_obj, of multiplication_child_class type
	multiplication_child_class child_mult_obj;
	//Creates a handler for a variable called child_div_obj, of division_child_class type
	division_child_class child_div_obj;

	initial begin
		//creates an object of addition_parent_class type, and links the object parent_add_obj handler using the constructor
		parent_add_obj = new();

		//Creates an object of multimplication_child_class type, and links the object child_mult_obj handler using the constructor
		child_mult_obj = new();

		
	end
endmodule : tb;
