# Integer Organizer
> Randomly obtains 200 numbers between 15-50 (inclusive) and displays it in the form of an array. Will sort all the numbers from lowest to highest using a bubble sort. Displays the median as well as counting the number of times each number between 15-50 (inclusive) appears in the array.


## Table of Contents
* [General Info](#general-information)
* [Technologies Used](#technologies-used)
* [Features](#features)
* [Screenshots](#screenshots)
* [Setup](#setup)
* [Usage](#usage)
* [Project Status](#project-status)
* [Room for Improvement](#room-for-improvement)
* [Acknowledgements](#acknowledgements)
* [Contact](#contact)
<!-- * [License](#license) -->


## General Information
- The parameters of the project will depend on the global variables ARRAYSIZE, LO, and HI. Arraysize is set to default 200 and will change the number of random integers initially added to the array. LO and HI are the bounds of numbers that are generated into the array.
- The purpose of this project is to reinforce concepts related to usage of the runtime stack, proper modularization practices, use of STDCALL calling conventions, use of arrays in x86 assembly language, and Indirect Operands addressing modes (CLO 3, 4, 5)


## Technologies Used
- N/A


## Features
- Generates and displays an array of random integers. The size will depend on ARRAYSIZE global variable and the bounds will depend on LO and HI global variables (inclusive).
- Sorts the array generated using bubble sort and displays the sorted array.
- Finds the median value of the array.
- Counts the number of times each number between LO and HI global variables appears in the random array. This values are put into another array and displayed.


## Screenshots

![Example screenshot](https://user-images.githubusercontent.com/50156212/207250075-ba8afe66-dfb9-4897-83b9-16a0f35e4048.PNG)



## Setup
No setup required. Only an editor to write x86 assembly code.
Link to Visual Studio here:
https://visualstudio.microsoft.com/

## Usage
User will only need to run program for it to function. Global variables ARRAYSIZE, LO, and HI can be altered to change the size of the generated array and the random numbers generated that go into the array.

For example:

- Changing the default ARRAYSIZE = 200 to ARRAYSIZE = 300 will generate an array with 300 values instead of 200
- Changing the default LO = 15 to LO = 30 will change the minimum value of randomly generated numbers from 15 to 30
- Changing the default HI = 50 to HI = 100 will change the maximum value of randomly generated numbers from 50 to 100



## Project Status
Project is: _complete_


## Room for Improvement
Room for improvement:
- Add more functionalities to how the array is processed such as finding the mode and average as well.

To do:
- Generating the numbers directly into a file, then read the file into the array. This may modify procedure parameters however.


## Acknowledgements
Give credit here.
- This project was created by OSU 271 to allow students to develop their understanding of arrays, addressing, and stack-passed parameters


## Contact
Created by Michael Vuong.https://www.linkedin.com/in/vuong-michael/ - feel free to contact me!


 ## License
N/A

