class message_class3 extends message_class2

	static string message3 = "This is the default value"; //Class static property

	//the new methodis the costructor of the class in SystemVerilog
	// the constructor method is used to create an objectof this class type

	function new();
		super.new();
		message3 = "This is the value assigned when an object of message_class3 type is created";
	endfunction

	//Method to print the message3 static member
	//Satic method only can call other static members
	static function void print_message3();
		$display("%s", message);
	endfunction


endclass

module tb;
	//creates a handler for variable called printer_, of message_class3 type
	message_class3 printer_;
	initial begin

		//invoke the static method member print_message3
		message_class3::print_message3();

		//Assign a value to the static member message3
		message_class3::message3 = "Hi from the static method!";

		//Invokes the static method member print_message3
		message_class3::print_message3;

		//creates an object of message_class3 type, and links the object to printer_handler using the constructor
		printer = new();

		//invokes the statics method member print_message3
		message_class3::print_message();

		//Invokes the print_message2 method of printed_ object for printing the messages members
		printer_.print_message2();

		//assign a new value to message member of printer_ object
		printer_.