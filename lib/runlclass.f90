subroutine run_lsas(line,comm,error)
  use lclass_interfaces
  use lclass_addons
  !---------------------------------------------------------------------
  ! @ no-interface (because of module problems)
  ! Support routine for LAS\ language
  !---------------------------------------------------------------------
  character(len=*), intent(in)  :: line   ! Command line
  character(len=*), intent(in)  :: comm   ! Command name
  logical,          intent(out) :: error  ! Error status
  !
  call sub_lsas(line,comm,error,mem_user(ip_user))
end subroutine run_lsas
!


!
subroutine sub_lsas(line,comm,error,user_function)
  use gbl_constant
  use gbl_message
  use gkernel_interfaces
  use lclass_interfaces
  use lclass_setup
  !----------------------------------------------------------------------
  ! @ no-interface (because of argument type mismatch)
  ! LCLASS Main routine for language LLAS\
  ! Call appropriate subroutine according to COMM
  !----------------------------------------------------------------------
  character(len=*), intent(in)  :: line           ! Command line
  character(len=*), intent(in)  :: comm           ! Command name
  logical,          intent(out) :: error          ! Error status
  logical,          external    :: user_function  !
  ! Local
  character(len=*), parameter :: rname='LLAS'
  integer(kind=4) :: i
  integer(kind=4), save :: icall=0
  !
  if (icall.ne.0) then
     Print *,'Rentrant call to RUN_LLAS ',comm
     read(5,*) i
  endif
  icall = icall+1
  !
  call lclass_message(seve%c,rname,line)
  !
  error = .false.
  !
  if (comm.eq.'LMETHOD') then
     call lmethod(line,error)
  else if (comm.eq.'LRUN') then
     call lrun(line,error,user_function);
  else
     call lclass_message(seve%i,rname,'You are using an undocumented, unsupported feature')
     call lclass_message(seve%i,rname,comm//' not yet implemented')
     print *,line
     print *,comm
     error = .true.
  endif
  icall = icall-1
end subroutine sub_lsas
!

!
function lclass_error()
  !---------------------------------------------------------------------
  ! @ private
  ! Support routine for the error status of the library. Does nothing
  ! here.
  !---------------------------------------------------------------------
  logical :: lclass_error  ! Function value on return
  !
  lclass_error = .false.
  !
end function lclass_error
