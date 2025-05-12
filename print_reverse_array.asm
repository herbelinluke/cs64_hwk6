# print_array.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.data
	array: .word 1 2 3 4 5 6 7 8 9 10
	cout:  .asciiz "The contents of the arrary are:\n"
	newline:  .asciiz "\n"


.text
printArr:
    # TODO: Write your function code here
	addi $a1, $a1, -1
	move $t1, $a1
	sll $t1, $t1, 2

	move $t0, $a0
	addu $t0, $t0, $t1
	li $t2, 4
	
loop:
	blt $a1, $zero, return
	li $v0, 1
	lw $a0, 0($t0)
	syscall
	li $v0, 4
	la $a0, newline
	syscall
	subu $t0, $t0, $t2
	addi $a1, $a1, -1
	j loop

return:
	jr $ra

main:  # DO NOT MODIFY THE MAIN SECTION
	li $v0, 4
	la $a0, cout
	syscall

	la $a0, array
	li $a1, 10

	jal printArr

exit:
	# TODO: Write code to properly exit a SPIM simulation
	li $v0, 10
	syscall

