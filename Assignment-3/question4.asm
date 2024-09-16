.data
    num1:    .word 4     # First number to multiply
    num2:    .word 12     # Second number to multiply
    result:  .word 0
    newline: .asciiz "\n"

.text
    .globl main

main:
    lw $t0, num1
    lw $t1, num2
    li $t2, 0
    li $t3, 0

loop:
    beq $t1, $t3, end
    add $t2, $t2, $t0
    addi $t3, $t3, 1
    j loop

end:
    sw $t2, result
    
    # Print the result
    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 10
    syscall
