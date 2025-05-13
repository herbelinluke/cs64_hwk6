# swap_case.asm program
# For CMPSC 64
#
# Data Area
.data
    buffer: .space 100
    input_prompt:   .asciiz "Enter string:\n"
    output_prompt:   .asciiz "Output:\n"
    convention: .asciiz "Convention Check\n"
    newline:    .asciiz "\n"

.text

#
# DO NOT MODIFY THE MAIN PROGRAM 
#       OR ANY OF THE CODE BELOW, WITH 1 EXCEPTION!!!
# YOU SHOULD ONLY MODIFY THE SwapCase FUNCTION 
#       AT THE BOTTOM OF THIS CODE
#
main:
    la $a0, input_prompt    # prompt user for string input
    li $v0, 4
    syscall

    li $v0, 8       # take in input
    la $a0, buffer
    li $a1, 100
    syscall
    move $s0, $a0   # save string to s0

    ori $s1, $0, 0
    ori $s2, $0, 0
    ori $s3, $0, 0
    ori $s4, $0, 0
    ori $s5, $0, 0
    ori $s6, $0, 0
    ori $s7, $0, 0

    move $a0, $s0
    jal SwapCase

    add $s1, $s1, $s2
    add $s1, $s1, $s3
    add $s1, $s1, $s4
    add $s1, $s1, $s5
    add $s1, $s1, $s6
    add $s1, $s1, $s7
    add $s0, $s0, $s1

    la $a0, output_prompt    # give Output prompt
    li $v0, 4
    syscall

    move $a0, $s0
    jal DispString

    j Exit

DispString:
    addi $a0, $a0, 0
    li $v0, 4
    syscall
    jr $ra

ConventionCheck:
    addi    $t0, $0, -1
    addi    $t1, $0, -1
    addi    $t2, $0, -1
    addi    $t3, $0, -1
    addi    $t4, $0, -1
    addi    $t5, $0, -1
    addi    $t6, $0, -1
    addi    $t7, $0, -1
    ori     $v0, $0, 4
    la      $a0, convention
    syscall
    addi    $v0, $zero, -1
    addi    $v1, $zero, -1
    addi    $a0, $zero, -1
    addi    $a1, $zero, -1
    addi    $a2, $zero, -1
    addi    $a3, $zero, -1
    addi    $k0, $zero, -1
    addi    $k1, $zero, -1
    jr      $ra
    
Exit:
    ori     $v0, $0, 10
    syscall

# COPYFROMHERE - DO NOT REMOVE THIS LINE

# YOU CAN ONLY MODIFY THIS FILE FROM THIS POINT ONWARDS:
SwapCase:
    #TODO: write your code here, $a0 stores the address of the string
	addi $sp, $sp, -20
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)

	li $s0, 65
	li $s1, 90
	li $s2, 97
	li $s3, 122	
	move $s4, $a0
loop:
	lb $t5, 0($s4)
	bgt $t5, $s3, next
	blt $t5, $s0, next
	ble $t5, $s1, upper
	bge $t5, $s2, lower
	j next
upper:
	li $v0, 11
	move $a0, $t5
	syscall
	la $a0, newline 
	li $v0, 4
	syscall
	li $v0, 11
	addiu $a0, $t5, 32
	syscall
	sb $a0, 0($s4)
	la $a0, newline 
	li $v0, 4
	syscall

	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal ConventionCheck
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	j next

lower:
	li $v0, 11
	move $a0, $t5
	syscall
	la $a0, newline 
	li $v0, 4
	syscall
	li $v0, 11
	addiu $a0, $t5, -32
	syscall
	sb $a0, 0($s4)
	la $a0, newline 
	li $v0, 4
	syscall

	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal ConventionCheck
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	j next
next:
	addiu $s4, $s4, 1
	lb $t5, 0($s4)
	beq $t5, $zero, endSC
 	j loop 

endSC: 
	lw $s4, 16($sp)
	lw $s3, 12($sp)
	lw $s2, 8($sp)
	lw $s1, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 20

    # Do not remove the "jr $ra" line below!!!
    # It should be the last line in your function code!
    jr $ra
