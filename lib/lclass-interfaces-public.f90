module lclass_interfaces_public
  interface
    subroutine lclass_pack_set(pack)
      use gpack_def
      !---------------------------------------------------------------------
      ! @ public
      !---------------------------------------------------------------------
      type(gpack_info_t), intent(out) :: pack
    end subroutine lclass_pack_set
  end interface
  !
end module lclass_interfaces_public
