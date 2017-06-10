subroutine lrun(line,error,user_function)
  use gildas_def
  use gbl_message
  use gkernel_interfaces
  use lclass_interfaces, except_this=>lrun
  use lclass_data
  use lclass_merge_structure
  !--------------------------
  ! @ private
  !--------------------------
  character(len=*), intent(in)   :: line
  logical,intent(out)            :: error
  logical,external               :: user_function
  ! Local
  type(extract_t)                :: extr
  type(observation)              :: obs
  real(kind=4)                   :: xc1,xc2,xv,xf,xi,ya,xo,yo
  character(len=1)               :: ch
  integer(kind=4)                :: lunit
  character(len=*),parameter     :: rname = 'LRUN'
  character(len=message_length)  :: mess
  !
  extr%rname = rname
  !
  if(lclass_set%method.eq.'MERGE') then
    if(sic_present(0,1)) then
      !get range form command line
      call sic_r8(line,0,1,extr%xa,.true.,error)
      if(error) return
      call sic_r8(line,0,2,extr%xb,.true.,error)
      if(error) return
      extr%unit = set%unitx(1)
      call sic_ke(line,0,3,extr%unit,lunit,.false.,error)
      if(error) return
    else
      !get range from cursor
      call lclass_message(seve%i,rname,'select range with cursor')
      call getcur(xc1,xv,xf,xi,ya,xo,yo,ch)
      call getcur(xc2,xv,xf,xi,ya,xo,yo,ch)
      extr%xa = xc1
      extr%xb = xc2
      extr%unit = 'C'
    endif
    ! check R
    if(r%head%xnum.eq.0) then
      call lclass_message(seve%e,rname,'No spectrum in memery')
      error = .true.
      return
    else if(r%head%presec(class_sec_xcoo_id)) then
      call lclass_message(seve%e,rname,'Irregularly data not supported')
      error = .true.
      return
    end if
    !
    ! represent extr in 'C'(channel)
    call do_extract_units(r,extr,error)
    if(error) return
    if(extr%nc.lt.10) then
      ! Warn if 10 or less channels choosen
      write(mess,'(A,I0,A)')  'Only ',extr%nc,' channels extracted'
      call lclass_message(seve%w, extr%rname, mess)
    end if
    !
    !Copy R into T buffer
    call copyrt(user_function,'FREE')
    !
    call do_merge(r,extr,error)
    if(error) return
    !
    call newdat(r,error)
    if(error) return
  else
    call lclass_message(seve%e, 'MERGE', 'method '//lclass_set%method//'not supported')
    error = .TRUE.
    return 
  endif
end subroutine lrun

subroutine do_merge(obs,extr,error)
   use gbl_constant
   use gbl_message
   use gkernel_interfaces
   use lclass_interfaces, except_this=>do_merge
   use lclass_types
   use lclass_merge_structure
  !---------------------------------------------------------------------
  ! @ private
  ! Sum over hyperfine liens
  ! Must have been set before:
  ! - extr%rname
  ! - extr%c1
  ! - extr%c2
  ! - extr%nc
  !  For efficiency purpose, assume that extr%c1 and extr%c2 are already
  !  sorted.
  !---------------------------------------------------------------------
  type(observation), intent(inout)    :: obs   ! observation
  type(extract_t), intent(in)         :: extr  ! extraction descriptor
  logical, intent(inout)              :: error ! logical error flag
  ! Local
  integer(kind=4) :: new_ichan,old_nchan,old_ichan,ier
  integer(kind=4) :: icenter, ichannels(mmerge), i,j, itemp
  real(kind=4)    :: minvelo, temp
  real(kind=4):: bad
  real(kind=4), allocatable :: yvalue(:)
  !
  ! sumr = sum( (r1/r_ref)^2, (r2/r_ref)^2, ...)
  ! weight(i) = (ri/r_ref)/sumr 
  real(kind=4) :: sumr, weight(mmerge)
  
  !
  if(obs%head%gen%kind.eq.kind_spec) then
    bad = obs%head%spe%bad
    old_nchan = obs%head%spe%nchan
  else
    call lclass_message(seve%e,extr%rname,"only support for spectra data now")
    error = .true.
    return
  endif

  if(nmerge.le.0) then
    call lclass_message(seve%e,extr%rname,"hfs structure no set yet")
    error = .true.
    return
  else if(nmerge.eq.1) then
    call lclass_message(seve%w, extr%rname,"only one line, just extract")
    call do_extract(obs,extr,error)
    return
  endif

  icenter = 1
  minvelo = abs(vmerge(1))
  do i = 1, nmerge
    ! calculate  channel numbers
    call abscissa_velo2chan_r4(obs%head,vmerge(i) , temp ) ! ichannels(i) )
    if((floor(temp)+0.5).lt.temp) then
      ichannels(i) = floor(temp)+1
    else
      ichannels(i) = floor(temp)
    endif
    if(minvelo.gt.abs(vmerge(i))) then
      icenter = i
      minvelo = abs(vmerge(i))
    endif
  end do
  !
  ! calculate relative channel nums
  itemp = ichannels(icenter)
  ichannels(1:nmerge) =  ichannels(1:nmerge) - itemp
  !
  do i = 1, nmerge
    ! if out range, throw error
    if(extr%c1+ichannels(i).le.0) error = .true.
    if(extr%c2+ichannels(i).gt.old_nchan) error = .true.
    if(error) then
       call lclass_message(seve%e,extr%rname,'extract channels out range')
       return
    end if
  end do
  !allocate if needed
  allocate(yvalue(old_nchan), stat=ier)
  if(failed_allocate(extr%rname,'yvalue',ier,error)) return
  !
  ! Save old data
  yvalue = obs%spectre(1:old_nchan)
  !
  call reallocate_obs(obs, extr%nc, error)
  if(error) goto 10

  sumr = 0.0
  do i = 1, nmerge
    sumr = sumr + (rmerge(i)/rmerge(icenter))**2 
  end do
  do i = 1, nmerge
    weight(i) = rmerge(i)/rmerge(icenter)/sumr
  end do
  !
  write(*,*) extr%c1, extr%c2, icenter, sumr
  write(*,*) vmerge(1:nmerge)
  write(*,*) rmerge(1:nmerge)
  write(*,*) ichannels(1:nmerge)
  write(*,*) weight(1:nmerge)
  !
  ! Do the job
  obs%spectre(1:extr%nc) = 0.0
  do i = 1, nmerge
    do j = 1, extr%nc
      obs%spectre(j) =  obs%spectre(j)+yvalue(extr%c1+j+ichannels(i)-1)*weight(i)
    end do
  end do
  !obs%spectre(1:extr%nc) = yvalue(extr%c1+ichannels(icenter):extr%c2+ichannels(icenter))
  !
  ! update header
  obs%head%spe%nchan = extr%nc
  obs%head%spe%rchan = obs%head%spe%rchan-extr%c1+1.d0
  !
  ! Disable PLOT section. We can also update the Vmin-Vmax values
  ! but we don't want to recompute Ymin/max in order to save time
  obs%head%presec(class_sec_plo_id) = .false.
  !
10 continue
  !
  ! Free memory
  deallocate(yvalue)
  !
end subroutine do_merge
