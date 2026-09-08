// CS3520 - Worked example: maximum value in an array
// C++ model. Written first, tested, then translated to RISC-V assembly.

#include <iostream>

int find_max(const int arr[], int n)
{
    int max = arr[0];              // assume the first element is the largest
    for (int i = 1; i < n; i++) {  // examine every remaining element
        if (arr[i] > max) {
            max = arr[i];
        }
    }
    return max;
}

int main()
{
    int array[] = {12, 45, 7, 93, 28, 61, 4};
    int n = 7;

    std::cout << "Maximum: " << find_max(array, n) << std::endl;
    return 0;
}
