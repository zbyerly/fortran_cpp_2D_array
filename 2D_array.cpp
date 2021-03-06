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
    
    // Print values from c++ code
    std::cout << "cpp: Printing values from c++ code" << std::endl;
    for (int i=0; i<num1darrays; i++)
	{
	    std::cout << array_ptrs[i] << std::endl;
	    double *dptr;
	    dptr = (double *)array_ptrs[i];
	    
	    for (int j=0; j<length1darrays; j++)
		{
		    std::cout << "array[" << i+1 << "," << j+1 << "] = " << dptr[j]
			      << std::endl;
		    dptr[j] = i+j*3.5;
		}
	}

    std::cout << "cpp: Changing array vales" << std::endl;
    
    for (int i=0; i<num1darrays; i++)
	{
	    double *dptr;
	    dptr = (double *)array_ptrs[i];
	    
	    for (int j=0; j<length1darrays; j++)
		{
		    std::cout << "array[" << i+1 << "," << j+1 << "] = " << dptr[j]
			      << std::endl;
		}
	}
	
    
    FNAME(print_values)(&module_ptr);
    
}
