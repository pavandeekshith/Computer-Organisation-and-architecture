#include <iostream>
#include <vector>
#include <ctime>

using namespace std;

void fibonacci_loop_memo(int n) {
    vector<long long> fib(n, 0);
    fib[1] = 1;
    for (int i = 2; i < n; ++i) {
        fib[i] = fib[i - 1] + fib[i - 2];
    }
    for (int i = 0; i < n; ++i) {
        cout << fib[i] << " ";
    }
}

int main() {
    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    fibonacci_loop_memo(50);

    clock_gettime(CLOCK_MONOTONIC, &end);

    double time_taken = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
    cout << "\nLoop with Memoization Time: " << time_taken << " seconds\n";

    return 0;
}
