//Program that counts the number of even elements in an array, with the array in memory.
#include <iostream>
using namespace std;
int arr[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
int arr_len = 10;
int main() {
    int count = 0;
    for (int i = 0; i < arr_len; i++) {
        if ((arr[i] & 1) == 0) {
            count++;
        }
    }
    cout << "Number of even elements in the array: " << count << endl;
    return 0;
}