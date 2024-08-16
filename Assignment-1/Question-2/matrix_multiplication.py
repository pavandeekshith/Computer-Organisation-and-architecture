import numpy as np
import time
import os
import matplotlib.pyplot as plt

N_values = [64, 128, 256, 512, 1024]

int_cpu_times = []
int_system_times = []
float_cpu_times = []
float_system_times = []

int_meat_times = []
float_meat_times = []

int_meat_percentages = []
float_meat_percentages = []

def matrix_multiplication(N, dtype):
    np.random.seed(0)  
    matrix = np.random.randint(0, 11, size=(N, N)).astype(dtype)  
    result = np.zeros((N, N), dtype=dtype)

    start_process_time_total = time.process_time()
    start_os_times_total = os.times()

    start_meat_time = time.process_time()

    for i in range(N):
        for j in range(N):
            for k in range(N):
                result[i][j] += matrix[i][k] * matrix[k][j]

    end_meat_time = time.process_time()

    end_process_time_total = time.process_time()
    end_os_times_total = os.times()

    cpu_time_used_total = end_process_time_total - start_process_time_total
    user_time_used_total = end_os_times_total.user - start_os_times_total.user
    system_time_used_total = end_os_times_total.system - start_os_times_total.system

    meat_time_used = end_meat_time - start_meat_time

    meat_percentage = (meat_time_used / cpu_time_used_total * 100) if cpu_time_used_total > 0 else 0

    return cpu_time_used_total, system_time_used_total, meat_time_used, meat_percentage

for N in N_values:
    print(f"Performing matrix multiplication for size {N}x{N}")

    int_cpu_time, int_system_time, int_meat_time, int_meat_percentage = matrix_multiplication(N, dtype=int)
    int_cpu_times.append(int_cpu_time)
    int_system_times.append(int_system_time)
    int_meat_times.append(int_meat_time)
    int_meat_percentages.append(int_meat_percentage)
    print(f"Integer matrix Multiplication CPU time for {N}x{N}: {int_cpu_time:.6f} seconds")
    print(f"Integer matrix Multiplication System time for {N}x{N}: {int_system_time:.6f} seconds")
    print(f"Integer matrix Multiplication Time for {N}x{N}: {int_meat_time:.6f} seconds")
    print(f"Integer matrix Multiplication Meat proportion for {N}x{N}: {int_meat_percentage:.2f}%")

    float_cpu_time, float_system_time, float_meat_time, float_meat_percentage = matrix_multiplication(N, dtype=float)
    float_cpu_times.append(float_cpu_time)
    float_system_times.append(float_system_time)
    float_meat_times.append(float_meat_time)
    float_meat_percentages.append(float_meat_percentage)
    print(f"Float matrix Multiplication CPU time for {N}x{N}: {float_cpu_time:.6f} seconds")
    print(f"Float matrix Multiplication System time for {N}x{N}: {float_system_time:.6f} seconds")
    print(f"Float matrix Multiplication Time for {N}x{N}: {float_meat_time:.6f} seconds")
    print(f"Float matrix Multiplication Meat proportion for {N}x{N}: {float_meat_percentage:.2f}%")


plt.figure(figsize=(10, 6))
plt.plot(N_values, int_cpu_times, label="Integer CPU Time", marker='o')
plt.plot(N_values, float_cpu_times, label="Float CPU Time", marker='o')
plt.xlabel('Matrix Size (N)')
plt.ylabel('CPU Time (seconds)')
plt.title('Matrix Multiplication CPU Time for Different Data Types')
plt.legend()
plt.grid(True)
plt.show()

plt.figure(figsize=(10, 6))
plt.plot(N_values, int_system_times, label="Integer System Time", marker='o')
plt.plot(N_values, float_system_times, label="Float System Time", marker='o')
plt.xlabel('Matrix Size (N)')
plt.ylabel('System Time (seconds)')
plt.title('Matrix Multiplication System Time for Different Data Types')
plt.legend()
plt.grid(True)
plt.show()

plt.figure(figsize=(10, 6))
plt.plot(N_values, int_meat_times, label="Integer Meat Portion Time", marker='o')
plt.plot(N_values, float_meat_times, label="Float Meat Portion Time", marker='o')
plt.xlabel('Matrix Size (N)')
plt.ylabel('Meat Portion Time (seconds)')
plt.title('Matrix Multiplication Meat Portion Time for Different Data Types')
plt.legend()
plt.grid(True)
plt.show()

plt.figure(figsize=(10, 6))
plt.plot(N_values, int_meat_percentages, label="Integer Meat Portion Percentage", marker='o')
plt.plot(N_values, float_meat_percentages, label="Float Meat Portion Percentage", marker='o')
plt.xlabel('Matrix Size (N)')
plt.ylabel('Meat Portion Percentage (%)')
plt.title('Matrix Multiplication Meat Portion Percentage for Different Data Types')
plt.legend()
plt.grid(True)
plt.show()

