//Program that computes the gcd of two integers using the Euclidean algorithm, wwritten as a procedure.
#include <iostream>
int num1 = 48;
int num2 = 18;

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int main() {
   
    int result = gcd(num1, num2);
        std::cout << result << std::endl;
        return 0;
}