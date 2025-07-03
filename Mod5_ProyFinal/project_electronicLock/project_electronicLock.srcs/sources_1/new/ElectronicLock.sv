`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2025 16:28:07
// Design Name: 
// Module Name: ElectronicLock
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


module ElectronicLock(
    input [3:0] A,      			// DIP Switch entradas (A1-A4)
    output green_led,   			// MATCH indicador
    output red_led      			// MISMATCH indicador
);

// Configuración de key  fijo (ejemplo: 4'b1010)
parameter [3:0] FIXED_KEY = 4'b1010;

// XNOR Etapa Uno comparación (comprobación de
// igualdad bit a bit)
wire [3:0] S;
assign S = A ~^ FIXED_KEY;  // S[i] = 1 when A[i] matches FIXED_KEY[i]

// Etapa Dos reduccion AND
wire stage1_out0 = S[0] & S[1];  	// Primer par (S1 & S2)
wire stage1_out1 = S[2] & S[3];  	// Segundo par (S3 & S4)
wire MATCH = stage1_out0 & stage1_out1;

// Asignaciones de salidas
assign green_led = MATCH;    		// LED Verde cuando los bits coinciden
assign red_led = ~MATCH;     		// LED Rojo cuando algún bit no coincide

endmodule
