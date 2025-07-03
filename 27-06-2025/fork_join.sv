

//El objetivo es que corran el tb con:
//fork join y analizar los resultados
//fork join_any y analizar los resultados
//fork join_none y analizar los resultados
`timescale 1ns/1ps
module tb;
	int a;

	initial begin
		
		#0;

		fork
			
			begin
				a = 100;
				#1ns;
				a = 15;
				#1ns;
				a = 50;
				#1ns;
			end

			begin
				repeat(3) begin
					$display("a: %0d at time %0d", a, $time);
					#1ns;
				end
			end

			begin
				#2ns;
			end
		join
		//join_any
		//join_non

		$display("Parent porcess continued at time %0d", $time);

		#2ns;
		$finish;

	end

endmodule
