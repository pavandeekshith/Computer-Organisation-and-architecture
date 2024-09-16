.data
    numbers:      .word 3, 6, 8 , 5, 7, 9, 11, 12, 14, 17, 20  # Sorted list of 10 numbers
    X:            .word 7                              # Number to search for (example)
    output:       .word 0                             # Output location
    not_found_msg: .asciiz "Number not found.\n"      # Message for number not found
    found_msg:     .asciiz "Number found.\n"         # Message for number found
    iterations_msg: .asciiz "Iterations: "           # Message for iterations
    index_msg:     .asciiz "Index: "                 # Message for index
.text
    .globl main

main:
    lw $t0, X
    li $t1, 0
    li $t2, 10
    li $t3, 0

search_loop:
    beq $t1, $t2, not_found
    lw $t4, numbers($t1)
    addi $t3, $t3, 1
    beq $t0, $t4, found
    addi $t1, $t1, 4
    j search_loop

not_found:
    li $t5, 2
    sw $t5, output
    li $v0, 4
    la $a0, not_found_msg
    syscall
    j exit_program

found:
    li $t5, 1
    sw $t5, output
    sw $t3, output + 4
    srl $t6, $t1, 2
    sw $t6, output + 8
    li $v0, 4
    la $a0, found_msg
    syscall
    li $v0, 4
    la $a0, iterations_msg
    syscall
    li $v0, 1
    lw $a0, output + 4
    syscall
    li $v0, 4
    la $a0, index_msg
    syscall
    li $v0, 1
    lw $a0, output + 8
    syscall

exit_program:
    li $v0, 10
    syscall
