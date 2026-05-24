# Компилятор и флаги
CC = g++
CFLAGS = -Wall -Wextra
OPT_FLAGS = -O0 -O1 -O2 -O3 -Os
DEBUG_FLAGS = -g

# Цели
all: factorial_O0 factorial_O3 factorial_debug factorial_threads

# Без оптимизации
factorial_O0: main.cpp factorial.cpp factorial.h
	$(CC) $(CFLAGS) -O0 -o factorial_O0.exe main.cpp factorial.cpp

# Максимальная оптимизация
factorial_O3: main.cpp factorial.cpp factorial.h
	$(CC) $(CFLAGS) -O3 -o factorial_O3.exe main.cpp factorial.cpp

# С отладочной информацией
factorial_debug: main.cpp factorial.cpp factorial.h
	$(CC) $(CFLAGS) $(DEBUG_FLAGS) -o factorial_debug.exe main.cpp factorial.cpp

# Генерация ассемблерного кода с разными оптимизациями
asm_O0:
	$(CC) -S -O0 -o factorial_O0.s factorial.cpp
	$(CC) -S -O0 -o main_O0.s main.cpp

asm_O3:
	$(CC) -S -O3 -o factorial_O3.s factorial.cpp
	$(CC) -S -O3 -o main_O3.s main.cpp

asm_debug:
	$(CC) -S -g -o factorial_debug.s factorial.cpp

# Многопоточная версия (с выводом в файл factorial_result.txt)
factorial_threads: factorial_threads.cpp
	$(CC) $(CFLAGS) -O2 -pthread -o factorial_threads.exe factorial_threads.cpp

# Очистка (удаляем все временные файлы и результат)
clean:
	del /Q *.o *.exe *.s factorial_result.txt 2>nul

# Запуск тестов
test: factorial_O0 factorial_O3
	@echo "=== Without optimization ==="
	factorial_O0.exe
	@echo ""
	@echo "=== With O3 optimization ==="
	factorial_O3.exe

# Запуск многопоточной версии и показ файла
run_threads: factorial_threads
	@echo "=== Running multithreaded factorial ==="
	factorial_threads.exe
	@echo ""
	@echo "=== Contents of factorial_result.txt ==="
	type factorial_result.txt

# Только компиляция многопоточной версии
build_threads: factorial_threads.cpp
	$(CC) $(CFLAGS) -O2 -pthread -o factorial_threads.exe factorial_threads.cpp
	@echo "Built factorial_threads.exe (outputs to factorial_result.txt)"

.PHONY: all clean test asm_O0 asm_O3 asm_debug run_threads build_threads