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

_ s0 - ascii value to 'a'   
_ s1 - ascii value to 'd'  
_ s2 - ascii value to 's'  
_ s3 - ascii value to 'w'  
_ s4 - value to vetor with snake. The first value is the size and the others are coordinates where the 16 most significant bits represent the x coordinate and 16 least significant bits represent the y coordinate.