module lclass_interfaces
  !---------------------------------------------------------------------
  ! LCLASS interfaces, all kinds (private or public). Do not use directly
  ! out of the library.
  !---------------------------------------------------------------------
  !
  use lclass_interfaces_public
  use lclass_interfaces_private
  !
end module lclass_interfaces
!
module lclass_dependencies_interfaces
  !---------------------------------------------------------------------
  ! @ private
  ! LCLASS dependencies public interfaces. Do not use out of the library.
  !---------------------------------------------------------------------
  !
  use gkernel_interfaces
  use lclass_interfaces_public
end module lclass_dependencies_interfaces
!
module lclass_user_interfaces
  !---------------------------------------------------------------------
  ! Public interfaces for LClass subroutines and functions
  !---------------------------------------------------------------------
  !
  !inherit from class
  use class_user_interfaces
  !
end module lclass_user_interfaces
!
module lclass_api
  !---------------------------------------------------------------------
  ! @ public
  !   LCLASS public interfaces, parameters, and types. Can be used by
  ! external programs
  !---------------------------------------------------------------------
  !
  !inherit for class
  use class_api
  !
  use lclass_types
  use lclass_interfaces_public
end module lclass_api
