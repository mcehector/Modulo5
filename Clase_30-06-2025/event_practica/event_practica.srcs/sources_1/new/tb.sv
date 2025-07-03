`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2025 17:05:16
// Design Name: 
// Module Name: tb
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


module tb;
 	bit p, q;
 	event ev;

 	always_comb begin
 		p = q;
 		->ev;
 	end

 	initial begin
 		repeat (10) begin
 			q = 1;
 			#1;
 			q = 0;
 			wait (ev.triggered);
 			//@ev; //This is another alternative
 			$display(p);
 		end
 	end
 	
endmodule