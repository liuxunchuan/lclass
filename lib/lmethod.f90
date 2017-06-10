
subroutine lmethod(line,error)
  use gildas_def
  use gbl_message
  use gkernel_interfaces
  use lclass_interfaces, except_this=>lmethod
  use lclass_setup
  use lclass_merge_structure
  !----------------------------------------------------------------------
  ! @ private
  ! ANALYSE Support routine for command
  ! LMETHOD  MERGE filename
  !          ...
  ! Select the method for fitting
  !----------------------------------------------------------------------
  character(len=*), intent(in)  :: line  ! Command line
  logical,          intent(out) :: error ! Error flag
  ! Local
  integer(kind=4), parameter :: nmeth=1
  character(len=10) :: amethod(nmeth),argum
  character(len=80) :: mess
  character(len=filename_length) :: name
  integer(kind=4) :: n,nc
  integer(kind=index_length) :: dims(4)
  ! Data
  data amethod /'MERGE'/
  !
  call sic_ke (line,0,1,argum,nc,.true.,error)
  if (error) return
  call sic_ambigs('METHOD',argum,lclass_set%method,n,amethod,nmeth,error)
  if (error) return
  write(mess,*) 'LMETHOD', lclass_set%method,' selected'
  !

  if (lclass_set%method.eq.'MERGE') then
     if (sic_present(0,2)) then
        call sic_ch (line,0,2,name,nc,.false.,error)
        if (error) return
        write(mess,*) lclass_set%method,' selected: input file ',name(1:nc)
        call raimerge(name,error)
     else
        write(mess,*) lclass_set%method,' selected (no input file)'
        call lclass_message(seve%e, 'METHOD', mess)
        error = .true.
        return
     endif
  else
     !no complain would happen even no method mached!      
  endif
  !
  call sic_delvariable('LMERGE',.false.,error)
  if (error)  error = .false.  ! Not an error if LMERGE% does not exist
  if (nmerge.gt.1) then
    call sic_defstructure('LMERGE',.true.,error)
    call sic_def_inte('LMERGE%N',nmerge,0,0,.true.,error)
    dims(1) = nmerge
    call sic_def_real('LMERGE%VELOCITY',vmerge,1,dims,.true.,error)
    call sic_def_real('LMERGE%RATIO',rmerge,1,dims,.true.,error)
  endif
  !
  call lclass_message(seve%i,'METHOD',mess)
  !
end subroutine lmethod
!

!
subroutine raimerge(chain,error)
  use gildas_def
  use gbl_message
  use gkernel_interfaces
  use lclass_interfaces, except_this=>raimerge
  use lclass_merge_structure
  !-------------------------------------------------------------------
  ! @ private
  ! Read parameters of merge multiplet hyperfine lines
  !-------------------------------------------------------------------
  character(len=*), intent(in)  :: chain
  logical,          intent(out) :: error
  ! Local
  character(len=*), parameter :: proc='METHOD'
  character(len=filename_length) :: name
  integer(kind=4) :: jtmp,n,ier
  !
  ier = sic_getlun(jtmp)
  if (ier.ne.1) then
     call lclass_message(seve%e,proc,'Cannot open MERGE description file')
     call lclass_message(seve%e,proc,'No logical unit left')
     error = .true.
     return
  endif
  call sic_parse_file(chain,' ','.hfs',name)
  ier = sic_open(jtmp,name,'OLD',.true.)
  if (ier.ne.0) then
     call lclass_message(seve%e,proc,'Cannot open HFS file required by MERGE')
     call lclass_iostat(seve%e,proc,ier)
     call sic_frelun(jtmp)
     error = .true.
     return
  endif
  !
  ! Read number of components
  read (jtmp,*,err=99,iostat=ier) n
  if (n.gt.mmerge) then
     call lclass_message(seve%e,proc,'Too many HFS components')
     close (unit=jtmp)
     call sic_frelun(jtmp)
     error = .true.
     return
  endif
  nmerge = n
  do n=1,nmerge
     read(jtmp,*,err=99,iostat=ier) vmerge(n),rmerge(n)
     if (ier.ne.0) goto 99
  enddo
  close(unit=jtmp)
  call sic_frelun(jtmp)
  return
  !
99 close(unit=jtmp)
  call class_message(seve%e,proc,'Error reading HFS description file')
  call class_iostat(seve%e,proc,ier)
  call sic_frelun(jtmp)
  error = .true.
end subroutine raimerge
!
