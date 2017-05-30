.section .data

data_file:
  .long 3,67,34,222,45,75,54,34,44,33,22,11,66,0

.section .text

  .globl _start
_start:

  movl $0, %edi
  movl data_file(,%edi,4), %eax
  movl %eax, %ebx

loop_start:
  cmpl %eax, $0
  je loop_exit

  incl %edi
  movl data_file(,%edi,4), %eax
  cmpl %ebx, %eax
  jle loop_start

  movl %eax, %ebx
  jmp loop_start

loop_exit:
  movl $1, %eax
  int $0x80
