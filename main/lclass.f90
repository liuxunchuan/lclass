!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! CLASS as a master
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
program class
  use gkernel_interfaces
  !----------------------------------------------------------------------
  ! Main class program
  !----------------------------------------------------------------------
  external :: lclass_pack_set
  !
  call gmaster_set_prompt('LCS90')
  call gmaster_run(lclass_pack_set)
  !
end program class
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
