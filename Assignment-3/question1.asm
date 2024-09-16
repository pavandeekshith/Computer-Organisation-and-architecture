.data
num1:   .word 0x1634   # First 16-bit number (5684)
num2:   .word 0x0500   # Second 16-bit number (1280)
result: .word 0       # To store the subtraction result (5684 - 1280 = 440)
msg:    .asciiz "Result: " # Message to print before the result
.text
.globl main

main:
    lw $t0, num1
    lw $t1, num2

    not $t1, $t1
    addi $t1, $t1, 1

    add $t2, $t0, $t1

    sw $t2, result


# Printing the result:
    li $v0, 4
    la $a0, msg
    syscall

    li $v0, 1
    lw $a0, result
    syscall

    li $v0, 10
    syscall
