`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2025 17:25:24
// Design Name: 
// Module Name: pre_and_post_randomize_sv
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// Laboratory 7: pre_and_post_randomize_sv

//This is a class,wich is a user-defined data type
class base_class;
	rand bit [1:0] var1;
	randc logic [1:0] var2;
	 bit [1:0] var3;
	 logic[1:0] var4;

	 //constraint 

	 //The new method is the constructor of the class in Systemverilog
	 //The constructor method is used to create an object of this class tye
	 function new();
	 	//Do nothing
	 endfunction
	 //Method to print the message member
	 function void print_all();
	 	$display("the value of var1 is: %d, the value of var2 is: %d, the value of var3 is: %d, the value of var4 is: %d\n", var1, var2, var3, var4);
	 endfunction

//Inherited pre_randomize method
function void pre_randomize();
	$display("The values in post_randomize are:\n var1: %d, var2: %d, var3: %d, var4: %d\n", var1, var2, var3, var4);
	
endfunction

//Inherented post_ranomize method
function void post_randomize();
	$display("the values in post_randomize are:\n var1: %d, var2: %d, var3: %d, var4: %d\n", var1, var2, var3, var4);
	
endfunction


endclass

module tb;

	//creates handler for a variable called obj1, of base_class type
	base_class obj1;

	initial begin
		//creates an object of base_class type,  and links the object obj1 handler using the constructor
		obj1 = new();

		//Invokes the print_all method of obj1 object for printing the message members
		obj1.print_all();

		//invokes the default randomization method that is inherited in all class crearted in Systemverilog
		obj1.randomize();

		//Invokes the print_all method of obj1 object for printing the message members again
		obj1.print_all();
		//Finishes the simulation 
		$finish;
	end

endmodule
