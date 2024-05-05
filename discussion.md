# Discussion and Reflection


The bulk of this project consists of a collection of five
questions. You are to answer these questions after spending some
amount of time looking over the code together to gather answers for
your questions. Try to seriously dig into the project together--it is
of course understood that you may not grasp every detail, but put
forth serious effort to spend several hours reading and discussing the
code, along with anything you have taken from it.

Questions will largely be graded on completion and maturity, but the
instructors do reserve the right to take off for technical
inaccuracies (i.e., if you say something factually wrong).

Each of these (six, five main followed by last) questions should take
roughly at least a paragraph or two. Try to aim for between 1-500
words per question. You may divide up the work, but each of you should
collectively read and agree to each other's answers.

[ Question 1 ] 

For this task, you will three new .irv programs. These are
`ir-virtual?` programs in a pseudo-assembly format. Try to compile the
program. Here, you should briefly explain the purpose of ir-virtual,
especially how it is different than x86: what are the pros and cons of
using ir-virtual as a representation? You can get the compiler to to
compile ir-virtual files like so: 

Ir-virtual and the test made for the code is to take relatively simple pseudocode that can then be translated into assembly/machine code. Since ir-virtual can compile into x86. This can lead to creating code with minimal changes to initial code.  This is an easy way of generating x86 code without the hassle of learning a the complexity of assembly.  It also helps you with debugging from a higher level rather than straight into the grit. Some cons I can see is lacking the understanding of what is totally going on in the assembly language.  It looks way more complicated than the pseudo code itself and it is easy to get lost while looking at the translation.  Also, with translation there may even be mistakes when translation occurs and breaks the system.
racket compiler.rkt -v test-programs/sum1.irv 

(Also pass in -m for Mac)

[ Question 2 ] 

For this task, you will write three new .ifa programs. Your programs
must be correct, in the sense that they are valid. There are a set of
starter programs in the test-programs directory now. Your job is to
create three new `.ifa` programs and compile and run each of them. It
is very much possible that the compiler will be broken: part of your
exercise is identifying if you can find any possible bugs in the
compiler.

For each of your exercises, write here what the input and output was
from the compiler. Read through each of the phases, by passing in the
`-v` flag to the compiler. For at least one of the programs, explain
carefully the relevance of each of the intermediate representations.

For this question, please add your `.ifa` programs either (a) here or
(b) to the repo and write where they are in this file.

test1:
(let* ([x 3] [y 1]) (print (+ x y)))
output: 
Input source tree in IfArith:
'(let* ((x 3) (y 1)) (print (+ x y)))
ifarith-tiny:
'(let ((x 3)) (let ((y 1)) (print (+ x y))))
'(let ((x 3)) (let ((y 1)) (print (+ x y))))
3
'(let ((y 1)) (print (+ x y)))
1
'(print (+ x y))
'(+ x y)
'x
'y
anf:
'(let ((x1262 3))
   (let ((x x1262))
     (let ((x1263 1))
       (let ((y x1263)) (let ((x1264 (+ x y))) (print x1264))))))
ir-virtual:
'(((label lab1265) (mov-lit x1262 3))
  ((label lab1266) (mov-reg x x1262))
  ((label lab1267) (mov-lit x1263 1))
  ((label lab1268) (mov-reg y x1263))
  ((label lab1269) (mov-reg x1264 x))
  (add x1264 y)
  ((label lab1270) (print x1264))
  (return 0))
x86:
section .data
        int_format db "%ld",10,0


        global _main
        extern printf
section .text


_start: call main
        mov rax, 60
        xor rdi, rdi
        syscall


main:   push rbp
        mov rbp, rsp
        sub rsp, 80
        mov esi, 3
        mov [rbp-24], esi
        mov esi, [rbp-24]
        mov [rbp-32], esi
        mov esi, 1
        mov [rbp-16], esi
        mov esi, [rbp-16]
        mov [rbp-40], esi
        mov esi, [rbp-32]
        mov [rbp-8], esi
        mov edi, [rbp-40]
        mov eax, [rbp-8]
        add eax, edi
        mov [rbp-8], eax
        mov esi, [rbp-8]
        lea rdi, [rel int_format]
        mov eax, 0
        call printf
        mov rax, 0
        jmp finish_up
finish_up:      add rsp, 80
        leave
        ret
test2:
(+ 3 (- 6 4))
output:
'(+ 3 (- 6 4))
ifarith-tiny:
'(+ 3 (- 6 4))
'(+ 3 (- 6 4))
3
'(- 6 4)
6
4
anf:
'(let ((x1262 3))
   (let ((x1263 6))
     (let ((x1264 4))
       (let ((x1265 (- x1263 x1264))) (let ((x1266 (+ x1262 x1265))) x1266)))))
ir-virtual:
'(((label lab1267) (mov-lit x1262 3))
  ((label lab1268) (mov-lit x1263 6))
  ((label lab1269) (mov-lit x1264 4))
  ((label lab1270) (mov-reg x1265 x1263))
  (sub x1265 x1264)
  ((label lab1271) (mov-reg x1266 x1262))
  (add x1266 x1265)
  (return x1266))
x86:
section .data
        int_format db "%ld",10,0


        global _main
        extern printf
section .text


_start: call main
        mov rax, 60
        xor rdi, rdi
        syscall


main:   push rbp
        mov rbp, rsp
        sub rsp, 80
        mov esi, 3
        mov [rbp-32], esi
        mov esi, 6
        mov [rbp-24], esi
        mov esi, 4
        mov [rbp-16], esi
        mov esi, [rbp-24]
        mov [rbp-8], esi
        mov edi, [rbp-16]
        mov eax, [rbp-8]
        sub eax, edi
        mov [rbp-8], eax
        mov esi, [rbp-32]
        mov [rbp-40], esi
        mov edi, [rbp-8]
        mov eax, [rbp-40]
        add eax, edi
        mov [rbp-40], eax
        mov rax, [rbp-40]
        jmp finish_up
finish_up:      add rsp, 80
        leave
        ret
test3:
(if (+ 5 3)
    (print 1)
    (print 0))
output:
Input source tree in IfArith:
'(if (+ 5 3) (print 1) (print 0))
ifarith-tiny:
'(if (+ 5 3) (print 1) (print 0))
'(if (+ 5 3) (print 1) (print 0))
'(+ 5 3)
5
3
'(print 1)
1
'(print 0)
0
anf:
'(let ((x1262 5))
   (let ((x1263 3))
     (let ((x1264 (+ x1262 x1263)))
       (if x1264
         (let ((x1265 1)) (print x1265))
         (let ((x1266 0)) (print x1266))))))
ir-virtual:
'(((label lab1267) (mov-lit x1262 5))
  ((label lab1268) (mov-lit x1263 3))
  ((label lab1269) (mov-reg x1264 x1262))
  (add x1264 x1263)
  ((label lab1270) (mov-lit zero1275 0))
  (cmp x1264 zero1275)
  (jz lab1271)
  (jmp lab1273)
  ((label lab1271) (mov-lit x1265 1))
  ((label lab1272) (print x1265))
  (return 0)
  ((label lab1273) (mov-lit x1266 0))
  ((label lab1274) (print x1266))
  (return 0))
x86:
section .data
        int_format db "%ld",10,0


        global _main
        extern printf
section .text


_start: call main
        mov rax, 60
        xor rdi, rdi
        syscall


main:   push rbp
        mov rbp, rsp
        sub rsp, 128
        mov esi, 5
        mov [rbp-32], esi
        mov esi, 3
        mov [rbp-24], esi
        mov esi, [rbp-32]
        mov [rbp-16], esi
        mov edi, [rbp-24]
        mov eax, [rbp-16]
        add eax, edi
        mov [rbp-16], eax
        mov esi, 0
        mov [rbp-40], esi
        mov edi, [rbp-40]
        mov eax, [rbp-16]
        cmp eax, edi
        mov [rbp-16], eax
        jz lab1271
        jmp lab1273
lab1271:        mov esi, 1
        mov [rbp-8], esi
        mov esi, [rbp-8]
        lea rdi, [rel int_format]
        mov eax, 0
        call printf
        mov rax, 0
        jmp finish_up
lab1273:        mov esi, 0
        mov [rbp-64], esi
        mov esi, [rbp-64]
        lea rdi, [rel int_format]
        mov eax, 0
        call printf
        mov rax, 0
        jmp finish_up
finish_up:      add rsp, 128
        leave
        ret

For all these tests we entered a higher level let for one of the tests. THe first thing we see the compiler do is that the conversion of ifarith to tiny.  This is done through that function call. We are able to see that it goes through each input with one and another. First done is when it reads the 3 in let and the it reads 1.  It then goes through the print then the addition.  In the addition it reads and seperates the x and y in the process.  It then converts it into anf where we can see that the operations being done one by one in the correct order.  Then it become ir-virtial code where it is using the simplified assembly to create in IRV to then convert it to x86.  It then shows the code in x86.
[ Question 3 ] 

Describe each of the passes of the compiler in a slight degree of
detail, using specific examples to discuss what each pass does. The
compiler is designed in series of layers, with each higher-level IR
desugaring to a lower-level IR until ultimately arriving at x86-64
assembler. Do you think there are any redundant passes? Do you think
there could be more?

In answering this question, you must use specific examples that you
got from running the compiler and generating an output.

The first thing that is done when the compiler is called is a check if what ever is inputed is valid. It breaks down everything inside of the code it was given breaking down each of the calls and the vairblees in it until there is nothing left.  Once that is reached then everything is true and then it goes to the anf translation. This translates the order and address of what each value being accessed and what is being used for. This is done through let-bindings, which are used for the next translation. It starts with the variable and then goes to the function calls at the end.  After it reaches the ir-virtual translation where you can see the initial call in the values with the mov-lit and the addresses they are getting put. All of the simplified assembly is being written and ordered. This looks a lot like the IRV test we have made for translation. After this it reaches the final step and creates the x86 assembly code.
[ Question 4 ] 

This is a larger project, compared to our previous projects. This
project uses a large combination of idioms: tail recursion, folds,
etc.. Discuss a few programming idioms that you can identify in the
project that we discussed in class this semester. There is no specific
definition of what an idiom is: think carefully about whether you see
any pattern in this code that resonates with you from earlier in the
semester.


In the project and throughout the entire semester, we can see the usage of idioms such as pattern matching, tail recursion, and high-order functions. Pattern matching is used to check if data matches a particular pattern, then perform another code branch based on the pattern. This makes the code work more efficiently than using multiple if statements. We also see tail recursion being used. Tail recursion calls the recursive call at the right before the value is returned, allowing for no computation to be done after the recursive call. Lastly, we see high-order functions like map and fold. These allow for more expressive and concise code.

[ Question 5 ] 

In this question, you will play the role of bug finder. I would like
you to be creative, adversarial, and exploratory. Spend an hour or two
looking throughout the code and try to break it. Try to see if you can
identify a buggy program: a program that should work, but does
not. This could either be that the compiler crashes, or it could be
that it produces code which will not assemble. Last, even if the code
assembles and links, its behavior could be incorrect.

To answer this question, I want you to summarize your discussion,
experiences, and findings by adversarily breaking the compiler. If
there is something you think should work (but does not), feel free to
ask me.

Your team will receive a small bonus for being the first team to
report a unique bug (unique determined by me).

The bug I found was in my test case:
(let* ([a true]
       [b false])
       (cond [(and a b) (print 1)]
             [(or a b) (print 2)]
             [else (print 0)]))
When entered it says that there is no match clause for the b, which I am assuming is in the first Cond that contains and.  When looking at the code for the Cond in the ifarith->ifarith-tiny, I could see that in the condition it only looks at if it is just true and false.  It should be looking at into the first parameter and see if it needs to be broken down more than what it is.  This would be down by recursion because based on what the matching looks like there is only recursion down on the rest of the list of Conds. It makes the conds into if statements and does not even pass itself as (and a b), so it does not know if there is a true and false because there is no matching clause for it.

[ High Level Reflection ] 

In roughly 100-500 words, write a summary of your findings in working
on this project: what did you learn, what did you find interesting,
what did you find challenging? As you progress in your career, it will
be increasingly important to have technical conversations about the
nuts and bolts of code, try to use this experience as a way to think
about how you would approach doing group code critique. What would you
do differently next time, what did you learn?

I learned how code, even psuedocode can be interpreted and soon changed into assembly.  CIS 341 introduced us to x86 already but actually seeing the code go from one to another seemed really cool. In addition seeing the mutiple steps it take to make an compiler work effectivelty and efficenetly was interesting. It was hard finding a bug in the code in general.  In other courses when looking at different at code it either work or it did not.  This code it seemed like it worked no matter what but that was not the case.  It is hard to try to destroy something that is working.  We were able to do it fine but just the proccess of where to start was difficult.  I learned a lot about how to approach code and how to read it.  Being able to read code and understand what is going one is important espiaclly in the future where not all the code you edit is not written by you.