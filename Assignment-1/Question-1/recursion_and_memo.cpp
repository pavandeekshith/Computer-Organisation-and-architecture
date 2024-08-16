#include <iostream>
#include <vector>
#include <ctime>

using namespace std;

vector<long long> memo(51, -1);

long long fibonacci_recursion_memo(int n) {
    if (n <= 1) return n;
    if (memo[n] != -1) return memo[n];
    return memo[n] = fibonacci_recursion_memo(n - 1) + fibonacci_recursion_memo(n - 2);
}

int main() {
    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    for (int i = 0; i < 50; ++i) {
        cout << fibonacci_recursion_memo(i) << " ";
    }

    clock_gettime(CLOCK_MONOTONIC, &end);

    double time_taken = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
    cout << "\nRecursion with Memoization Time: " << time_taken << " seconds\n";

    return 0;
}
