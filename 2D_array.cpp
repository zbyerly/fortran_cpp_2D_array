#include <iostream>
#include "fname.h"

extern"C" {
    void FNAME(init_array)(void** module_c_ptr,
			   int* num1darrays_fromc,
			   int* length1darrays);
    void FNAME(get_array_ptr)(void** module_c_ptr,
			      int* i,
			      void ** array_c_ptr);
    void FNAME(print_values)(void** module_c_ptr);
}

int main()
{
    std::cout << "cpp (main): Starting program!" << std::endl;

    // Declaring null pointer for array structure
    void *module_ptr = NULL;

    int num1darrays = 2; // number of arrays
    int length1darrays = 5; //length of the arrays

    void *array_ptrs[num1darrays];
    FNAME(init_array)(&module_ptr,&num1darrays,&length1darrays);

    for (int i=0; i<num1darrays; i++)
	{
	    FNAME(get_array_ptr)(&module_ptr,&i,&array_ptrs[i]);
	}

    FNAME(print_values)(&module_ptr);
    
}
