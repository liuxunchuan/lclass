!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Routines to manage LCLASS messages
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
module lclass_message_private
  use gpack_def
  !
  ! Identifier used for message identification
  integer :: lclass_message_id = gpack_global_id  ! Default value for startup message
  !
end module lclass_message_private
!
subroutine lclass_message_set_id(id)
  use lclass_message_private
  use gbl_message
  !---------------------------------------------------------------------
  ! @ private
  ! Alter library id into input id. Should be called by the library
  ! which wants to share its id with the current one.
  !---------------------------------------------------------------------
  integer, intent(in) :: id         !
  ! Local
  character(len=message_length) :: mess
  !
  lclass_message_id = id
  !
  write (mess,'(A,I3)') 'Now use id #',lclass_message_id
  call lclass_message(seve%d,'lclass_message_set_id',mess)
  !
end subroutine lclass_message_set_id
!
subroutine lclass_message(mkind,procname,message)
  use gkernel_interfaces
  use lclass_message_private
  !---------------------------------------------------------------------
  ! @ private
  ! Messaging facility for the current library. Calls the low-level
  ! (internal) messaging routine with its own identifier.
  !---------------------------------------------------------------------
  integer,          intent(in) :: mkind     ! Message kind
  character(len=*), intent(in) :: procname  ! Name of calling procedure
  character(len=*), intent(in) :: message   ! Message string
  !
  call gmessage_write(lclass_message_id,mkind,procname,message)
  !
end subroutine lclass_message
!
subroutine lclass_iostat(mkind,procname,ier)
  use gkernel_interfaces
  use gbl_message
  !---------------------------------------------------------------------
  ! @ private
  ! Output system message corresponding to IO error code IER, and
  ! using the MESSAGE routine
  !---------------------------------------------------------------------
  integer,          intent(in) :: mkind     ! Message severity
  character(len=*), intent(in) :: procname  ! Calling routine name
  integer,          intent(in) :: ier       ! IO error number
  ! Local
  character(len=message_length) :: msg
  !
  if (ier.eq.0) return
  call gag_iostat(msg,ier)
  call lclass_message(mkind,procname,msg)
  !
end subroutine lclass_iostat
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
