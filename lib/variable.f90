subroutine llas_variables
  use gildas_def
  use gbl_message
  use gkernel_interfaces
  !----------------------------------------------------------------------
  ! @ private
  ! LLAS Initialisation routine
  !  Defines all SIC variables
  !----------------------------------------------------------------------
  logical :: error
  integer(kind=index_length) :: dim(4)
  !
  error = .false.
  dim = 0
  !
  call lclass_set_structure(error)
  if (error) return
  !
end subroutine llas_variables
!
subroutine lclass_set_structure(error)
  use gildas_def
  use gbl_message
  use gkernel_interfaces
  use lclass_setup
  !---------------------------------------------------------------------
  ! @ private
  ! LLAS internal routine
  !   Define the SIC variables which map the internal set% values.
  !---------------------------------------------------------------------
  logical, intent(inout) :: error  ! Logical error flag
  ! Local
  character(len=*), parameter :: struct='SET%LLAS'
  integer(kind=index_length) :: dims(4)
  !
  dims = 0
  !
  call sic_defstructure(struct,.true.,error)
  if (error) return
  !
  ! Character strings (scalar)
  call sic_def_char(struct//'%METHOD', lclass_set%method, .true.,error)
  if (error) return
  !
end subroutine lclass_set_structure
!
