  .section .data

list_1:
  .long 6, 12, 19, 44, 33, 22, 66, 214, 222, 0

list_2:
  .long 222, 223, 44, 32, 76, 92, 48, 0

list_3:
  .long 200, 100, 253, 78, 42, 0

  .section .text

  .globl _start

_start:

  pushl list_1                    # push the argument
  call find_maximum

  addl $4, %esp
  pushl list_2
  call find_maximum

  addl $4, %esp
  pushl list_3
  call find_maximum

  movl %eax, %ebx

  movl $1, %eax
  int $0x80

  .type find_maximum, @function

find_maximum:

  pushl %ebp
  movl %esp, %ebp
  subl $4, %esp

  movl $0, %edi                   # set current index to 0
  movl 8(%ebp), %ebx
  movl %ebx(,%edi,4), %eax     # first number automatically the highest

  loop_start:

    cmpl $0, 8(%ebp)(,%edi,4)    # if current number = 0, the list is finished
    je exit_maximum

    incl %edi                     # increment %edi by 1 to check next in list

    cmpl 8(%ebp)(,%edi,4), %eax   # compare, if eax is greater than current
    jge loop_start                # then restart the loop

    movl 8(%ebp)(,%edi,4), %eax   # otherwise, current is higher than eax
    jmp loop_start                # and therefore becomes new highest. re-loop

  exit_maximum:

    movl %ebp, %esp
    popl %ebp
    ret
