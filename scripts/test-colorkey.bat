@echo off
REM ============================================================
REM test-colorkey.bat
REM Aplica colorkey negro a un MP4 de HeyGen para validar
REM que el avatar se recorta limpio sobre el fondo negro nativo.
REM
REM Uso:
REM   1) Doble click          -> usa tmp\test.mp4
REM   2) Arrastrar MP4 encima -> usa el archivo arrastrado
REM   3) test-colorkey.bat ruta\al\archivo.mp4
REM
REM Salida: tmp\avatar-recortado.mov (con canal alpha)
REM ============================================================

setlocal EnableDelayedExpansion

cd /d "%~dp0\.."
if not exist "tmp" mkdir tmp

REM --- Resolver archivo de entrada ---
set "INPUT=%~1"
if "%INPUT%"=="" set "INPUT=tmp\test.mp4"

if not exist "%INPUT%" (
  echo.
  echo [ERROR] No encuentro el archivo: %INPUT%
  echo.
  echo Opciones:
  echo   - Coloca el MP4 de HeyGen en  tmp\test.mp4  y vuelve a ejecutar
  echo   - O arrastra el MP4 encima de este .bat
  echo.
  pause
  exit /b 1
)

REM --- Verificar que ffmpeg esta en el PATH ---
where ffmpeg >nul 2>&1
if errorlevel 1 (
  echo.
  echo [ERROR] ffmpeg no esta en el PATH del sistema.
  echo.
  echo Instala ffmpeg o anade su carpeta a la variable PATH.
  echo Si lo tienes en otra ruta, edita la linea SET FFMPEG=... abajo.
  echo.
  pause
  exit /b 1
)

set "OUTPUT=tmp\avatar-recortado.mov"

echo.
echo ============================================================
echo  Aplicando colorkey negro al MP4 de HeyGen
echo ============================================================
echo  Entrada : %INPUT%
echo  Salida  : %OUTPUT%
echo  Filtro  : colorkey=0x000000:0.30:0.10
echo ============================================================
echo.

REM --- Ejecutar ffmpeg ---
REM   colorkey=color:similarity:blend
REM     similarity 0.3  -> tolera grises oscuros sin morder cabello
REM     blend      0.1  -> bordes suaves
REM   format=yuva420p   -> asegura canal alpha en el output
REM   c:v qtrle         -> codec QuickTime RLE, soporta transparencia
REM   c:a copy          -> audio sin recodificar

ffmpeg -y -i "%INPUT%" -vf "colorkey=0x000000:0.30:0.10,format=yuva420p" -c:v qtrle -c:a copy "%OUTPUT%"

if errorlevel 1 (
  echo.
  echo [ERROR] FFmpeg fallo. Mira el log de arriba.
  pause
  exit /b 1
)

echo.
echo ============================================================
echo  OK -- archivo recortado guardado en:
echo     %CD%\%OUTPUT%
echo.
echo  Abrelo con VLC o QuickTime para ver el avatar
echo  con fondo transparente. Si los bordes salen sucios o
echo  el cabello desaparece, ajusta los parametros del filtro:
echo.
echo    similarity (0.30): mas alto = recorta mas, riesgo cabello
echo    blend      (0.10): mas alto = bordes mas suaves
echo ============================================================
echo.
pause
