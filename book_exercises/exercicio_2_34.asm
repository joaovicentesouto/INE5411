#  int f(int a, int b, int c, int d) {
#       return func(func(a,b), c+d);
#  }

f:
  # Prólogo: preserva contexto
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  # Corpo
  add $s0, $a2, $a3     # Salva c+d
  jal func              # func(a,b)
  add $a0, $v0, $zero   # func( ->func(a,b), c+d)
  add $a1, $s0, $zero   # func( func(a,b), ->c+d)
  jal func              # func( func(a,b), c+d)

  # Epílogo: restaura contexto
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra
