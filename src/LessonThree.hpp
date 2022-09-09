#ifndef H_ISAAC_IS_DOPE_H
#define H_ISAAC_IS_DOPE_H

#if defined(__GNUC__)
    //  GCC
        #define EXPORT __attribute__((visibility("default")))
#else
    #error "stop using windows and mac!"
#endif

//Get strings for all!
#include <string>

#ifdef ISSAC_IS_DOPE_DEF
    //embrace the void!
    EXPORT void MyHelloFunction(const char *);
#else
    #include <dlfcn.h>
    typedef void (*MyHelloFunctionPtr)(const char *);
#endif

#endif //H_ISAAC_IS_DOPE_H