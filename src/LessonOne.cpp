// Include Local Header File
#include "LessonOne.hpp"
// Include standard header file
#include <iostream>

class darthpjb
{
    public:
    int a;
    std::string name;
    void DoSomething();

    //constructor
    darthpjb();
    darthpjb(int);

    //destructor
    ~darthpjb();

    //copy constructor
    darthpjb(const darthpjb & Other);

    
};

darthpjb::darthpjb(const darthpjb & Other)
{
    a = Other.a;
    name = Other.name;
    std::cout << "prove i copied\n";
}

void darthpjb::DoSomething()
{
    std::cout << "Yello World " << name << " " << a << "\n";
}

darthpjb::darthpjb(int NewA) 
{
    a = NewA;
    name = "moomoo";
}
darthpjb::darthpjb()
{
    a=0;
    name="Johan";

    std::cout << "PROVE IT\n";
}
darthpjb::~darthpjb()
{
    std::cout << "It Died\n";
}

int main(int argV, char ** argC)
{
    std::cout << "Really, begin.\n";
    darthpjb Foo;
    darthpjb Bar(5);

    darthpjb CopyMe(Foo);
    Foo.DoSomething();
    Bar.DoSomething();
    return 0;
}