.data
#_save: .word 6,6,2,7,6,6,3,0
_save: .word 99999,8,6,6,6,6,6,6,6,6   # Força tentativa de erro mas é prevenido
_k: .word 6
_error: .asciiz "Index Out of Bound Exception"

.text.globl mainmain: # inicialização    la $s6, _sabe          # Base de save
    lw $s5, _k             # Carrega k
    add $s3, $zero, $zero  # i = 0
    lw $t2, 4($s6)         # Carrega tamanho

Loop: # verificacao de limites do arranjo    sltu $t0, $s3, $t2
    beq $t0, $zero, IndexOutOfBounds:
    # corpo do laço
    sll $t1,$s3,2
    add $t1, $t1, $s6
    lw $t0, 8($t1)
    bne $t0, $s5, Exit
    addi $s3, $s3, 1
    j Loop

Exit: # rotinas para imprimir inteiro      # ou mensagem de erro no console   addi $v0,$zero, 1   add $a0,$zero, $s3   syscall   j End

IndexOutOfBounds:   addi $v0,$zero, 4   la $a0,_error   syscallEnd:
