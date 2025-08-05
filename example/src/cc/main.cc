#include <iostream>
#include "src/cc/foo.h"

int main() {
    int x = 5;
    int y = 10;
    int sum = add(x, y);
    std::cout << "The sum of " << x << " and " << y << " is: " << sum << std::endl;
    return sum;
}
