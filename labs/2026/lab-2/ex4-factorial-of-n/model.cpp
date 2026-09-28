//Program that prints the factorial of a number n, with the calculation written as a procedure.
#include <iostream>
using namespace std;
int n = 5;

int factorial(int n) {
    if (n <= 1) {
        return 1;
    }
    return n * factorial(n - 1);
}

int main() {
    int result = factorial(n);
    std::cout << result << std::endl;
    return 0;
}