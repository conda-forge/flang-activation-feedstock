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
:: LIBRARY_INC is not available if not, but we cannot use CONDA_PREFIX unconditionally either,
:: as that points to the wrong environment (build instead of host) when using conda-build.
if not "%CONDA_BUILD%" == "" (
    set "FFLAGS=%FFLAGS" -I%LIBRARY_INC%"
) else (
    set "FFLAGS=%FFLAGS" -I%CONDA_PREFIX%\Library\include"
)
