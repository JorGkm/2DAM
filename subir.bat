@echo off
rem ============================================================
rem  subir.bat - Sube tus cambios a GitHub (Windows, sin bash)
rem
rem  Equivalente a subir.sh para quien no tenga Git Bash.
rem  Doble clic o ejecuta "subir.bat" desde CMD / PowerShell.
rem ============================================================

setlocal enabledelayedexpansion
cd /d "%~dp0"

echo ==============================================
echo            SUBIR CAMBIOS
echo ==============================================
echo.

if not exist ".git" (
    echo [X] Esto no es un repositorio de git.
    echo    Ejecuta este archivo dentro de la carpeta del repo.
    exit /b 1
)

rem --- 1. Preparar todos los cambios ---
git add -A

rem --- 2. Hay archivos modificados? ---
git diff --cached --quiet
if not errorlevel 1 goto :sin_cambios

echo Archivos que se van a subir:
git diff --cached --stat
echo.
echo Como describes este cambio?
echo   (se usara como titulo del commit)
set /p "mensaje=  > "
if "!mensaje!"=="" goto :vacio

echo.
git commit -m "!mensaje!"
if errorlevel 1 goto :error_commit
goto :revisar

:vacio
echo.
echo [X] Cancelado. El mensaje no puede estar vacio.
exit /b 1

:sin_cambios
echo No hay archivos nuevos modificados.

:revisar
rem --- 3. Quedan commits sin subir? ---
echo.
set /a SIN_SUBIR=0
git rev-parse --verify --quiet origin/main >nul 2>&1
if errorlevel 1 goto :rama_nueva

for /f "tokens=1" %%n in ('git rev-list --count origin/main..HEAD 2^>nul') do set /a SIN_SUBIR=%%n
if !SIN_SUBIR!==0 goto :al_dia

:subir
rem --- 4. Subir ---
echo Subiendo a GitHub...
git push
if errorlevel 1 goto :error_push

echo.
echo [OK] Subido correctamente.
exit /b 0

:rama_nueva
echo [i] La rama main aun no existe en GitHub.
echo     Se creara con tu primer commit.
set /a SIN_SUBIR=1
goto :subir

:al_dia
echo [OK] Todo esta al dia. Nada nuevo que subir.
exit /b 0

:error_commit
echo.
echo [X] Error al hacer el commit.
exit /b 1

:error_push
echo.
echo [X] No se pudo subir. Lee el mensaje de arriba.
echo.
echo Si dice "Authentication failed" o pide usuario y contrasena:
echo   - Usuario  : JorGkm
echo   - Contrasena: tu token de GitHub (NO tu contrasena normal)
echo     Crealo en https://github.com/settings/tokens
echo
echo Si dice "Could not resolve host" o "Connection timed out":
echo   - No hay internet. Intentalo luego otra vez.
echo
echo Si dice "fetch first" o "non-fast-forward":
echo   - Ejecuta bajar.bat y despues volver a subir.bat
echo
echo Tus cambios NO se han perdido: siguen en local.
exit /b 1
