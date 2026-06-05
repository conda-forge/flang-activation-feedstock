set "CONDA_BACKUP_FC=%FC%"
set "CONDA_BACKUP_FFLAGS=%FFLAGS%"
set "CONDA_BACKUP_FC_LD=%FC_LD%"
set "CONDA_BACKUP_LDFLAGS=%LDFLAGS%"
set "CONDA_BACKUP_AR=%AR%"

set "FC=flang.exe"
set "FC_LD=lld-link.exe"
set "AR=llvm-ar.exe"

:: following https://github.com/conda-forge/clang-win-activation-feedstock/blob/main/recipe/activate-clang_win-64.bat
set "FFLAGS=-D_CRT_SECURE_NO_WARNINGS -fms-runtime-lib=dll -fuse-ld=lld"
set "LDFLAGS=%LDFLAGS% -Wl,-defaultlib:%CONDA_PREFIX:\=/%/lib/clang/@MAJOR_VER@/lib/windows/clang_rt.builtins-x86_64.lib"

:: need to distinguish how we populate `-I` based on whether we're using conda build or not;
:: if building packages, we want %PREFIX% (==host env.), otherwise %CONDA_PREFIX% (i.e. the
:: regular user env; when CONDA_BUILD is set however, it correspond to the build env.).
:: To avoid mixing forward slashes and backslashes, we normalize to `/`; for that purpose,
:: avoid using nested env. vars like `LIBRARY_INC` := `%PREFIX%\Library\include`.
if not "%CONDA_BUILD%" == "" (
    set "FFLAGS=%FFLAGS% -I%PREFIX:\=/%/Library/include"
) else (
    set "FFLAGS=%FFLAGS% -I%CONDA_PREFIX:\=/%/Library/include"
)
