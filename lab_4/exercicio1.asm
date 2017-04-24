.data
# arranjo inicializado com elementos não nulos
_array: .word 1,2,3,4,5,6,7,8,9,2,3
_size: .word 11 # tamanho do arranjo
.text
.globl main
main:
jal clear1 #Salto para o endereço do procedimento
li $v0, 10 #Exit syscall
syscall

clear1:
# inicialização dos parâmetros
la $a0,_array
lw $a1,_size
# prólogo #Deve conter uma única instrução!

#Inicialização do índice
add $t0, $zero, $zero
# corpo do laço
Loop1:
slt $t3,$t0,$a1
beq $t3,$zero,Exit #Se (i>=size) desvia para Exit
sll $t2, $t0, 2
add $t2, $t2, $a0
sw $zero, 0($t2)
addi $t0, $t0, 1
j Loop1
# epílogo
Exit:
jr $ra #Retorna ao programa principal