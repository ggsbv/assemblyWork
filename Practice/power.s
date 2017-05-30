.section .data

.section .text

  .globl _start
_start:
  pushl $0        # push second parameter
  pushl $2        # push first parameter
  call power
  addl $8, %esp   #delete the parameters in stack
  pushl %eax      #save result of first power

  pushl $0        #push second parameter
  pushl $5        #push first parameter
  call power
  addl $8, %esp
  popl %ebx
  addl %eax, %ebx

  movl $1, %eax
  int $0x80

.type power, @function
power:
  pushl %ebp            # push base pointer to top of stack
  movl %esp, %ebp
  subl $4, %esp         # create space for local variable
  movl 8(%ebp), %ebx    # %ebx contains base
  movl 12(%ebp), %ecx   # %ecx contains power
  movl %ebx, -4(%ebp)   # local var contains total

loop_start:
  cmpl $0, %ecx
  je power_one
  cmpl $1, %ecx         # if p2 = 1, exit loop
  je power_exit
  movl -4(%ebp), %eax
  imull %ebx, %eax      # %eax contains result
  movl %eax, -4(%ebp)   # store total
  decl %ecx             # decrease %ecx by 1
  jmp loop_start

power_one:
  movl $1, -4(%ebp)
  jmp power_exit

power_exit:
  movl -4(%ebp), %eax
  movl %ebp, %esp
  popl %ebp
  ret
