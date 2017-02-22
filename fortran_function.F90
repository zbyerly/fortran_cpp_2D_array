subroutine init_array(module_c_ptr, num1darrays_fromc, length1darrays_fromc)
  use, intrinsic :: iso_c_binding
  use arraytestmodule
  implicit none
  
  type (C_PTR) :: module_c_ptr

  integer :: i,j ! loop variables
  
  integer :: num1darrays_fromc
  integer :: length1darrays_fromc
  
  type (arraytest_type), pointer :: module_here

  print*, "Fortran (init_array): Entering subroutine"
  print*, "Fortran (init_array): num1darrays_fromc = ", num1darrays_fromc
  print*, "Fortran (init_array): length1darrays_fromc = ", length1darrays_fromc
  
  allocate(module_here)
  ! allocate an array in fortran inside of the module

  ! the pointer to this

  module_here%num1darrays = num1darrays_fromc
  module_here%length1darrays = length1darrays_fromc

  print*, "Fortran (init_array): module_here%num1darrays = ", module_here%num1darrays
  print*, "Fortran (init_array): module_here%length1darrays = ", module_here%length1darrays

  print*, "Fortran (init_array): allocating module_here"

  ! Fortran should store this (1,1)(2,1)(3,1) (2,1)(2,2)(2,3)
  ! so I should be able to get the memory address for (1,i) and get
  ! the i array
  allocate(module_here%array2d(module_here%length1darrays,module_here%num1darrays))
!  allocate(module_here%array2d(module_here%num1darrays,module_here%length1darrays))
  
  ! get the c pointer to return to cpp
  module_c_ptr = C_LOC(module_here)

  print*, "Fortran (init_array): printing values"
  do i=1,module_here%length1darrays
     do j=1,module_here%num1darrays
        module_here%array2d(i,j) = i+j*2.5
        print*, "array2d[",i,"][",j,"] = ",module_here%array2d(i,j)
     end do
  end do
  
end subroutine init_array

subroutine get_array_ptr(module_c_ptr,i,array_c_ptr)
  use, intrinsic :: iso_c_binding
  use arraytestmodule
  implicit none

  integer :: i ! index of the sub array
  
  type (C_PTR) :: module_c_ptr
  type (C_PTR) :: array_c_ptr

  type (arraytest_type), pointer :: module_here

  call C_F_POINTER(module_c_ptr,module_here)

  print*, "index i = ", i
  
!  array_c_ptr = C_LOC(module_here%array2d(i+1,1))
  array_c_ptr = C_LOC(module_here%array2d(1,i+1))

end subroutine get_array_ptr

subroutine print_values(module_c_ptr)
  use, intrinsic :: iso_c_binding
  use arraytestmodule
  implicit none

  type (C_PTR) :: module_c_ptr

  type (arraytest_type), pointer :: module_here

  integer :: i,j ! loop variables
  
  call C_F_POINTER(module_c_ptr,module_here)

  write(*,*) "Fortran (print_values): Entering subroutine"

  print*, "Fortran (print_values): printing values"
  do i=1,module_here%length1darrays
     do j=1,module_here%num1darrays
        print*, "array2d[",i,"][",j,"] = ",module_here%array2d(i,j)
     end do
  end do

!  do i=1,module_here%length1darrays
!     do j=1,module_here%num1darrays
!        print*, "array2d[",j,"][",i,"] = ",module_here%array2d(j,i)
!     end do
!  end do
  
  
end subroutine print_values

! array2d( length, num)
! array2d( num, length)
