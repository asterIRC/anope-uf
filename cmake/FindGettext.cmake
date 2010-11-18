# Find the header files, libs, and executables for gettext
if(NOT WIN32)
  find_path(GETTEXT_INCLUDE libintl.h /usr/include /usr/local/include ${EXTRA_INCLUDE})
  find_library(GETTEXT_LIBRARY intl PATHS /usr/lib /usr/lib64 ${EXTRA_INCLUDE})
  find_program(GETTEXT_MSGFMT msgfmt PATHS /usr/bin/ /usr/local/bin ${EXTRA_INCLUDE})
  if(GETTEXT_INCLUDE AND GETTEXT_MSGFMT)
    set(GETTEXT_FOUND TRUE)
  endif(GETTEXT_INCLUDE AND GETTEXT_MSGFMT)
else(NOT WIN32)
  find_path(GETTEXT_INCLUDE libintl.h ${DEFAULT_INCLUDE_DIRS} ${WSDK_PATH}/include $ENV{VCINSTALLDIR}/include gettext/include ${EXTRA_INCLUDE})
  find_library(GETTEXT_LIBRARY libintl PATHS ${DEFAULT_LIBRARY_DIRS} ${WSDK_PATH}/lib $ENV{VCINSTALLDIR}/lib gettext/lib ${EXTRA_INCLUDE})
  find_library(ICONV_LIBRARY libiconv PATHS ${DEFAULT_LIBRARY_DIRS} ${WSDK_PATH}/lib $ENV{VCINSTALLDIR}/lib gettext/lib ${EXTRA_INCLUDE})
  find_library(MINGWEX_LIBRARY libmingwex PATHS ${DEFAULT_LIBRARY_DIRS} ${WSDK_PATH}/lib $ENV{VCINSTALLDIR}/lib gettext/lib ${EXTRA_INCLUDE})
  find_library(GCC_LIBRARY libgcc PATHS ${DEFAULT_LIBRARY_DIRS} ${WSDK_PATH}/lib $ENV{VCINSTALLDIR}/lib gettext/lib ${EXTRA_INCLUDE})
  find_program(GETTEXT_MSGFMT msgfmt PATHS ${DEFAULT_INCLUDE_DIRS} ${WSDK_PATH}/bin $ENV{VCINSTALLDIR}/bin gettext/bin ${EXTRA_INCLUDE})
  if(GETTEXT_INCLUDE AND GETTEXT_MSGFMT AND ICONV_LIBRARY AND MINGWEX_LIBRARY AND GCC_LIBRARY)
    set(GETTEXT_FOUND TRUE)
  endif(GETTEXT_INCLUDE AND GETTEXT_MSGFMT AND ICONV_LIBRARY AND MINGWEX_LIBRARY AND GCC_LIBRARY)
endif(NOT WIN32)

# If we found everything we need set variables correctly for lang/CMakeLists.txt to use
if(GETTEXT_FOUND)
  set(LIBINTL_INCLUDE "${GETTEXT_INCLUDE}/libintl.h")
  set(GETTEXT_MSGFMT_EXECUTABLE ${GETTEXT_MSGFMT})

  if(WIN32)
    set(GETTEXT_LIBRARIES libiconv libintl libmingwex libgcc)
  else(WIN32)
    if(GETTEXT_LIBRARY)
      set(GETTEXT_LIBRARIES ${GETTEXT_LIBRARY})
    endif(GETTEXT_LIBRARY)
  endif(WIN32)
endif(GETTEXT_FOUND)