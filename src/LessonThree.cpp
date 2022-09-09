// Include Local Header File
#include "LessonThree.hpp"
#include <iostream>

int main(int argV, char ** argC)
{
    // open the library
    void* handle = dlopen("./LessonThree.so", RTLD_LAZY);
    if (!handle) 
    {
    std::cout << "Cannot open library: " << dlerror() << '\n';
    return 1;
    }

    // load the symbol
    // reset errors
    dlerror();

    MyHelloFunctionPtr helloFunction = (MyHelloFunctionPtr) dlsym(handle, "MyHelloFunction");
    const char *dlsym_error = dlerror();
    if (dlsym_error) 
    {
        std::cout << "Cannot load symbol 'hello': " << dlsym_error << '\n';
        dlclose(handle);
    }
    else
        helloFunction("Isaac!");
    return 0;
}