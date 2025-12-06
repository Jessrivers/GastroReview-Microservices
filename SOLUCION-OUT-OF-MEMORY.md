# Solución: Out of Memory en Railway

## Problema Detectado

El **API Gateway** está mostrando error "Out of memory" en Railway debido a:
- Railway free tier limita cada servicio a **512MB RAM**
- Spring Cloud Gateway + Eureka consume ~400-500MB sin optimización
- 5 microservicios compitiendo por recursos limitados

## Solución Aplicada

He optimizado TODOS los Dockerfiles con configuración JVM específica para Railway:

### Configuración de Memoria por Servicio:

| Servicio | Xms (Min) | Xmx (Max) | Razón |
|----------|-----------|-----------|-------|
| Eureka Server | 96MB | 192MB | Servicio ligero de registro |
| API Gateway | 128MB | 256MB | Ruteo de requests |
| Users Service | 128MB | 256MB | Lógica de negocio + BD |
| Restaurants Service | 128MB | 256MB | Lógica de negocio + BD |
| Reviews Service | 128MB | 256MB | GraphQL + Azure + BD |

### Optimizaciones JVM Aplicadas:

```bash
-Xms128m -Xmx256m          # Memoria heap mínima y máxima
-XX:+UseG1GC                # Garbage Collector G1 (eficiente en memoria)
-XX:MaxGCPauseMillis=100    # Pausas de GC cortas
-XX:+UseStringDeduplication # Reduce duplicación de Strings
```

## Cómo Aplicar la Solución

### Opción 1: Push a GitHub (Recomendado)

Railway detectará automáticamente los cambios y re-deployará:

```bash
git add .
git commit -m "Fix: Optimizar memoria JVM para Railway"
git push origin main
```

Railway iniciará el redeploy automáticamente en ~5-10 minutos.

### Opción 2: Redeploy Manual en Railway

1. Ve a tu proyecto en Railway
2. Para cada servicio:
   - Click en el servicio
   - Click en **"Settings"**
   - Click en **"Redeploy"**
3. Espera 5-10 minutos

### Opción 3: Actualizar Variables de Entorno (Temporal)

Si no puedes hacer redeploy ahora, agrega esta variable en Railway:

```
JAVA_OPTS=-Xms128m -Xmx256m -XX:+UseG1GC
```

1. En Railway Dashboard
2. Click en **API Gateway**
3. Tab **"Variables"**
4. Agregar: `JAVA_OPTS=-Xms128m -Xmx256m -XX:+UseG1GC`
5. Click **"Redeploy"**

## Verificar que Funciona

### 1. Esperar a que termine el deploy

Revisa los logs en Railway:
```
Started ApiGatewayApplication in X.XX seconds
Netty started on port 8080
```

### 2. Verificar memoria

En el dashboard de Railway, el uso de memoria debería estar:
- **API Gateway:** ~150-200MB (antes: 500MB+)
- **Otros servicios:** ~180-220MB cada uno

### 3. Probar los endpoints

```bash
# Desde Postman o curl
curl https://gastroreview-gateway-production.up.railway.app/actuator/health
```

Debería retornar:
```json
{
  "status": "UP"
}
```

## Monitoreo Post-Deploy

### Ver logs en tiempo real:

```bash
# En Railway Dashboard
1. Click en el servicio
2. Tab "Deployments"
3. Click en el deployment activo
4. Ver logs en tiempo real
```

### Métricas a vigilar:

- **Memory Usage:** Debe estar debajo de 300MB
- **CPU Usage:** Normal 5-15%
- **Response Time:** <500ms para requests simples

## Troubleshooting

### Si sigue sin memoria:

1. **Reducir más la memoria máxima:**
   ```dockerfile
   -Xms64m -Xmx128m
   ```

2. **Deshabilitar servicios no críticos temporalmente:**
   - Detén temporalmente Reviews Service si no lo necesitas de inmediato
   - Deja solo: Eureka + Gateway + Users + Restaurants

3. **Upgrade a Railway Pro ($5/mes):**
   - 8GB RAM compartida
   - Sin límite de servicios
   - Mejor para producción

### Si el servicio crashea al iniciar:

Revisa los logs y busca:
```
OutOfMemoryError
or
Killed (OOM)
```

Reduce aún más la memoria:
```dockerfile
-Xms96m -Xmx192m
```

## Alternativa: Migrar a Render.com

Render.com ofrece:
- **512MB RAM** por servicio (gratis)
- Mejor manejo de OOM
- Auto-restart en caso de crash
- PostgreSQL gratuito incluido

Migración rápida:
1. Crear cuenta en Render.com
2. Conectar repositorio GitHub
3. Render detecta Dockerfiles automáticamente
4. Deploy en ~10 minutos

## Prevención Futura

### Para desarrollo local:

Agregar al `application.yml` perfil de desarrollo:
```yaml
---
spring:
  config:
    activate:
      on-profile: dev

# Sin límites de memoria
```

### Para producción:

Siempre definir límites de memoria en Dockerfile:
```dockerfile
ENTRYPOINT ["java", "-Xms128m", "-Xmx256m", "-jar", "app.jar"]
```

## Archivos Modificados

✅ Todos los Dockerfiles han sido optimizados:
- [eureka-server/Dockerfile](eureka-server/Dockerfile) - Max 192MB
- [api-gateway/Dockerfile](api-gateway/Dockerfile) - Max 256MB
- [users-service/Dockerfile](users-service/Dockerfile) - Max 256MB
- [restaurants-service/Dockerfile](restaurants-service/Dockerfile) - Max 256MB
- [reviews-service/Dockerfile](reviews-service/Dockerfile) - Max 256MB

## Próximos Pasos

1. ✅ **Push a GitHub** para aplicar los cambios
2. ⏳ **Esperar redeploy** (5-10 minutos)
3. ✅ **Verificar** que no hay más errores de memoria
4. ✅ **Probar** todos los endpoints en Postman
5. ✅ **Monitorear** uso de memoria por 24 horas

---

**Nota:** Estos cambios ya están hechos en tu código local. Solo necesitas hacer `git push` para que Railway los aplique.
