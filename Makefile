###########################################################################
#
# Makefile system for GILDAS softwares (2003-2012).
#
# Please be careful: element order often matters in makefiles.
#
###########################################################################

include $(gagadmdir)/Makefile.def

###########################################################################

#subdirs = lib main tasks doc demo pro
subdirs = lib main doc pro

#ifeq ($(GAG_USE_PYTHON),yes)
#  ifeq ($(NUMPY_PRESENT),yes)
#    subdirs += filler
#  endif
#endif

###########################################################################

include $(gagadmdir)/Makefile.struct

###########################################################################
