@echo off
REM Script para ejecutar los datos de prueba en Neon
REM Reemplaza las variables con tus credenciales de Neon

echo ============================================
echo  Ejecutar Scripts SQL en Neon PostgreSQL
echo ============================================
echo.

REM Configura estas variables con tus credenciales de Neon
set NEON_USER=tu_usuario
set NEON_PASSWORD=tu_password
set NEON_HOST=tu_host.neon.tech
set NEON_PORT=5432

echo IMPORTANTE: Antes de ejecutar este script:
echo 1. Edita este archivo y reemplaza las credenciales de Neon
echo 2. Asegurate de tener psql instalado
echo.
pause

echo.
echo [1/3] Ejecutando script para users_db...
psql "postgresql://%NEON_USER%:%NEON_PASSWORD%@%NEON_HOST%:%NEON_PORT%/users_db?sslmode=require" -f neon-data-users.sql
if %errorlevel% neq 0 (
    echo ERROR: Fallo al ejecutar script de users_db
    pause
    exit /b 1
)
echo OK - users_db poblada

echo.
echo [2/3] Ejecutando script para restaurants_db...
psql "postgresql://%NEON_USER%:%NEON_PASSWORD%@%NEON_HOST%:%NEON_PORT%/restaurants_db?sslmode=require" -f neon-data-restaurants.sql
if %errorlevel% neq 0 (
    echo ERROR: Fallo al ejecutar script de restaurants_db
    pause
    exit /b 1
)
echo OK - restaurants_db poblada

echo.
echo [3/3] Ejecutando script para reviews_db...
psql "postgresql://%NEON_USER%:%NEON_PASSWORD%@%NEON_HOST%:%NEON_PORT%/reviews_db?sslmode=require" -f neon-data-reviews.sql
if %errorlevel% neq 0 (
    echo ERROR: Fallo al ejecutar script de reviews_db
    pause
    exit /b 1
)
echo OK - reviews_db poblada

echo.
echo ============================================
echo  COMPLETADO - Todas las bases de datos pobladas
echo ============================================
echo.
echo Datos insertados:
echo - 5 usuarios (password: password123)
echo - 5 restaurantes
echo - 10 platillos
echo - 20 resenas
echo.
pause
