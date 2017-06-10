module lclass_addons
  use gildas_def
  integer(kind=1), save :: mem_user(8)
  integer(kind=address_length), save :: addr_user
  integer(kind=address_length), save :: ip_user
end module lclass_addons
!
subroutine init_lclass(user_function)
  use gkernel_interfaces
  use gbl_message
  use lclass_interfaces, except_this=>init_lclass
  use lclass_addons
  !---------------------------------------------------------------------
  ! @ private
  ! LLAS initialization routine
  !---------------------------------------------------------------------
  external :: user_function         !
  ! Local
  integer, parameter :: mllas=2  ! LAS          language
  character(len=12) :: vocab_llas(mllas)
  character(len=20) :: version
  external :: run_lsas
  ! Data
  data vocab_llas /  &
       ' LMETHOD',  &
       ' LRUN'   /

  !
  ! Code
  version = '6.0 31-5-2017'
  call sic_begin('LLAS','GAG_HELP_LLAS',mllas,vocab_llas,   &
                 version//'  PHB - SG - JP - RL', run_lsas, lclass_error)

  call llas_setup
  call llas_variables
  !
  addr_user = locwrd(user_function)
  !identify by memory address
  ip_user = bytpnt(addr_user,mem_user)
end subroutine init_lclass
!
subroutine exit_lclass
  use gbl_message
  !---------------------------------------------------------------------
  ! @ private
  !
  !---------------------------------------------------------------------
  character(len=*), parameter :: rname='EXIT_LCLASS'
  ! Local
  logical :: error
  !
  error = .false.
  !
  ! LClass buffers
  !call deallocate_lclass(error)
  !
  ! Free MEMORY buffers
  !call memorize_free_all
  !
  !call lclass_files_close(error)
  ! if (error)  continue
  !call lclass_luns_free(error)
  ! if (error)  continue
  !
  !call lclass_toc_clean(error)
  ! if (error)  continue
  !
end subroutine exit_lclass
