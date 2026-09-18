// Program that prints larger of two integers held in the .data section
#include <iostream>

int a = 10; // First integer
int b = 20; // Second integer

int main() {
    int result;
    if (a > b) {
        result = a;
    } else {
        result = b;
    }   
    std::cout << "The larger integer is: " << result << std::endl;
    return 0;
}