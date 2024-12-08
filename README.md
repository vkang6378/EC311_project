# EC311_project
Our EC311 project team 12 : xiaoxiao Yang, Jessica Qiu, Jueun Kang, Panqi Gu <br>
our code structure: Snake_top - Top module which connects all other modules and the constraints file<br>
                     -U1 clkdiv - divides a high-frequency input clock (clk) to generate a slower clock signal (clk25) at 25 Hz<br>
                     -U2 vga - The vga module generates the timing signals for a 640x480 VGA display.<br>
                     -U3 snake - includes several logics: Difficulty selection, Direction Control, Movement and Growth, Collision Detection, Food Generation, and state transitions<br>
                     -U4 keyin & U5 keyboard - PS2keyboard to FPGA, failed<br>
                     -U6 scoring - display the score one FPGA, failed<br>

<br>
snake_top.bit is our bitstream file. After pushing it to the board, three coloered pixel will appear on VGA screen, waiting for choosing difficulty level, and only half of the computers in lab can run our game. Using switch to choose level, T18-easy level, R18-medium level & pause game, J13-hard level,using buttons to control the snake. 
<br>
<br>
the video link is https://youtu.be/4XBGjpF0j7E
