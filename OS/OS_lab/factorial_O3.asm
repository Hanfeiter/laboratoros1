	.file	"factorial.cpp"
	.text
	.p2align 4
	.globl	_Z19factorial_recursivei; Итеративная функция factorial
	.def	_Z19factorial_recursivei;.scl 2; .type 32; .endef
	.seh_proc	_Z19factorial_recursivei
_Z19factorial_recursivei:
.LFB0:
	.seh_endprologue
        ; Пролог функции - обработка аргумента
	movslq	%ecx, %rax ; Расширяем n до 64 бит
	cmpl	$1, %ecx   ; Сравниваем n с 1
	jle	.L11       ; Если n <= 1, переход к возврату 1
        ; Инициализация: подготовка к циклу
	movl	%eax, %ecx ; Сохраняем n в ecx
	movq	%rax, %rdx ; Копируем n в rdx (результат)
	subq	$1, %rax   ; Уменьшаем n на 1
	andl	$1, %ecx   ; Проверяем чётность n
	cmpl	$1, %eax   ; Сравниваем с 1
	jle	.L1        ; Если мало, переход
	testl	%ecx, %ecx ; Проверяем флаг чётности
	je	.L4        ; Если чётное, переход к циклу
        ; Обработка перед циклом
	imulq	%rax, %rdx ; Умножаем результат
	subq	$1, %rax   ; Уменьшаем счётчик
	cmpl	$1, %eax   ; Проверяем границу
	jle	.L1        ; Выход если достигли
	.p2align 5         ; Выравнивание для оптимизации
	.p2align 4
	.p2align 3
.L4:
        ; Основной цикл: умножение парами
	imulq	%rax, %rdx     ; Умножаем на i
	leaq	-1(%rax), %rcx ; Вычисляем (i-1)
	subq	$2, %rax       ; Уменьшаем на 2
	imulq	%rcx, %rdx     ; Умножаем на (i-1)
	cmpl	$1, %eax       ; Проверяем границу
	jg	.L4            ; Продолжаем цикл
.L1:
        ; Эпилог функции: возврат результата
	movq	%rdx, %rax  ; Результат в rax
	ret                 ; Возврат из функции
	.p2align 4,,10      ; Выравнивание
	.p2align 3
.L11:
        ; Случай n <= 1
	movl	$1, %edx    ; Результат = 1
	movq	%rdx, %rax  ; Возвращаем 1
	ret
	.seh_endproc
        ; Вторая функция
	.p2align 4          
	.globl	_Z19factorial_iterativei; Итеративная функция factorial
	.def	_Z19factorial_iterativei;.scl 2; .type 32; .endef
	.seh_proc	_Z19factorial_iterativei
_Z19factorial_iterativei:
.LFB1:
	.seh_endprologue
	cmpl	$1, %ecx      ; Сравниваем n с 1
	jle	.L17          ; Если n <= 1, переход к возврату 1
        ; Инициализация цикла: result = 1, i = 2
	leal	1(%rcx), %r8d ; r8d = n + 1 (граница)
	movl	$2, %eax      ; i = 2
	leal	1(%rcx), %r8d ; r8d = n + 1 (граница)
	movl	$2, %eax      ; i = 2
	movl	$1, %edx      ; result = 1
	testb	$1, %r8b      ; Проверяем чётность
	je	.L16          ; Если чётная, к циклу
	
	; Подготовка для нечётного случая
	movl	$3, %eax      ; i = 3
	movl	$2, %edx      ; result = 2
	cmpq	%r8, %rax     ; Сравниваем с границей
	je	.L14          ; Если достигли, выход
	
	.p2align 5            ; Выравнивание
	.p2align 4
	.p2align 3
	
.L16:
	; Основной цикл: умножение парами
	imulq	%rax, %rdx     ; result *= i
	leaq	1(%rax), %rcx  ; Вычисляем (i+1)
	addq	$2, %rax       ; i += 2
	imulq	%rcx, %rdx     ; result *= (i+1)
	cmpq	%r8, %rax      ; Проверяем границу
	jne	.L16           ; Продолжаем цикл
	
.L14:
	; Возврат результата
	movq	%rdx, %rax     ; Результат в rax
	ret                    ; Возврат
	
	.p2align 4,,10         ; Выравнивание
	.p2align 3
	
.L17:
	; Случай n <= 1
	movl	$1, %edx       ; Результат = 1
	movq	%rdx, %rax     ; Возвращаем 1
	ret
	
	.seh_endproc
	
	; Мета-информация компилятора
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r3) 14.2.0"