module lclass_merge_structure
  use lclass_parameter
  use lclass_types 
  !
  integer(kind=4),parameter       :: mmerge=40
  integer(kind=4)                 :: nmerge
  real(kind=4), dimension(mmerge) :: rmerge
  real(kind=4), dimension(mmerge) :: vmerge
  !
end module lclass_merge_structure
!
module lclass_setup
  use class_setup
  use lclass_parameter
  use lclass_types
  ! be careful fresh SIC parameters after any changing
  type(lclass_set_type) :: lclass_set
  !
end module lclass_setup

module lclass_data
  use class_data
  use lclass_setup
end module lclass_data
