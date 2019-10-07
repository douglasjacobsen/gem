# CMAKE_<LANG>_COMPILER variables MUST contain the full path of the compiler for <LANG>
find_program(CMAKE_C_COMPILER gcc)
find_program(CMAKE_Fortran_COMPILER gfortran)

# The full path of the compiler for <LANG> must be set in CMAKE_<LANG>_COMPILER
# before calling enable_language(<LANG>)

# I don't know why, but enable_language exmpties CMAKE_BUILD_TYPE!
# We therefore have to back it up and restore it after enable_language
set(TMP_BUILD_TYPE ${CMAKE_BUILD_TYPE})

# Enable the two languages that are used
enable_language(C)
enable_language(Fortran)

# Reset CMAKE_BUILD_TYPE
set(CMAKE_BUILD_TYPE ${TMP_BUILD_TYPE})

# find_package() commands can only be called after the languages have been 
# eneabled or they will fail

add_definitions(-DLittle_Endian)

# We need the following packages for gcc/gfortran
#find_package(MPI REQUIRED)
# LAPACK requires BLAS so we dont't need an explicit find_package for BLAS
# FindLAPACK does not search for the library in the LD_LIBRARY_PATH
#find_package(LAPACK REQUIRED)

#find_library(LAPACK_LIBRARIES lapack HINTS ENV LD_LIBRARY_PATH)
set(LAPACK_LIBRARIES "lapack")
message(STATUS "LAPACK_LIBRARIES=${LAPACK_LIBRARIES}")


#find_library(BLAS_LIBRARIES blas HINTS ENV LD_LIBRARY_PATH)
set(BLAS_LIBRARIES "blas")
message(STATUS "BLAS_LIBRARIES=${BLAS_LIBRARIES}")

# FIXME: How do we specify compiler specific flags with add_compile_options()?
# gcc gives warnings about some unknown flags that exist only for gfortran

set(CMAKE_C_FLAGS "-march=native -w -Wall -Wextra -fpic")
set(CMAKE_C_FLAGS_DEBUG "-g")
set(CMAKE_C_FLAGS_RELEASE "-O2")

set(CMAKE_Fortran_FLAGS "-march=native -Wall -Wextra -Wno-compare-reals -Wno-conversion -Wno-unused-dummy-argument -Wno-unused-parameter -fbacktrace -fconvert=big-endian -fcray-pointer -fdump-core -ffpe-trap=invalid,zero,overflow -ffree-line-length-none -finit-real=nan -fno-second-underscore -frecord-marker=4")
set(CMAKE_Fortran_FLAGS_DEBUG "-g")
set(CMAKE_Fortran_FLAGS_RELEASE "-O2")