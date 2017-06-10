module lclass_parameter
  !inherit from class
  use class_parameter
  !
end module lclass_parameter

module lclass_types
  !inherit from class
  use class_types
  !
  use lclass_parameter
  !
  !section 0
  !LSET:
  type :: lclass_set_type
    character(len=20) method; !one of 'merge'...
  end type lclass_set_type
end module lclass_types
