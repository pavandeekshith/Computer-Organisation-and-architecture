.data
numbers: .word 8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120
average: .word 0 
msg:    .asciiz "The average is: " 

.text
.globl main

main:
    li $t0, 0         
    li $t1, 15        
    li $t2, 0         
    la $t3, numbers   

loop:
    beq $t2, $t1, done  
    lw $t4, 0($t3)      
    add $t0, $t0, $t4   
    addi $t3, $t3, 4    
    addi $t2, $t2, 1    
    j loop              

done:
    li $t5, 15          
    div $t0, $t5        
    mflo $t6            
    sw $t6, average     

# Print the message
    li $v0, 4          
    la $a0, msg        
    syscall            

    li $v0, 1          
    lw $a0, average    
    syscall           

    li $v0, 10         
    syscall
