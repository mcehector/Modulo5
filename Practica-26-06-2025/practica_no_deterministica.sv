module tb;
	int a, b, c;

	assign a = b - 1; //This continous assignment generates a process (p0)

	initial begin  // This initial procedural block generates a process (p1)
		b = 0;
		#1;
		b = 5;
		#2;
		b = 3;
		$finish;
	end

	always_comb begin // This always_comb procedural block generates a process (p2)
		c = a*b;
	end

	initial begin // This initial procedural block generates a process (p3)
		forever begin
			$display("a: %0d, b: %0d, c: %0d", a, b, c);
			#1;
		end
	end

endmodule