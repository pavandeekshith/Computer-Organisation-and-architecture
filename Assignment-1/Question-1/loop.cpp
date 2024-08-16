#include <iostream>
#include <ctime>

using namespace std;

void fibonacci_loop(int n) {
    long long a = 0, b = 1, next;
    for (int i = 0; i < n; ++i) {
        cout << a << " ";
        next = a + b;
        a = b;
        b = next;
    }
}

int main() {
    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    fibonacci_loop(50);

    clock_gettime(CLOCK_MONOTONIC, &end);

    double time_taken = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
    cout << "\nLoop Time: " << time_taken << " seconds\n";

    return 0;
}

