`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2025 16:52:20
// Design Name: 
// Module Name: testbench
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


module testbench;
 // Señales para conectar al DUT
  logic [3:0] A;
  logic green_led, red_led;

  		// Instancia del módulo a probar
  ElectronicLock dut (
    .A(A),
    .green_led(green_led),
    .red_led(red_led)
  );
 		 // Tarea para mostrar resultados
  task display_result;
    input [3:0] test_input;
    begin
      A = test_input;
      #5;
      $display("A = %b | Green LED = %b | Red LED = %b", A, green_led, red_led);
    end
  endtask
  		// Estímulo inicial
  initial begin
    $display("Iniciando pruebas del ElectronicLock...");

    display_result(4'b1010);  // Coincide (esperado: verde ON)
    display_result(4'b1110);  // No coincide
    display_result(4'b0010);  // No coincide
    display_result(4'b1011);  // No coincide
    display_result(4'b1000);  // No coincide
    display_result(4'b0000);  // No coincide

    $display("Pruebas finalizadas.");
    $finish;
  end

endmodule
