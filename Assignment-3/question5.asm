.data
    list:       .word 1, 3, 5, 7, 9, 11, 13, 15, 17, 19   # Sorted list of 10 numbers
    X:          .word 7                                   # Number to search (can be changed)
    output:     .word 0                                   # Output result (1 for found, 2 for not found)
    iterations: .word 0                                   # Number of iterations (if found)
    index:      .word 0                                   # Index of the element (if found)
    found_msg:  .asciiz "Number found\n"
    notfound_msg: .asciiz "Number not found\n"
    iterations_msg: .asciiz "Iterations: "
    index_msg:   .asciiz "Index: "
    newline:    .asciiz "\n"

.text
    .globl main

main:
    # Load the number to search from memory location X
    la $t0, X                # Load address of X into $t0
    lw $t1, 0($t0)           # Load the value at X into $t1 (number to search)

    # Initialize list pointer and search parameters
    la $t2, list             # Load address of the list into $t2
    li $t3, 0                # Initialize index to 0
    li $t4, 10               # Set the limit to 10 (length of the list)
    li $t5, 0                # Initialize iteration counter to 0

search_loop:
    beq $t3, $t4, not_found  # If index == 10 (end of list), jump to not_found
    
    # Load the current element from the list
    lw $t6, 0($t2)           # Load the current element into $t6
    
    # Check if the current element matches the number
    beq $t1, $t6, found      # If the number is found, jump to found
    
    # Increment the address to the next element in the list
    addi $t2, $t2, 4         # Move to the next element in the list
    addi $t3, $t3, 1         # Increment index
    addi $t5, $t5, 1         # Increment iteration counter
    
    # Repeat the loop
    j search_loop

# If the number is not found
not_found:
    la $t7, output           # Load the address of output
    li $t8, 2                # Load 2 (not found) into $t8
    sw $t8, 0($t7)           # Store 2 in output
    
    # Print "Number not found"
    li $v0, 4                # Syscall to print a string
    la $a0, notfound_msg      # Load address of "Number not found" message
    syscall                  # Print message
    
    # Exit program
    j exit_program

# If the number is found
found:
    la $t7, output           # Load the address of output
    li $t8, 1                # Load 1 (found) into $t8
    sw $t8, 0($t7)           # Store 1 in output
    
    # Store the number of iterations
    la $t7, iterations       # Load the address of iterations
    sw $t5, 0($t7)           # Store the iteration count

    # Store the index of the found element
    la $t7, index            # Load the address of index
    sw $t3, 0($t7)           # Store the index
    
    # Print "Number found"
    li $v0, 4                # Syscall to print a string
    la $a0, found_msg         # Load address of "Number found" message
    syscall                  # Print message
    
    # Print "Iterations: "
    li $v0, 4                # Syscall to print a string
    la $a0, iterations_msg    # Load address of "Iterations: " message
    syscall                  # Print message
    
    # Print the iteration count
    li $v0, 1                # Syscall to print an integer
    lw $a0, iterations        # Load the iteration count
    syscall                  # Print the iteration count
    
    # Print newline
    li $v0, 4                # Syscall to print a string
    la $a0, newline           # Load the newline character
    syscall                  # Print newline
    
    # Print "Index: "
    li $v0, 4                # Syscall to print a string
    la $a0, index_msg         # Load address of "Index: " message
    syscall                  # Print message
    
    # Print the index
    li $v0, 1                # Syscall to print an integer
    lw $a0, index             # Load the index
    syscall                  # Print the index

# Exit program
exit_program:
    li $v0, 10               # Exit syscall
    syscall
