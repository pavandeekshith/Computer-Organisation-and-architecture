.data
    string:    .asciiz "Hello World!"     # The string to search
    char:      .byte 'o'                  # Character to search for
    notfound:  .asciiz "Character not found.\n"
    found:     .asciiz "Character found at index: "
    newline:   .asciiz "\n"

.text
    .globl main

main:
    # Initialize registers
    la $t0, string            # Load address of the string into $t0
    lb $t1, char              # Load the character to find into $t1
    li $t2, 0                 # Initialize index/counter in $t2

search_loop:
    lb $t3, 0($t0)            # Load the current character from string
    beq $t3, $zero, not_found # If end of string (null terminator), jump to not_found
    beq $t3, $t1, found_char  # If the current character matches, jump to found_char
    addi $t0, $t0, 1          # Move to the next character in the string
    addi $t2, $t2, 1          # Increment the index
    j search_loop             # Repeat the loop

not_found:
    # Print "Character not found."
    li $v0, 4                 # Syscall to print a string
    la $a0, notfound          # Load address of notfound message
    syscall                   # Print the message
    j exit_program            # Exit the program

found_char:
    # Print "Character found at index: 
    li $v0, 4                 # Syscall to print a string
    la $a0, found             # Load address of found message
    syscall                   # Print the message
    
    # Print the index (stored in $t2)
    li $v0, 1                 # Syscall to print an integer
    move $a0, $t2             # Move the index into $a0
    syscall                   # Print the index

    # Print newline
    li $v0, 4                 # Syscall to print a string
    la $a0, newline           # Load the newline address
    syscall                   # Print newline

exit_program:
    # Exit the program
    li $v0, 10                # Exit syscall
    syscall
