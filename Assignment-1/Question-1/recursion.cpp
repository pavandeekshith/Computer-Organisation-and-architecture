#include <iostream>
#include <ctime>

using namespace std;

long long fibonacci_recursion(int n) {
    if (n <= 1) return n;
    return fibonacci_recursion(n - 1) + fibonacci_recursion(n - 2);
}

int main() {
    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    for (int i = 0; i < 50; ++i) {
        cout << fibonacci_recursion(i) << " ";
    }

    clock_gettime(CLOCK_MONOTONIC, &end);

    double time_taken = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
    cout << "\nRecursion Time: " << time_taken << " seconds\n";

    return 0;
}
