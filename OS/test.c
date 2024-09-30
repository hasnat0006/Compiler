#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int fuel = 0;

pthread_mutex_t fuelLock;
pthread_cond_t fuelCond;

void* filling(void* args) {
    for (int i = 0; i < 10; i++) {
        pthread_mutex_lock(&fuelLock);
        fuel += 60;
        printf("Filling... Fuel is %d.\n", fuel);
        pthread_mutex_unlock(&fuelLock);
        pthread_cond_broadcast(&fuelCond);
        sleep(1);
    }
    return NULL;
}

void* distribution(void* args) {
    pthread_mutex_lock(&fuelLock);
    while (fuel < 40) {
        printf("Waiting for fuel to be filled.\n");
        sleep(1);
        pthread_cond_wait(&fuelCond, &fuelLock);
    }
    fuel -= 40;
    printf("Distributing....Fuel left: %d\n", fuel);
    pthread_mutex_unlock(&fuelLock);
    return NULL;
}

int main() {
    pthread_t th[10];
    pthread_mutex_init(&fuelLock, NULL);
    pthread_cond_init(&fuelCond, NULL);
    for (int i = 0; i < 10; i++) {
        if (i == 9)
            pthread_create(&th[i], NULL, &filling, NULL);
        else
            pthread_create(&th[i], NULL, &distribution, NULL);
    }
    for (int i = 0; i < 10; i++) {
        pthread_join(th[i], NULL);
    }
    pthread_mutex_destroy(&fuelLock);
    pthread_cond_destroy(&fuelCond);
}
