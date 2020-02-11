# __Snake Game - assembly risc-v__

##  About
The game was implemented by students of Control and Automation in the University of Brasilia while studying Computers Architecture and Organization. The participants are:
* Gabriel Castro
* Lucas
* Rodrigo
* Stephanie Cardoso

## The game

### __Processor Registers__
There are some constant registers because they are used frequently in the code:

| Registradores | Uso                                                                   |
|---------------|-----------------------------------------------------------------------|
| s0            | ascii value to 'a'                                                    |
| s1            | ascii value to 'd'                                                    |
| s2            | ascii value to 's'                                                    |
| s3            | ascii value to 'w'                                                    |
| s4            | Vector with the coordinates of the snake, the first one is the lenght |
| s5            | Coordinate of the fruit                                               |
| s6            | Time of Sleep function                                                |
| s7            | Score and Speed Images                                                |
| s8            | Score                                                                 |
| s9            | Speed                                                                 |
| s11           | The last key pressed                                                  |


### __Modules and Functions__
The game was made using the like an unit an small square of 8 x 8.
* MAIN FILE - The code to call all the principal functions in the game.
* START_GAME - Label in the main.asm that start and restart the game.
* DOT - Function that draw the code unit of 8 x 8.
* FRUIT - The function draw an square red fruit.
* SLEEP - Receive in s6 a value in ms to pause until the next instruction.