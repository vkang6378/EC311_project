# EC311_project
Our EC311 project team 12 : xiaoxiao Yang, Jessica Qiu, Jueun Kang, Panqi Gu
our code structure: Snake_top - Top module which connects all other modules and the constraints file
                     -U1 clkdiv - divides a high-frequency input clock (clk) to generate a slower clock signal (clk25) at 25 Hz
                     -U2 vga - The vga module generates the timing signals for a 640x480 VGA display.
                     -U3 snake - includes several logics: Difficulty selection, Direction Control, Movement and Growth, Collision Detection, Food Generation, and state transitions
                     -U4 keyin & U5 keyboard - PS2keyboard to FPGA, failed
                     -U6 scoring - display the score one FPGA, failed
