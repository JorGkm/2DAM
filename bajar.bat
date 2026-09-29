@echo off
rem ============================================================
rem  bajar.bat - Baja de GitHub los cambios del otro equipo
rem
rem  Equivalente a bajar.sh para quien no tenga Git Bash.
rem  Doble clic o ejecuta "bajar.bat" desde CMD / PowerShell.
rem ============================================================

setlocal enabledelayedexpansion
cd /d "%~dp0"

echo ==============================================
echo            BAJAR CAMBIOS
echo ==============================================
echo.

if not exist ".git" (
    echo [X] Esto no es un repositorio de git.
    echo    Ejecuta este archivo dentro de la carpeta del repo.
    exit /b 1
)

rem --- 1. Guardar el commit actual ---
set "ANTES="
for /f "tokens=1" %%n in ('git rev-parse HEAD 2^>nul') do set "ANTES=%%n"

if "!ANTES!"=="" (
    echo [X] No se pudo leer el estado del repositorio.
    exit /b 1
)

rem --- 2. Conectar con GitHub sin descargar nada ---
git fetch origin
if errorlevel 1 (
    echo.
    echo [X] No se pudo conectar con GitHub.
    echo    Revisa tu conexion a internet.
    exit /b 1
)

rem --- 3. Hay cambios nuevos? ---
set "DESPUES="
for /f "tokens=1" %%n in ('git rev-parse origin/main 2^>nul') do set "DESPUES=%%n"

if "!ANTES!"=="!DESPUES!" (
    echo.
    echo [OK] Ya estas al dia.
    echo     No hay nada nuevo en GitHub.
    exit /b 0
)

set /a NUEVOS=0
for /f "tokens=1" %%n in ('git rev-list --count "!ANTES!..origin/main" 2^>nul') do set /a NUEVOS=%%n

echo.
echo !NUEVOS! cambio(s) nuevo(s) en GitHub:
git log --oneline "!ANTES!..origin/main"
echo.

rem --- 4. Aplicar ---
echo Aplicando cambios...
git merge --ff-only origin/main
if errorlevel 1 (
    echo.
    echo [X] No se pudieron aplicar los cambios.
    echo    Puede haber un conflicto: has modificado un archivo que
    echo    tambien cambio en el otro equipo.
    echo.
    echo    Mira la seccion "Si sale un conflicto" del fichero GIT.md
    exit /b 1
)

echo.
echo [OK] Actualizado.
git status -sb
exit /b 0
