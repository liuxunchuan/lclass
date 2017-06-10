module class_interfaces_private
  interface
    subroutine lclass_message_set_id(id)
      use gbl_message
      !---------------------------------------------------------------------
      ! @ private
      ! Alter library id into input id. Should be called by the library
      ! which wants to share its id with the current one.
      !---------------------------------------------------------------------
      integer, intent(in) :: id         !
    end subroutine lclass_message_set_id
  end interface
  !
  interface
    subroutine lclass_message(mkind,procname,message)
      !---------------------------------------------------------------------
      ! @ private
      ! Messaging facility for the current library. Calls the low-level
      ! (internal) messaging routine with its own identifier.
      !---------------------------------------------------------------------
      integer,          intent(in) :: mkind     ! Message kind
      character(len=*), intent(in) :: procname  ! Name of calling procedure
      character(len=*), intent(in) :: message   ! Message string
    end subroutine lclass_message
  end interface
  !
  interface
    subroutine lclass_iostat(mkind,procname,ier)
      use gbl_message
      !---------------------------------------------------------------------
      ! @ private
      ! Output system message corresponding to IO error code IER, and
      ! using the MESSAGE routine
      !---------------------------------------------------------------------
      integer,          intent(in) :: mkind     ! Message severity
      character(len=*), intent(in) :: procname  ! Calling routine name
      integer,          intent(in) :: ier       ! IO error number
    end subroutine lclass_iostat
  end interface
  !
  interface
    subroutine lmethod(line,error)
      use gildas_def
      use gbl_message
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
    end subroutine lmethod
  end interface
  !
  interface
    subroutine raimerge(chain,error)
      use gildas_def
      use gbl_message
      use l_merge_structure
      !-------------------------------------------------------------------
      ! @ private
      ! Read parameters of merge multiplet hyperfine lines
      !-------------------------------------------------------------------
      character(len=*), intent(in)  :: chain
      logical,          intent(out) :: error
    end subroutine raimerge
  end interface
  !
  interface
    subroutine init_lclass(user_function)
      !---------------------------------------------------------------------
      ! @ private
      ! LLAS initialization routine
      !---------------------------------------------------------------------
      external :: user_function         !
    end subroutine init_lclass
  end interface
  !
  interface
    subroutine exit_lclass
      use gbl_message
      !---------------------------------------------------------------------
      ! @ private
      !
      !---------------------------------------------------------------------
    end subroutine exit_lclass
  end interface
  !
  interface
    function lclass_error()
      !---------------------------------------------------------------------
      ! @ private
      ! Support routine for the error status of the library. Does nothing
      ! here.
      !---------------------------------------------------------------------
      logical :: lclass_error  ! Function value on return
    end function lclass_error
  end interface
  !
  interface
    subroutine llas_setdef(error)
      use gildas_def
      use gbl_constant
      use phys_const
      use lclass_setup
      !---------------------------------------------------------------------
      ! @ private
      ! LCLASS Internal routine
      !  Setup default parameters
      !---------------------------------------------------------------------
      logical, intent(out) :: error  ! Error flag
    end subroutine llas_setdef
  end interface
  !
  interface
    subroutine llas_setup
      use gildas_def
      !---------------------------------------------------------------------
      ! @ private
      ! CLASS Setup routine
      !  Called only once at startup
      !---------------------------------------------------------------------
      ! Local
    end subroutine llas_setup
  end interface
  !
  interface
    subroutine lclass_pack_init(gpack_id,error)
      use gbl_message
      use sic_def
      !---------------------------------------------------------------------
      ! @ private
      !---------------------------------------------------------------------
      integer(kind=4), intent(in)    :: gpack_id
      logical,         intent(inout) :: error
    end subroutine lclass_pack_init
  end interface
  !
  interface
    subroutine lclass_pack_clean(error)
      !---------------------------------------------------------------------
      ! @ private
      !---------------------------------------------------------------------
      logical, intent(inout) :: error
    end subroutine lclass_pack_clean
  end interface
  !
  interface
    function lsas_function(action)
      !---------------------------------------------------------------------
      ! @ private
      !---------------------------------------------------------------------
      logical :: lsas_function                 ! intent(out)
      character(len=*), intent(in) :: action  !
    end function lsas_function
  end interface
  !
end module class_interfaces_private
