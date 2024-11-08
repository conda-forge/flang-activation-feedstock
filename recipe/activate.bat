set "CONDA_BACKUP_FC=%FC%"
set "CONDA_BACKUP_FFLAGS=%FFLAGS%"
set "CONDA_BACKUP_LD=%LD%"
set "CONDA_BACKUP_LDFLAGS=%LDFLAGS%"
set "CONDA_BACKUP_AR=%AR%"

:: flang 19 still uses "temporary" name
set "FC=flang-new"
set "LD=lld-link.exe"
set "AR=llvm-ar.exe"

:: following https://github.com/conda-forge/clang-win-activation-feedstock/blob/main/recipe/activate-clang_win-64.bat
set "FFLAGS=-D_CRT_SECURE_NO_WARNINGS -fms-runtime-lib=dll -fuse-ld=lld"
set "LDFLAGS=%LDFLAGS% -Wl,-defaultlib:%CONDA_PREFIX:\=/%/lib/clang/@MAJOR_VER@/lib/windows/clang_rt.builtins-x86_64.lib"

:: need to distinguish how we populate `-I` based on whether we're using conda build or not;
:: if not, we want CONDA_PREFIX, but if yes, then that points to the build environment
if not "%CONDA_BUILD%" == "" (
    set "FFLAGS=%FFLAGS" -I%LIBRARY_INC%"
) else (
    set "FFLAGS=%FFLAGS" -I%CONDA_PREFIX%\Library\include"
)
