#include <iostream>
#include fname.h

extern"C" {
    void FNAME(init_array)(void** module_c_ptr,
			   int* num1darrays_fromc,
			   int* length1darrays);
    void FNAME(change_values)(void** module_c_ptr,
			      double* buffer,
			      int* size);
}

int main()
{
    std::cout << "Starting program!" << std::endl;
}
