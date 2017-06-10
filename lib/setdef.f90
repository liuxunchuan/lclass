subroutine llas_setdef(error)
  use gildas_def
  use gbl_constant
  use phys_const
  use lclass_interfaces, except_this=>llas_setdef
  use lclass_setup
  !---------------------------------------------------------------------
  ! @ private
  ! LCLASS Internal routine
  !  Setup default parameters
  !---------------------------------------------------------------------
  logical, intent(out) :: error  ! Error flag
  ! Local
  lclass_set%method = ''
  !
  error = .false.
end subroutine llas_setdef
!
subroutine llas_setup
  use gildas_def
  use lclass_interfaces, except_this=>llas_setup
  !---------------------------------------------------------------------
  ! @ private
  ! CLASS Setup routine
  !  Called only once at startup
  !---------------------------------------------------------------------
  ! Local
  logical :: error
  !
  error = .false.
  !
  call llas_setdef(error)
  !
end subroutine llas_setup
