//Program that computes the sum of the first n integers, with n in memeory.
#include <iostream>
using namespace std;
int sum = 0;
int n = 10;
int main(){
    for(int i = 1; i <= n; i++){
        sum += i;
    }
    cout << "The sum of the first " << n << " integers is: " << sum << endl;
    return 0;
}