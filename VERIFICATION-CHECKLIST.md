# Lista de Verificación - GastroReview Microservices

## ✅ Cumplimiento de Requisitos de la Rúbrica

### 1. Microservicio GraphQL con Seguridad JWT ✅
- **Servicio**: `reviews-service`
- **Puerto**: 8083
- **Endpoints**:
  - `/graphql` - API GraphQL
  - `/graphiql` - Interfaz GraphiQL
- **Seguridad**: JWT implementada con `JwtAuthenticationFilter` y `JwtTokenProvider`
- **Esquema GraphQL**: `src/main/resources/graphql/schema.graphqls`
- **Archivos clave**:
  - `src/main/java/WebSiters/reviews/security/JwtAuthenticationFilter.java`
  - `src/main/java/WebSiters/reviews/security/JwtTokenProvider.java`
  - `src/main/java/WebSiters/reviews/config/SecurityConfig.java`

### 2. Microservicios REST con Seguridad JWT ✅
#### Users Service
- **Puerto**: 8081
- **Endpoints principales**:
  - `POST /auth/register` - Registro de usuarios
  - `POST /auth/login` - Login (genera JWT)
  - `GET /users` - Listar usuarios (requiere AUTH)
  - `GET /users/{id}` - Obtener usuario (requiere AUTH)
- **Seguridad**: JWT con `JwtAuthenticationFilter`

#### Restaurants Service
- **Puerto**: 8082
- **Endpoints principales**:
  - `GET /restaurants` - Listar restaurantes
  - `POST /restaurants` - Crear restaurante (requiere AUTH)
  - `GET /restaurants/{id}` - Obtener restaurante
  - `PUT /restaurants/{id}` - Actualizar (requiere AUTH)
  - `GET /dishes` - Listar platillos
- **Seguridad**: JWT con `JwtAuthenticationFilter`

### 3. Descubrimiento de Servicios (Eureka) ✅
- **Servicio**: `eureka-server`
- **Puerto**: 8761
- **URL**: http://localhost:8761
- **Dashboard**: Interfaz web de Eureka disponible
- **Servicios registrados**:
  - users-service
  - restaurants-service
  - reviews-service
  - api-gateway

### 4. API Gateway ✅
- **Servicio**: `api-gateway`
- **Puerto**: 9090
- **Rutas configuradas**:
  - `/api/auth/**` → users-service
  - `/api/users/**` → users-service
  - `/api/restaurants/**` → restaurants-service
  - `/api/dishes/**` → restaurants-service
  - `/graphql` → reviews-service
- **Features**:
  - Service Discovery con Eureka
  - Load Balancing automático
  - CORS configurado

### 5. Servicios Cognitivos de Azure (2) ✅
**Implementados en reviews-service:**

#### a) Azure Text Analytics
- **Propósito**: Análisis de sentimiento de reseñas
- **Clase**: `WebSiters.reviews.service.TextAnalyticsService`
- **Uso**: Analiza el texto de las reseñas para determinar si es positivo, negativo o neutral
- **Campos en Review**: `sentiment_score`, `sentiment_label`

#### b) Azure Content Moderator
- **Propósito**: Moderación de contenido inapropiado
- **Clase**: `WebSiters.reviews.service.ContentModerationService`
- **Uso**: Filtra lenguaje ofensivo y contenido inapropiado en reseñas
- **Integración**: Validación antes de guardar reseñas

### 6. Comunicación Entre Microservicios ✅
**Implementado con Feign Client en reviews-service:**

- **UsersClient**: Comunicación con users-service
  - Archivo: `src/main/java/WebSiters/reviews/client/UsersClient.java`
  - Método: `getUserById(UUID id)` - Obtiene información del usuario

- **RestaurantsClient**: Comunicación con restaurants-service
  - Archivo: `src/main/java/WebSiters/reviews/client/RestaurantsClient.java`
  - Método: `getRestaurantById(UUID id)` - Obtiene información del restaurante

## 🗄️ Bases de Datos

### Separación por Dominio ✅
- **users_db**: Usuarios, perfiles, direcciones, notificaciones, alertas
- **restaurants_db**: Restaurantes, platillos, categorías, direcciones
- **reviews_db**: Reseñas, imágenes, favoritos

### Configuración en Neon
Cada microservicio tiene su propia base de datos PostgreSQL en Neon:
- Variables de entorno: `DATABASE_URL`, `DATABASE_USERNAME`, `DATABASE_PASSWORD`
- Hibernate DDL: `update` (crea tablas automáticamente)

## 🏗️ Arquitectura del Proyecto

```
GastroReview-4/
├── eureka-server/          # Service Discovery
├── api-gateway/            # API Gateway
├── users-service/          # Microservicio REST (Users)
├── restaurants-service/    # Microservicio REST (Restaurants)
├── reviews-service/        # Microservicio GraphQL (Reviews)
├── render.yaml             # Configuración de deployment
├── neon-data-users.sql     # Datos de prueba para users_db
├── neon-data-restaurants.sql # Datos de prueba para restaurants_db
└── neon-data-reviews.sql   # Datos de prueba para reviews_db
```

## 🧪 Pruebas Manuales

### 1. Verificar Eureka Server
```bash
# Abrir en navegador
http://localhost:8761
```
Debe mostrar el dashboard con todos los servicios registrados.

### 2. Registrar un Usuario (users-service)
```bash
curl -X POST http://localhost:8081/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "password123",
    "firstName": "Test",
    "lastName": "User"
  }'
```

### 3. Login y Obtener JWT
```bash
curl -X POST http://localhost:8081/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "password123"
  }'
```
Guarda el token JWT retornado.

### 4. Listar Restaurantes (a través del Gateway)
```bash
curl http://localhost:9090/api/restaurants
```

### 5. Crear Restaurante con JWT
```bash
curl -X POST http://localhost:9090/api/restaurants \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer [TU_JWT_TOKEN]" \
  -d '{
    "name": "Mi Restaurante",
    "description": "Descripción del restaurante",
    "priceRange": "$$"
  }'
```

### 6. Query GraphQL (reviews-service)
```bash
curl -X POST http://localhost:9090/graphql \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer [TU_JWT_TOKEN]" \
  -d '{
    "query": "{ reviews { id rating comment user { email } restaurant { name } } }"
  }'
```

### 7. Abrir GraphiQL Interface
```bash
# Abrir en navegador
http://localhost:8083/graphiql
```

## 📊 Datos de Prueba

Los scripts SQL incluyen:
- 5 usuarios (password: `password123`)
- 5 restaurantes en diferentes ciudades
- 10 platillos
- 20 reseñas con análisis de sentimiento
- Relaciones completas entre entidades

**Usuarios de prueba:**
- admin@gastroreview.com (ADMIN)
- juan.perez@email.com (USER)
- maria.garcia@email.com (USER)
- carlos.lopez@email.com (USER - Chef)
- ana.martinez@email.com (USER)

## 🔧 Configuración de Variables de Entorno

### Comunes a todos los servicios:
```bash
EUREKA_CLIENT_SERVICEURL_DEFAULTZONE=http://localhost:8761/eureka/
JWT_SECRET=mySecretKeyForJWTTokenGenerationThatIsAtLeast256BitsLong
```

### Users Service:
```bash
DATABASE_URL=postgresql://[user]:[pass]@[host]/users_db?sslmode=require
DATABASE_USERNAME=[user]
DATABASE_PASSWORD=[password]
```

### Restaurants Service:
```bash
DATABASE_URL=postgresql://[user]:[pass]@[host]/restaurants_db?sslmode=require
DATABASE_USERNAME=[user]
DATABASE_PASSWORD=[password]
```

### Reviews Service:
```bash
DATABASE_URL=postgresql://[user]:[pass]@[host]/reviews_db?sslmode=require
DATABASE_USERNAME=[user]
DATABASE_PASSWORD=[password]
AZURE_TEXT_ANALYTICS_KEY=[your-key]
AZURE_TEXT_ANALYTICS_ENDPOINT=[your-endpoint]
AZURE_CONTENT_MODERATOR_KEY=[your-key]
AZURE_CONTENT_MODERATOR_ENDPOINT=[your-endpoint]
```

## 🚀 Deployment en Render

### Configuración en render.yaml:
- 5 servicios web (todos los microservicios)
- 3 bases de datos PostgreSQL (Neon integrado)
- Variables de entorno configuradas
- Health checks implementados

### Problemas Conocidos:
- Error "no main manifest attribute" en deployment
- **Solución aplicada**:
  - Agregado `<executions>` explícito en todos los pom.xml
  - Comando de build: `mvn clean install -DskipTests`
  - Debugging habilitado en Dockerfiles

## ✅ Checklist Final

- [x] 1 microservicio GraphQL con JWT (reviews-service)
- [x] 2+ microservicios REST con JWT (users-service, restaurants-service)
- [x] Eureka Server funcionando
- [x] API Gateway configurado
- [x] 2 servicios cognitivos Azure (Text Analytics, Content Moderator)
- [x] Comunicación entre microservicios (Feign Clients)
- [x] 3 bases de datos separadas por dominio
- [x] Scripts SQL con datos de prueba
- [x] Documentación completa
- [x] Código en GitHub
- [x] Configuración Render (render.yaml)

## 📝 Notas de Entrega

El proyecto cumple con **TODOS** los requisitos de la rúbrica:
1. ✅ GraphQL con seguridad
2. ✅ Spring Boot microservices con seguridad
3. ✅ Eureka Server
4. ✅ API Gateway
5. ✅ 2 servicios cognitivos
6. ✅ Comunicación entre microservicios

El código funciona localmente y está preparado para deployment en la nube.
