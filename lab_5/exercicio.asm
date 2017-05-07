.data
_v: .word ....
_n: .word ....

.text
.globl main

main:
  la      $a0,_v
  lw      $a1,_n
  jal     sort
  li      $v0,10      #Exit syscall
  syscall

# procedure sort
sort:
  # preserva��o de registradores armazenando seus conte�dos na pilha
  addi    $sp,  $sp,    -12
  sw      $ra,  8($sp)
  sw      $s1,  4($sp)
  sw      $s0,  0($sp)

  move    $s0,  $zero   # inicializa��o de i
  # in�cio do corpo do la�o externo
for1tst:
  nop #MARCA 1
  slt     $t0,  $s0,    $a1 # for1st
  beq     $t0,  $zero,  exit1
  addi    $s1,  $s0,    -1
  # inicio do corpo do la�o interno
for2tst:
  slti    $t0,  $s1,    0  # for2st
  bne     $t0,  $zero,  exit2
  sll     $t1,  $s1,    2
  add     $t2,  $a0,    $t1
  lw      $t3,  0($t2)
  lw      $t4,  4($t2)
  slt     $t0,  $t4,    $t3
  beq     $t0,  $zero,  exit2

  nop # MARCA 2
  jal     swap 	# chamada de swap
  addi    $s1,  $s1,    -1
  j       for2tst
  # fim do corpo do la�o interno
exit2:
  addi    $s0,  $s0,    1
  j       for1tst
  # fim do corpo do la�o externo
exit1:
  # restaura��o de conte�dos de registradores preservados na pilha
  lw      $s0,  0($sp)
  lw      $s1,  4($sp)
  lw      $ra,  8($sp)
  addi    $sp,  $sp,    12
  # retorno ao procedimento chamador
  jr      $ra

 # codifica��o da procedure swap
swap:
