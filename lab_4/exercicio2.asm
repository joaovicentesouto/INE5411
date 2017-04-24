.data
# arranjo inicializado com elementos não nulos
_array: .word 1,2,3,4,5,6,7,8,9,2,3
_size: .word 11 #Tamanho do arranjo
.text
.globl main

main:
jal clear2 #Salto para o endereço do procedimento
li $v0, 10 #Exit syscall
syscall

clear2:
# inicialização dos parâmetros
la $a0,_array
lw $a1,_size
# prólogo #Deve conter uma única instrução!
#Inicialização do ponteiro
add $t0, $zero, $a0
# corpo do laço
Loop2:
sll $t1, $a1, 2
add $t2, $a0, $t1
slt $t3,$t0,$t2
beq $t3,$zero,Exit #Se p>=&array[size] desvia p/ Exit
sw $zero, 0($t0)
addi $t0, $t0, 4
j Loop2
# epílogo
Exit:
jr $ra #Retorna ao programa principal