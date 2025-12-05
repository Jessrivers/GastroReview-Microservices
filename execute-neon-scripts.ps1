# Script PowerShell para ejecutar los datos de prueba en Neon PostgreSQL
# Uso: .\execute-neon-scripts.ps1 -NeonUser "usuario" -NeonPassword "password" -NeonHost "host.neon.tech"

param(
    [Parameter(Mandatory=$true)]
    [string]$NeonUser,

    [Parameter(Mandatory=$true)]
    [string]$NeonPassword,

    [Parameter(Mandatory=$true)]
    [string]$NeonHost,

    [int]$NeonPort = 5432
)

Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Ejecutar Scripts SQL en Neon PostgreSQL" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Verificar que psql esté instalado
$psqlPath = Get-Command psql -ErrorAction SilentlyContinue
if (-not $psqlPath) {
    Write-Host "ERROR: psql no está instalado o no está en el PATH" -ForegroundColor Red
    Write-Host ""
    Write-Host "Opciones:" -ForegroundColor Yellow
    Write-Host "1. Instalar PostgreSQL: https://www.postgresql.org/download/windows/" -ForegroundColor Yellow
    Write-Host "2. Usar la consola web de Neon: https://console.neon.tech" -ForegroundColor Yellow
    exit 1
}

Write-Host "psql encontrado en: $($psqlPath.Source)" -ForegroundColor Green
Write-Host ""

# Función para ejecutar script SQL
function Execute-SQLScript {
    param(
        [string]$Database,
        [string]$ScriptFile
    )

    Write-Host "[*] Ejecutando script para $Database..." -ForegroundColor Yellow

    if (-not (Test-Path $ScriptFile)) {
        Write-Host "    ERROR: No se encuentra el archivo $ScriptFile" -ForegroundColor Red
        return $false
    }

    $connectionString = "postgresql://${NeonUser}:${NeonPassword}@${NeonHost}:${NeonPort}/${Database}?sslmode=require"

    try {
        $result = & psql $connectionString -f $ScriptFile 2>&1

        if ($LASTEXITCODE -eq 0) {
            Write-Host "    OK - $Database poblada correctamente" -ForegroundColor Green
            return $true
        } else {
            Write-Host "    ERROR: Fallo al ejecutar script" -ForegroundColor Red
            Write-Host "    $result" -ForegroundColor Red
            return $false
        }
    } catch {
        Write-Host "    ERROR: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Ejecutar scripts
$success = $true

Write-Host "[1/3] users_db" -ForegroundColor Cyan
if (-not (Execute-SQLScript -Database "users_db" -ScriptFile "neon-data-users.sql")) {
    $success = $false
}
Write-Host ""

Write-Host "[2/3] restaurants_db" -ForegroundColor Cyan
if (-not (Execute-SQLScript -Database "restaurants_db" -ScriptFile "neon-data-restaurants.sql")) {
    $success = $false
}
Write-Host ""

Write-Host "[3/3] reviews_db" -ForegroundColor Cyan
if (-not (Execute-SQLScript -Database "reviews_db" -ScriptFile "neon-data-reviews.sql")) {
    $success = $false
}
Write-Host ""

# Resumen
Write-Host "============================================" -ForegroundColor Cyan
if ($success) {
    Write-Host " COMPLETADO - Todas las bases de datos pobladas" -ForegroundColor Green
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Datos insertados:" -ForegroundColor Green
    Write-Host "  - 5 usuarios (password: password123)" -ForegroundColor White
    Write-Host "  - 5 restaurantes" -ForegroundColor White
    Write-Host "  - 10 platillos" -ForegroundColor White
    Write-Host "  - 20 reseñas" -ForegroundColor White
    Write-Host ""
    Write-Host "Usuarios de prueba:" -ForegroundColor Yellow
    Write-Host "  - admin@gastroreview.com (ADMIN)" -ForegroundColor White
    Write-Host "  - juan.perez@email.com (USER)" -ForegroundColor White
    Write-Host "  - maria.garcia@email.com (USER)" -ForegroundColor White
    Write-Host "  - carlos.lopez@email.com (USER)" -ForegroundColor White
    Write-Host "  - ana.martinez@email.com (USER)" -ForegroundColor White
} else {
    Write-Host " ERROR - Hubo problemas al ejecutar los scripts" -ForegroundColor Red
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Recomendación: Usa la consola web de Neon" -ForegroundColor Yellow
    Write-Host "https://console.neon.tech" -ForegroundColor Cyan
}
Write-Host ""
