TITLE Arrays, Addressing, & Stack-Passed Parameter    (Proj5_vuongmi.asm)

; Author: Michael Vuong
; Last Modified: 11/18/22
; OSU email address: vuongmi@oregonstate.edu
; Course number/section:   CS271 Section 400
; Project Number: 05                Due Date:11/14/22
; Description: This program will have generate a list of numbers based on the constants within the program. The range of numbers are based on the constants as well. It will 
;	Introduce the program and instructions.
;	display the randomized list. 
;	find the median of the list. 
;	sort and display the list.
;	Display a farewell message.


INCLUDE Irvine32.inc

;Constants that can be adjusted
ARRAYSIZE = 200 ;Can be updated to generate x amount random of numbers
LO = 15 ;Lowest number of random numbers generated
HI = 50 ;Highest number of random numbers generated

.data


intro1			BYTE	"Generating, Sorting, and Counting Random Integers!                      Programmed by Michael Vuong", 0
intro2			BYTE	"This program generates ", 0 
intro3			BYTE	" random numbers between ", 0
additional		BYTE	" and ", 0
additional2		BYTE	".", 0
intro4			BYTE	"It will then display the original list, sorts the list into ascending order, displays the median value of the list, ", 10, 13
				BYTE	"displays the list sorted in ascending order, and finally displays the number of instances each number occurs", 10, 13
				BYTE	"of each generated value, starting with lowest.", 0
unsortedNums	BYTE	"Your unsorted random numbers:", 0
sortedNums		BYTE	"Your sorted random numbers:", 0
medianNum		BYTE	"The median value of the array: ", 0
countNum		BYTE	"Your list of instances of each generated number, starting with the smallest number.", 0
space			BYTE	" ", 0
someArray		DWORD	ARRAYSIZE dup(?)
counts			DWORD	ARRAYSIZE dup(?)
farewell		BYTE	"Til next time, and thanks for using my program!", 0
countsize		DWORD	?



.code
main PROC
	call	Randomize

	;Introduce and print instructions for the user.
	push	OFFSET intro1 
	push	OFFSET intro2 
	push	OFFSET intro3 
	push	OFFSET additional 
	push	OFFSET additional2 
	push	OFFSET intro4 
	call	introduction

	;Fill array with random numbers based on constants.
	push	OFFSET someArray
	call	fillArray

	;Display the unsorted array based on the size, description, and elements in the array.
	push	OFFSET ARRAYSIZE
	push	OFFSET unsortedNums
	push	OFFSET someArray
	call	displayArray

	;Sorts the array into ascending order.
	push	OFFSET someArray
	call	sortList

	;Displays the median value of the array.
	push	OFFSET medianNum
	push	OFFSET	someArray
	call	displayMedian

	;Displays the now sorted array based on the size, description, and elements in the array.
	push	OFFSET ARRAYSIZE
	push	OFFSET sortedNums
	push	OFFSET	someArray
	call	displayArray

	;Counts the number of occurences for each number in the array and puts it into a brand new array
	push	OFFSET	someArray
	push	OFFSET	counts
	call	countList

	;Displays the count array that was recently created.
	sub		eax, LO
	mov		countsize, eax
	xor		eax, eax
	push	countsize
	push	OFFSET	countNum
	push	OFFSET	counts
	call	displayArray

	;Displays a final farewell message
	push	OFFSET	farewell
	call	goodbye

	Invoke ExitProcess,0	; exit to operating system
main ENDP

; --------------------------------------------------------------------------------- 
; Name: introduction
;  
; Introduces the author and the program/instructions.
; 
; Preconditions: ARRAYSIZE, LO, and HI are adjusted based on what the user would like to see. Only positive integers
; 
; Postconditions: none. 
; 
; Receives:  
; [ebp+28] = Title of program and author string
; [ebp+24] = First part of concatenated string
; [ebp+20] = (1/2) middle part of concatenated string
; [ebp+16] = (2/2) middle part of concatenated string
; [ebp+12] = Last part of concatenated string
; [ebp+8]  = Rest of instruction string
; ARRAYSIZE, LO, and HI are global variables 
; 
; returns: None
; ---------------------------------------------------------------------------------
introduction PROC
	push	ebp
	mov		ebp, esp
	mov		edx, [ebp + 28]
	call	WriteString
	call	CrLf
	call	CrLf	
	mov		edx, [ebp + 24]
	call	WriteString
	mov		eax, ARRAYSIZE
	call	WriteDec
	mov		edx, [ebp + 20]
	call	WriteString
	mov		eax, LO
	call	WriteDec
	mov		edx, [ebp + 16]
	call	WriteString
	mov		eax, HI
	call	WriteDec
	mov		edx, [ebp + 12]
	call	WriteString
	call	CrLf
	mov		edx, [ebp + 8]
	call	WriteString
	call	CrLf
	call	CrLf
	pop		ebp
	ret		24
introduction ENDP
; --------------------------------------------------------------------------------- 
; Name: fillArray
;  
; Fills the array with an x amount of random numbers between LO and HI global constants. X is dependant on ARRAYSIZE global constant.
; 
; Preconditions: ARRAYSIZE, LO, and HI are adjusted based on what the user would like to see. Only positive integers.
; 
; Postconditions: none. 
; 
; Receives:  
; [ebp+8]  = Empty array with a size of ARRAYSIZE global constant.
; ARRAYSIZE, LO, and HI are global variables 
; 
; returns: someArray (filled)
; ---------------------------------------------------------------------------------
fillArray PROC	
	push	ebp
	mov		ebp, esp
	mov		esi, [ebp + 8]		;empty array to be filled
	mov		ecx, ARRAYSIZE
_generateNumber:
	mov		eax, HI
	sub		eax, LO
	inc		eax
	call	RandomRange
	add		eax, LO
	mov		[esi], eax
	add		esi, 4
	loop	_generateNumber
	pop		ebp
	ret		4


fillArray ENDP
; --------------------------------------------------------------------------------- 
; Name: displayArray
;  
; Displays a string for what is in the array (unsorted, sorted, counted) and the numbers within the array. Will ony display numbers based on the size parameter inputted
; 
; Preconditions: ARRAYSIZE, LO, and HI are adjusted based on what the user would like to see. Only positive integers.
; 
; Postconditions: none. 
; 
; Receives:  
; [ebp+16] = The amount of numbers to print within the array
; [ebp+12] = String for what the array contains (unsorted, sorted, or counted
; [ebp+8]  = Empty array with a size of ARRAYSIZE global constant.
; ARRAYSIZE, LO, and HI are global variables 
; 
; returns: None
; ---------------------------------------------------------------------------------
displayArray PROC				
	push	ebp
	mov		ebp, esp
	mov		edx, [ebp + 12]		
	call	WriteString
	call	CrLf
	mov		esi, [ebp + 8]		
	mov		ecx, [ebp + 16]		
	mov		ebx, 0
_displayNum:
	mov		eax, [esi]
	call	WriteDec
	mov		edx, OFFSET space
	call    WriteString
	add		esi, 4
	inc		ebx
	cmp		ebx, 20
	je		_newLine
	loop	_displayNum
	jmp		_end
_newLine:
	call	CrLf
	mov		ebx, 0
	loop	_displayNum
_end:
	call	CrLf
	call	CrLf
	pop		ebp
	ret		8
displayArray ENDP
; --------------------------------------------------------------------------------- 
; Name: sortList
;  
; Takes in an array parameter and sorts it in asvending order using a bubble sort method.
; 
; Preconditions: Sort ARRAYSIZE amount of elements. ARRAYSIZE must match the size of the array passed in
; 
; Postconditions: none. 
; 
; Receives:  
; [ebp+8]  = Array filled with values.
; ARRAYSIZE, LO, and HI are global variables 
; 
; returns: Array passed in but sorted in ascending order
; ---------------------------------------------------------------------------------
sortList PROC			
	push	ebp
	mov		ebp, esp
	mov		ecx, ARRAYSIZE
	dec		ecx
	mov		ebx, ecx
	mov		esi, [ebp + 8]		;The array to be sorted
_outside_loop:
_insideLoop:
	mov		eax, [esi]
	cmp		eax, [esi + 4]
	jl		_next
	push	esi
	add		esi, 4
	push	esi
	call	exchangeElements
_next:
	add		esi, 4
	loop _insideLoop
	mov		esi, [ebp + 8]
	dec		ebx
	cmp		ebx, 0
	je		_done
	mov		ecx, ebx
	jmp		_outside_loop
_done:
	pop		ebp
	ret		4
sortList ENDP
; --------------------------------------------------------------------------------- 
; Name: exchangeElements
;  
; Takes in an two spots in the array as parameters and flips them.
; 
; Preconditions: Method is only used within the sortList method. 
; 
; Postconditions: none. 
; 
; Receives:  
; [ebp+12] = Second value in array to be switched (someArray[j])
; [ebp+8]  = First value in array to be switched (someArray[i])
; ARRAYSIZE, LO, and HI are global variables 
; 
; returns: Swapped locations of someArray[i] and someArray[j]
; ---------------------------------------------------------------------------------
exchangeElements PROC
	push	ebp
	mov		ebp, esp
	pushad
	mov		eax, [ebp + 8]
	mov		ebx, [eax]
	mov		ecx, [ebp + 12]
	mov		edx, [ecx]
	mov		DWORD PTR [eax], edx
	mov		DWORD PTR [ecx], ebx
	popad
	sub		esi, 4
	pop		ebp
	ret		8

exchangeElements ENDP	 
; --------------------------------------------------------------------------------- 
; Name: displayMedian
;  
; Finds the halfway point within the array to locate and print the median value.
; 
; Preconditions: Array only has positive whole numbers and is SORTED
; 
; Postconditions: none. 
; 
; Receives:  
; [ebp+12] = String describing median number
; [ebp+8]  = Array with sorted numbers
; ARRAYSIZE, LO, and HI are global variables 
; 
; returns: None
; ---------------------------------------------------------------------------------
displayMedian PROC			
	push	ebp
	mov		ebp, esp
	mov		edx, [ebp + 12]
	call	WriteString
	mov		esi, [ebp  + 8]
	mov		edx, 0
	mov		eax, ARRAYSIZE
	mov		ecx, 2
	div		ecx
	cmp		edx, 0
	jne		_oddNum				;else even
	mov		ebx, 4
	mul		ebx
	add		esi, eax
	mov		eax, [esi - 4]
	add		eax, [esi]
	mov		edx, 0
	mov		ebx, 2
	div		ebx
	call	WriteDec
	call	CrLf
	jmp		_end
_oddNum:						;If the total number is odd
	mov		ebx, 4
	mul		ebx
	add		esi, eax
	mov		eax, [esi]
	call	WriteDec
	call	CrLf
_end:
	call	CrLf
	pop ebp
	ret 8


displayMedian ENDP
; --------------------------------------------------------------------------------- 
; Name: countList
;  
; Counts the number of times a number appears starting from LO and up to HI. A new array will be filled with those values
; 
; Preconditions: Array only has positive whole numbers
; 
; Postconditions: none. 
; 
; Receives:  
; [ebp+12] = The sorted array
; [ebp+8]  = Empty array to be filled
; ARRAYSIZE, LO, and HI are global variables 
; 
; returns: An array with counted values 
; ---------------------------------------------------------------------------------
countList PROC					
	push	ebp
	mov		ebp, esp
	mov		esi, [ebp + 12]		;sorted someArray list
	mov		edi, [ebp + 8]		;empty counts list
	mov		ebx, HI
	sub		ebx, LO
	mov		ecx, ebx
	inc		ecx
	xor		ebx, ebx
	mov		eax, LO
_look:						;checks to see if the number is the same as before
	cmp		eax, [esi]
	je		_countit
	inc		eax
	mov		[edi], ebx
	xor		ebx, ebx
	add		edi, 4
	loop	_look
	jmp		_end
_countit:					;add to the counter for repeated numbers
	inc		ebx
	add		esi, 4
	jmp		_look
_end:
	pop		ebp
	ret		8
countList ENDP
; --------------------------------------------------------------------------------- 
; Name: goodbye
;  
; prints out a goodbye message.
; 
; Preconditions: none.
; 
; Postconditions: none. 
; 
; Receives:  
; [ebp+8]  = String to print out goodbye message
; 
; returns: None
; ---------------------------------------------------------------------------------
goodbye	PROC					;This procedure will print out a goodbye message, taking in a goodbye parameter and printing it.
	push	ebp
	mov		ebp, esp
	mov		edx, [ebp + 8]
	call	WriteString
	pop		ebp
	ret		4
goodbye ENDP
END main
