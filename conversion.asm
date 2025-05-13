# conversion.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.text
conv:
    # TODO: Write your function code here

	li $v0, 0
	li $t0, 0
	# maybe n is always 7?
	#li $a2, 7
	li $t2, 2

	# from the main code, a1 seems to be both y and n; not the same for c++	
	# autograder failing so trying to change this
	#move $a2, $a1
	j loop
loop:
	bge $t0, $a2, return
	move $t1, $a1
	sll $t1, $t1, 2
	sub $v0, $v0, $a0
	add $v0, $v0, $t1
	
	blt $a0, $t2, noty
	sub $a1, $a1, $a0
noty:
	addi $a0, $a0, 1
	addi $t0, $t0, 1
	j loop

return:
	#move $a0, $v0
	#li $v0, 1
	#syscall
	jr $ra	

main:  # DO NOT MODIFY THE MAIN SECTION
    li $a0, 5
    li $a1, 7

    jal conv

    move $a0, $v0
    li $v0, 1
    syscall

exit:
	# TODO: Write code to properly exit a SPIM simulation
	li $v0, 10
	syscall
