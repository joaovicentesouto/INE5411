fib:
  addi $sp, $sp, -12
  sw $ra, 8($sp)
  sw $s1, 4($sp)
  sw $a0, 0($sp)

# if n=0
  bne $s0, $zero, ELSE_1 # n!=0 pula
  addi $sp, $sp, 12      # restaura contexto
  add $v0, $zero, $zero  # return 0
  jr $ra                 # retorna

# else if n=1
ELSE_1:
  sltiu $t0, $s0, 2      # n=1
  beq $t0, $zero, ELSE_2 # false pula
  addi $sp, $sp, 12      # restaura contexto
  addi $v0, $zero, 1     # return 1
  jr $ra                 # retorna

# else
ELSE_2:
  addi $a0, $a0, -1      # arg n-1
  jal fib                # fib(n-1)
  add $s1, $v0, $zero    # guarda retorno de fib(n-1)
  addi $a0, $a0, -1      # arg n-2
  jal fib                # fib(n-2)
  add $v0, $s1, $v0      # return fib(n-1) + fib(n-2)
                         #
  lw $a0, 0($sp)         # restaurar  contexto
  lw $s1, 4($sp)
  lw $ra, 8($sp)
  addi $sp, $sp, 12
  jr $ra                 # retorna
