# Configuración de Bases de Datos en Neon

Este documento explica cómo configurar y poblar las bases de datos de GastroReview en Neon PostgreSQL.

## 📋 Requisitos Previos

1. Cuenta en [Neon](https://neon.tech)
2. Tres bases de datos creadas:
   - `users_db`
   - `restaurants_db`
   - `reviews_db`

## 🗄️ Bases de Datos

### users_db
Contiene información de usuarios, perfiles, direcciones, notificaciones y alertas.

**Tablas principales:**
- `users` - Usuarios del sistema
- `user_profile` - Perfiles de usuario
- `address` - Direcciones
- `user_addresses` - Relación usuarios-direcciones
- `notifications` - Notificaciones
- `alerts` - Alertas del sistema

### restaurants_db
Contiene información de restaurantes, categorías y platillos.

**Tablas principales:**
- `restaurants` - Restaurantes
- `address` - Direcciones de restaurantes
- `restaurant_categories` - Categorías por restaurante
- `dishes` - Platillos del menú

### reviews_db
Contiene reseñas, imágenes de reseñas y restaurantes favoritos.

**Tablas principales:**
- `reviews` - Reseñas de usuarios
- `review_images` - Imágenes adjuntas a reseñas
- `favorite_restaurants` - Restaurantes favoritos por usuario

## 🚀 Instalación de Datos

### Opción 1: Desde la Consola Web de Neon

1. Accede a tu proyecto en [Neon Console](https://console.neon.tech)
2. Selecciona la base de datos correspondiente
3. Ve a la pestaña "SQL Editor"
4. Copia y pega el contenido del script correspondiente
5. Ejecuta el script

**Orden de ejecución:**
1. `neon-data-users.sql` en la BD `users_db`
2. `neon-data-restaurants.sql` en la BD `restaurants_db`
3. `neon-data-reviews.sql` en la BD `reviews_db`

### Opción 2: Desde Terminal con psql

```bash
# Conectar a users_db y ejecutar script
psql "postgresql://[user]:[password]@[host]/users_db?sslmode=require" < neon-data-users.sql

# Conectar a restaurants_db y ejecutar script
psql "postgresql://[user]:[password]@[host]/restaurants_db?sslmode=require" < neon-data-restaurants.sql

# Conectar a reviews_db y ejecutar script
psql "postgresql://[user]:[password]@[host]/reviews_db?sslmode=require" < neon-data-reviews.sql
```

Reemplaza `[user]`, `[password]` y `[host]` con tus credenciales de Neon.

## 📊 Datos de Prueba Incluidos

### Usuarios (5 usuarios)
- **Admin**: admin@gastroreview.com
- **Juan Pérez**: juan.perez@email.com
- **María García**: maria.garcia@email.com (Food blogger)
- **Carlos López**: carlos.lopez@email.com (Chef profesional)
- **Ana Martínez**: ana.martinez@email.com

**Contraseña para todos:** `password123`

### Restaurantes (5 restaurantes)

1. **La Casa de Toño** (CDMX)
   - Comida tradicional mexicana
   - Especialidad: Pozole
   - Precio: $$

2. **El Mural de los Poblanos** (Puebla)
   - Cocina poblana contemporánea
   - Especialidad: Chiles en nogada, Mole
   - Precio: $$$

3. **Birriería Chololo** (Guadalajara)
   - Birria tradicional jalisciense
   - Especialidad: Birria de res, Tacos de birria
   - Precio: $

4. **Pangea** (Monterrey)
   - Alta cocina internacional
   - Especialidad: Rib Eye, Tataki de atún
   - Precio: $$$$

5. **Hacienda Teya** (Mérida)
   - Cocina yucateca auténtica
   - Especialidad: Cochinita pibil, Papadzules
   - Precio: $$

### Reseñas (20 reseñas)
- Distribución de calificaciones: mayoría 4-5 estrellas
- Análisis de sentimiento incluido
- Algunas con imágenes adjuntas
- Variedad de comentarios realistas

### Platillos (10 platillos)
- 2 platillos por restaurante
- Precios realistas
- Descripciones detalladas
- Categorías asignadas

## 🔑 UUIDs de Referencia

Los scripts usan UUIDs consistentes para mantener las relaciones entre bases de datos:

**Usuarios:**
- Admin: `550e8400-e29b-41d4-a716-446655440001`
- Juan: `550e8400-e29b-41d4-a716-446655440002`
- María: `550e8400-e29b-41d4-a716-446655440003`
- Carlos: `550e8400-e29b-41d4-a716-446655440004`
- Ana: `550e8400-e29b-41d4-a716-446655440005`

**Restaurantes:**
- La Casa de Toño: `650e8400-e29b-41d4-a716-446655440001`
- El Mural: `650e8400-e29b-41d4-a716-446655440002`
- Birriería Chololo: `650e8400-e29b-41d4-a716-446655440003`
- Pangea: `650e8400-e29b-41d4-a716-446655440004`
- Hacienda Teya: `650e8400-e29b-41d4-a716-446655440005`

## 🧪 Verificación

Después de ejecutar los scripts, verifica la instalación:

```sql
-- En users_db
SELECT COUNT(*) FROM users; -- Debe retornar 5
SELECT COUNT(*) FROM user_profile; -- Debe retornar 5

-- En restaurants_db
SELECT COUNT(*) FROM restaurants; -- Debe retornar 5
SELECT COUNT(*) FROM dishes; -- Debe retornar 10

-- En reviews_db
SELECT COUNT(*) FROM reviews; -- Debe retornar 20
SELECT COUNT(*) FROM favorite_restaurants; -- Debe retornar 10
```

## 🔄 Limpiar Datos

Si necesitas limpiar las bases de datos, descomenta las líneas `TRUNCATE` al inicio de cada script:

```sql
-- Ejemplo en users_db
TRUNCATE TABLE user_addresses, user_profile, notifications, alerts, users RESTART IDENTITY CASCADE;
```

**⚠️ ADVERTENCIA:** Esto eliminará TODOS los datos de las tablas.

## 📝 Notas

1. Los scripts usan `ON CONFLICT DO NOTHING` para evitar duplicados
2. Las contraseñas están hasheadas con BCrypt
3. Los datos incluyen timestamps realistas
4. Las relaciones entre tablas están correctamente configuradas
5. Se incluyen índices automáticos en las claves primarias y foráneas

## 🛠️ Configuración en Variables de Entorno

Una vez que tengas las bases de datos pobladas en Neon, configura las variables de entorno:

```bash
# Para cada microservicio
DATABASE_URL=postgresql://[user]:[password]@[host]/[database]?sslmode=require
DATABASE_USERNAME=[user]
DATABASE_PASSWORD=[password]
```

## 📞 Soporte

Si encuentras algún problema con los scripts:
1. Verifica que las tablas existan (Spring Boot las crea automáticamente con `ddl-auto: update`)
2. Revisa los logs de errores en la consola de Neon
3. Asegúrate de tener los permisos necesarios en las bases de datos
