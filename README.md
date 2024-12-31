# ARM Assembly Array Operations

## Overview
This project is an ARM assembly program that performs operations on arrays. It demonstrates key ARM assembly concepts, such as:
- Array initialization and manipulation.
- Auto-indexing for efficient array traversal.
- Input handling, calculations, and printing routines.
- Use of push/pop routines for managing registers.

The program takes user input, performs calculations on arrays, and displays the results. It emphasizes proper structuring, documentation, and ARM assembly techniques.

---

## Features

### 1. Array Initialization
- **Array 1 (A1):** Pre-initialized with predefined values in the data section.
- **Array 2 (A2):** Populated based on user input.
- **Array 3 (A3):** Populated with the result of element-wise multiplication of A1 and A2.

### 2. Input Validation
- Accepts positive integers as input for Array 2 (A2).
- Uses a loop to populate A2, ensuring valid data handling.

### 3. Arithmetic Operations
- Computes each element of A3 as `A3[i] = A1[i] * A2[i]` using ARM's `mul` instruction.

### 4. Output
- Prints all three arrays (A1, A2, A3) with clear labels.
- Displays elements in a formatted, user-friendly layout.

### 5. Subroutine for Printing
- Implements a reusable subroutine to display arrays.
- Utilizes stack operations (`push` and `pop`) to preserve register states.

---

## Program Structure

### 1. Welcome Message
- Displays a welcome prompt to the user.
- Introduces the program functionality.

### 2. Array Initialization
- Sets up registers for array operations.
- Prepares arrays A1, A2, and A3 for subsequent operations.

### 3. Input Loop
- Prompts the user for positive integers to populate Array 2 (A2).
- Uses auto-indexing to store user input directly into A2.

### 4. Calculation Loop
- Computes each element of Array 3 (A3) as `A3[i] = A1[i] * A2[i]`.
- Utilizes ARM's multiplication instruction (`mul`).

### 5. Output Routine
- Prints the contents of Arrays A1, A2, and A3.
- Uses a dedicated subroutine (`printarray`) for array traversal and display.

### 6. Subroutine: `printarray`
- Prints the elements of an array.
- Loops through the array using auto-indexing and stack operations (`push`/`pop`) to preserve register states.

### 7. Exit Routine
- Safely exits the program using system call (`svc 0`).

---

## Example Output
```plaintext
Welcome to the array program.
Input positive integers.

Array A (initialized array):
[ 10 ][ -20 ][ 0 ][ 40 ][ -50 ][ 0 ][ 70 ][ -80 ][ 0 ][ 100 ]

Array B (user input array):
[ 1 ][ 2 ][ 3 ][ 4 ][ 5 ][ 6 ][ 7 ][ 8 ][ 9 ][ 10 ]

Array C (A[i] * B[i]):
[ 10 ][ -40 ][ 0 ][ 160 ][ -250 ][ 0 ][ 490 ][ -640 ][ 0 ][ 1000 ]
