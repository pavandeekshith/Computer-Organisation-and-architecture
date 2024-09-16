.data
    string:    .asciiz "Hello World!"
    char:      .byte 'o'
    notfound:  .asciiz "Character not found.\n"
    found:     .asciiz "Character found at index: "
    newline:   .asciiz "\n"

.text
    .globl main

main:
    la $t0, string
    lb $t1, char
    li $t2, 0

search_loop:
    lb $t3, 0($t0)
    beq $t3, $zero, not_found
    beq $t3, $t1, found_char
    addi $t0, $t0, 1
    addi $t2, $t2, 1
    j search_loop

not_found:
    li $v0, 4
    la $a0, notfound
    syscall
    j exit_program

found_char:
    li $v0, 4
    la $a0, found
    syscall
    
    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, newline
    syscall

exit_program:
    li $v0, 10
    syscall