.data
_v: .word 29,28,27,26,25,24,23,22,21,-1
_n: .word 10

.text
.globl main

main:
  la	$a0, _v
  lw $a1, _n
  jal	sort
  li	$v0, 10	#Exit syscall
  syscall

# procedure bubble-sort
sort:
    # salvamento do contexto
    addi	$sp, $sp, -20
    sw	$ra, 8($sp)
    sw	$s1, 4($sp)
    sw	$s0, 0($sp)
    sw	$s2, 12($sp)
    sw	$s3, 16($fp)

    move $s2, $a0	# s2 = V[]
    move $s3, $a1	# s3 = n
    move	$s0, $zero	# i = 0

  # primeiro loop
  for1tst:
    nop #MARCA 1
    slt	$t0, $s0, $s3	# i < n
    beq	$t0, $zero, exit1
    addi	$s1, $s0, -1	# j = i-1

  # segundo looṕ
  for2tst:
    slti	$t0, $s1, 0	# j < 0
    bne	$t0, $zero, exit2
    sll	$t1, $s1, 2	# j * 4
    add	$t2, $s2, $t1	# j + V[]
    lw	$t3, 0($t2)	# V[j]
    lw	$t4, 4($t2)	# V[j+1]
    slt	$t0, $t4, $t3	# V[j+1] < V[j]
    beq	$t0, $zero, exit2

    move	$a1, $s1	# a1 = j
    move	$a0, $s2
    nop # MARCA 2
    jal	swap # swap
    addi	$s1, $s1, -1	# j--
    j	for2tst

  # vai embora
  exit2:
    addi	$s0, $s0, 1	# i++
    j	for1tst	# volta pro loop do i

  exit1:
    # restauração de contexto
    lw	$s0, 0($sp)
    lw	$s1, 4($sp)
    lw	$ra, 8($sp)
    lw	$s2, 12($sp)
    lw	$s3, 16($sp)
    addi	$sp, $sp, 20
    # returns
    jr	$ra

# swap
swap:
  # calculo de indices
  sll	$t0, $a1, 2	# k * 4
  add	$a0, $t0, $a0	# k + V[]
  # realiza a troca
  lw	$t1, 0($a0)
  lw	$t2, 4($a0)
  sw	$t2, 0($a0)
  sw	$t1, 4($a0)
  # retorno ao programa principal
  jr	$ra
