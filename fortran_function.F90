subroutine init_array(module_c_ptr, num1darrays_fromc, length1darrays_fromc)
  use, intrinsic :: iso_c_binding
  use arraytestmodule
  implicit none
  
  type (C_PTR) :: module_c_ptr
  integer :: num1darrays
  integer :: length1darrays
  
  type (arraytest_type), pointer :: module_here

  allocate(module_here)
  ! allocate an array in fortran inside of the module

  ! the pointer to this

  module_here%num1darrays = num1darrays_fromc
  module_here%length1darrays = length1darrays_fromc

  print* "module_here%num1darrays = ", module_here%num1darrays
  print* "module_here%length1darrays = ", module_here%length1darrays
  
  allocate(module_here%array2d(module_here%num1darrays,module_here%length1darrays))

  ! get the c pointer to return to cpp
  module_c_ptr = C_LOC(module_here)
  
end subroutine init_array

subroutine change_values(module_c_ptr)
  use, intrinsic :: iso_c_binding
  use arraytestmodule
  implicit none

  type (C_PTR) :: module_c_ptr

  type (arraytest_type), pointer :: module_here
  
  call C_F_POINTER(module_c_ptr,module_here)

  write(*,*) "Entering change_values Fortran subroutine"
  
end subroutine change_values
