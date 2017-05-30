.section .data

.section .text

  .globl _start
_start:

  pushl $4            # push the first argument
  call square

  addl $4, %esp        # delete the arguments off stack

  movl %eax, %ebx     # system requires result to be stored in ebx,
                      # and the system call to be stored in eax



  movl $1, %eax
  int $0x80

.type square, @function

square:

  pushl %ebp        # save old base pointer
  movl %esp, %ebp   # make base pointer the current stack pointer
  subl $4, %esp      # make space for local variable

  movl 8(%ebp), %eax # ebx contains number to be squared
  imull 8(%ebp), %eax    # eax contains our answer

  movl %ebp, %esp      # scrub local var off stack
  popl %ebp
  ret
