#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>

// Структура для передачи данных в поток
typedef struct {
    int n;
    long long result;
} ThreadData;

// Глобальный файловый указатель и мьютекс для синхронизации
FILE* output_file;
pthread_mutex_t file_mutex;

// Функция вычисления факториала для потока
void* factorial_thread(void* arg) {
    ThreadData* data = (ThreadData*)arg;
    data->result = 1;
    
    for (int i = 2; i <= data->n; i++) {
        data->result *= i;
    }
    
    // Захватываем мьютекс перед записью в файл
    pthread_mutex_lock(&file_mutex);
    fprintf(output_file, "Thread: factorial(%d) = %lld\n", data->n, data->result);
    // Освобождаем мьютекс
    pthread_mutex_unlock(&file_mutex);
    
    printf("Thread: factorial(%d) = %lld\n", data->n, data->result);
    return NULL;
}

int main() {
    pthread_t thread1, thread2;
    ThreadData data1 = {10, 0};  // 10!
    ThreadData data2 = {15, 0};  // 15!
    
    // Открываем файл для записи
    output_file = fopen("factorial_result.txt", "w");
    if (output_file == NULL) {
        printf("Error: cannot open output file!\n");
        return 1;
    }
    
    // Инициализируем мьютекс
    pthread_mutex_init(&file_mutex, NULL);
    
    fprintf(output_file, "=== Factorial Calculation Results ===\n");
    fprintf(output_file, "Main: Starting parallel calculations...\n\n");
    
    printf("Main: Starting parallel calculations...\n\n");
    
    // Создание потоков
    if (pthread_create(&thread1, NULL, factorial_thread, &data1) != 0) {
        printf("Error creating thread 1\n");
        fclose(output_file);
        return 1;
    }
    
    if (pthread_create(&thread2, NULL, factorial_thread, &data2) != 0) {
        printf("Error creating thread 2\n");
        fclose(output_file);
        return 1;
    }
    
    // Основной поток тоже что-то делает
    printf("Main: Threads are running, doing own work...\n");
    
    // Ожидание завершения потоков (синхронизация)
    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);
    
    // Записываем финальные результаты в файл
    fprintf(output_file, "\n=== Results ===\n");
    fprintf(output_file, "Factorial 10 = %lld\n", data1.result);
    fprintf(output_file, "Factorial 15 = %lld\n", data2.result);
    
    // Проверка корректности
    fprintf(output_file, "\nVerification:\n");
    fprintf(output_file, "10! should be 3628800\n");
    fprintf(output_file, "15! should be 1307674368000\n");
    
    // Вывод в консоль
    printf("\n=== Results ===\n");
    printf("Factorial 10 = %lld\n", data1.result);
    printf("Factorial 15 = %lld\n", data2.result);
    
    printf("\nVerification:\n");
    printf("10! should be 3628800\n");
    printf("15! should be 1307674368000\n");
    
    // Закрываем файл и уничтожаем мьютекс
    fclose(output_file);
    pthread_mutex_destroy(&file_mutex);
    
    printf("\nResults saved to factorial_result.txt\n");
    
    return 0;
}