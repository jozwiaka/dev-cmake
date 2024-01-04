#include <iostream>
#include <thread>
#include <mutex>
#include <vector>

std::mutex mutex1;
std::mutex mutex2;

void function1()
{
    std::cout << "Thread 1: Trying to lock mutex1..." << std::endl;
    std::unique_lock<std::mutex> lock1(mutex1);
    std::this_thread::sleep_for(std::chrono::milliseconds(1)); // Simulate some work
    std::cout << "Thread 1: Locked mutex1." << std::endl;

    std::cout << "Thread 1: Trying to lock mutex2..." << std::endl;
    std::unique_lock<std::mutex> lock2(mutex2);
    std::cout << "Thread 1: Locked mutex2." << std::endl;

    // Do some work with the locked resources...

    lock2.unlock();
    lock1.unlock();
}

void function2()
{
    std::cout << "Thread 2: Trying to lock mutex2..." << std::endl;
    std::unique_lock<std::mutex> lock2(mutex2);
    std::this_thread::sleep_for(std::chrono::milliseconds(1)); // Simulate some work
    std::cout << "Thread 2: Locked mutex2." << std::endl;

    std::cout << "Thread 2: Trying to lock mutex1..." << std::endl;
    std::unique_lock<std::mutex> lock1(mutex1);
    std::cout << "Thread 2: Locked mutex1." << std::endl;

    // Do some work with the locked resources...

    lock1.unlock();
    lock2.unlock();
}

void function3(int id)
{
    std::cout << "ID = " << id << std::endl;
    std::this_thread::sleep_for(std::chrono::milliseconds(1000 * 3600)); // Simulate some work
}

int main()
{
    // std::thread t1(function1);
    // std::thread t2(function2);
    // t1.join();
    // t2.join();
    size_t SIZE = 100;
    std::vector<std::thread> v;
    for (int i = 0; i < SIZE; ++i)
    {
        v.push_back(std::thread(function3, i));
    }

    for (int i = 0; i < SIZE; ++i)
    {
        v[i].join();
    }

    return 0;
}
