###########################################################################
#
# Makefile system for GILDAS softwares (2003-2012).
#
# Please be careful: element order often matters in makefiles.
#
###########################################################################

include $(gagadmdir)/Makefile.def

###########################################################################

LIB_IDENTITY = lclass

IMPORT_FROM_PYTHON = 

### Class Data Format and Class support files. Use the Generic Data
### (elements above) API.

LIB_M_OBJECTS = luse_parameter.o luse_data.o	\
lclass-interfaces-private.o			\
lclass-interfaces-public.o lclass-interfaces.o

LIB_C_OBJECTS = 

LIB_F_OBJECTS = lclass-message.o loadlsas.o runlclass.o \
setdef.o variable.o lclass-package.o lmethod.o  lrun.o 

#ifeq ($(GAG_USE_PYTHON),yes)
#  LIB_C_OBJECTS += class-pyimport.o
#endif


### All files

# class_calibr.mod: codes needed in libclassfiller.
# class_consistency.mod: used in 'class_types.mod', type(optimize)
# class_data.mod: Mira 'writeclass' uses buffer R (obsolescent)
# class_index.mod: used in 'class_data.mod'
# class_interfaces_private.mod: used by 'class_interfaces.mod' which is public
LIB_EXPORTS = luse_parameter.f90  	\
lclass_interfaces_public.mod		\
lclass_interfaces_private.mod lclass_interfaces.mod	\
lclass_types.mod lclass_user_interfaces.mod lclass_api.mod

LIB_DEPENDS = -lclassic $(ASTRO_LIBS) $(GREG_LIBS)

###########################################################################

include $(gagadmdir)/Makefile.lib

###########################################################################
# DO NOT DELETE

$(libdir)/liblclass.a(lclass-sicimport.o): $(execincdir)/sic/gpackage-sicimport.h $(execincdir)/gsys/cfc.h
#$(libdir)/liblclass.a(lclass-pyimport.o): $(execincdir)/sic/gpackage-pyimport.h $(execincdir)/gsys/cfc.h

###########################################################################
