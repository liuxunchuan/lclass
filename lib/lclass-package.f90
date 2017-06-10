!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Routines to manage the LCLASS package
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
subroutine lclass_pack_set(pack)
  use gpack_def
  use gkernel_interfaces
  use class_interfaces
  !---------------------------------------------------------------------
  ! @ public
  !---------------------------------------------------------------------
  type(gpack_info_t), intent(out) :: pack
  !
  external :: ephem_pack_set
  external :: lclass_pack_init
  external :: lclass_pack_clean
  !
  pack%name='lclass'
  pack%ext='.lclass'
  pack%depend(1:3) = (/ locwrd(ephem_pack_set), locwrd(greg_pack_set), locwrd(class_pack_set) /)
  pack%init=locwrd(lclass_pack_init)
  pack%clean=locwrd(lclass_pack_clean)
  pack%authors="Liu Xunchuan"
  !
end subroutine lclass_pack_set
!
subroutine lclass_pack_init(gpack_id,error)
  use gbl_message
  use sic_def
  use lclass_dependencies_interfaces
  !---------------------------------------------------------------------
  ! @ private
  !---------------------------------------------------------------------
  integer(kind=4), intent(in)    :: gpack_id
  logical,         intent(inout) :: error
  ! Global
  logical, external :: lsas_function
  ! Local
  character(len=*), parameter :: rname='INIT'
  !
  ! One time initialization
  !call classic_message_set_id(gpack_id)  ! Set library id
  call lclass_message_set_id(gpack_id)  ! Set library id
  !
  ! Allocate buffer memory
  !call allocate_lclass(error)
  !if (error) return
  !
  ! Local language
  call init_lclass(lsas_function)  ! 
  !call load_map(error)
  !if (error) return
  !
  ! Define Functions
  !call cube_functions(error)
  !if (error) return
  !
  !call exec_program('sic'//backslash//'sic priority 1 las 2 analyse fit')
  ! Set defaults
  !call exec_program('las'//backslash//'set default')
  !
  ! Debug information
#if defined(FORTRAN2003_PP) /* Fortran 2003 Procedure Pointers */
  call lclass_message(seve%i,rname,  &
    'Class conversion routines use Fortran 2003 Procedure Pointers')
#else
  call lclass_message(seve%i,rname,  &
    'Class conversion routines do not use Fortran 2003 Procedure Pointers')
#endif
  !
end subroutine lclass_pack_init
!
subroutine lclass_pack_clean(error)
  !---------------------------------------------------------------------
  ! @ private
  !---------------------------------------------------------------------
  logical, intent(inout) :: error
  !
  call exit_lclass
  !
end subroutine lclass_pack_clean
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
function lsas_function(action)
  !---------------------------------------------------------------------
  ! @ private
  !---------------------------------------------------------------------
  logical :: lsas_function                 ! intent(out)
  character(len=*), intent(in) :: action  !
  ! Too much verbose when working with thousands of spectra...
  ! print *,'User function ',action
  lsas_function = .false.
end function lsas_function
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
