.data
number1:   .word 8  # First number
number2:   .word 14  # Second number
gcd:       .word 0       
lcm_result: .word 0       
msg:       .asciiz "The LCM is: " 

.text
.globl main

main:
    lw $t0, number1
    lw $t1, number2
    
    move $t2, $t0
    move $t3, $t1
    
gcd_loop:
    beq $t1, $zero, done_gcd
    div $t0, $t1
    mfhi $t4
    move $t0, $t1
    move $t1, $t4
    j gcd_loop

done_gcd:
    mul $t5, $t2, $t3
    div $t5, $t0
    mflo $t6
    sw $t6, lcm_result

# Print the message
    li $v0, 4
    la $a0, msg
    syscall

    li $v0, 1
    lw $a0, lcm_result
    syscall

    li $v0, 10
    syscall
