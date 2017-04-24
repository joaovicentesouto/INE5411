.data
# Seção 1: variáveis f, g, h, i, j
# armazenadas em memória (inicialização)
_f: .word 7
_g: .word 12
_h: .word 1
_i: .word 13
_j: .word 6
# Seção 2: jump address table
jat:
.word L0
.word L1
.word L2
.word L3
.word L4
.word default

.text
.globl main
main:
# Seção 3: registradores recebem valores
# inicializados (exceto variável k)
lw $s0,_f
lw $s1,_g
lw $s2,_h
lw $s3,_i
lw $s4,_j

# carrega em $t4 o endereço-base de jat:
la $t4,jat

# Seção 4: testa se k no intervalo [0,4],
# caso contrário default
sltiu $t0,$s5,5
beq $t0,$zero,default

# Seção 5: calcula o endereço de jat[k]
sll $t1,$s5,2
add $t1,$t1,$t4
lw $t1,0($t1)

# Seção 6: desvia para o endereço de jat[k]
jr $t1

# Seção 7: codifica as alternativas de execução
# f = $s0
# g = $s1
# h = $s2
# i = $s3
# j = $s4
# k = $s5
L0:
add $s0,$s3,$s4 # f = i + j //=19
j Exit
# expressão definida no relatorio;

L1:
sub $s0,$s1,$s2 # f = g - h
j Exit

L2:
add $t0,$s1,$s2 # t0 = g + h
add $s0,$t0,$s5 # f = (g + h) + k
j Exit

L3:
sub $s0,$s3,$s2 # f = i - h
j Exit

L4:
sub $s0,$s4,$s3 # f = j - i
j Exit

default:
sub $t0,$s3,$s4 # t0 = i - j
addi $s0,$t0,2  # f = (i - j) + 2
j Exit

Exit: