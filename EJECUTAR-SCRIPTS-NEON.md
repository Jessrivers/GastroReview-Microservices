# 🚀 Cómo Ejecutar los Scripts en Neon (Paso a Paso)

## ⚡ MÉTODO RÁPIDO - Consola Web de Neon (Recomendado)

Este es el método más fácil y no requiere instalar nada.

### Paso 1: Acceder a Neon Console

1. Abre tu navegador
2. Ve a: **https://console.neon.tech**
3. Inicia sesión con tu cuenta

### Paso 2: Ejecutar Script para users_db

1. En el panel izquierdo, selecciona tu **proyecto**
2. Selecciona la base de datos **users_db**
3. Click en la pestaña **SQL Editor** (arriba)
4. Abre el archivo `neon-data-users.sql` en un editor de texto
5. **Copia TODO el contenido** (Ctrl+A, Ctrl+C)
6. **Pega en el SQL Editor** de Neon (Ctrl+V)
7. Click en el botón **Run** (o presiona Ctrl+Enter)
8. Espera a que termine (verás mensajes de éxito)

✅ Deberías ver al final:
```
Usuarios creados: 5
Perfiles creados: 5
Direcciones creadas: 3
Notificaciones creadas: 3
Alertas creadas: 2
```

### Paso 3: Ejecutar Script para restaurants_db

1. Selecciona la base de datos **restaurants_db**
2. Ve a **SQL Editor**
3. Abre `neon-data-restaurants.sql`
4. **Copia TODO el contenido**
5. **Pega en el SQL Editor**
6. Click en **Run**

✅ Deberías ver al final:
```
Restaurantes creados: 5
Direcciones creadas: 5
Categorías asignadas: 10
Platillos creados: 10
```

### Paso 4: Ejecutar Script para reviews_db

1. Selecciona la base de datos **reviews_db**
2. Ve a **SQL Editor**
3. Abre `neon-data-reviews.sql`
4. **Copia TODO el contenido**
5. **Pega en el SQL Editor**
6. Click en **Run**

✅ Deberías ver al final:
```
Reseñas creadas: 20
Imágenes de reseñas: 5
Restaurantes favoritos: 10
Promedio de calificación: 4.75
```

### Paso 5: Verificar Datos

Para verificar que todo se insertó correctamente, ejecuta en cada base de datos:

**En users_db:**
```sql
SELECT email, role FROM users;
```
Deberías ver 5 usuarios.

**En restaurants_db:**
```sql
SELECT name, price_range, rating FROM restaurants;
```
Deberías ver 5 restaurantes.

**En reviews_db:**
```sql
SELECT rating, comment FROM reviews LIMIT 5;
```
Deberías ver reseñas.

---

## 💻 MÉTODO ALTERNATIVO - Desde Terminal (PowerShell)

### Requisitos:
- PostgreSQL instalado (para tener psql)
- Credenciales de Neon a mano

### Paso 1: Obtener Credenciales

1. En Neon Console, ve a tu base de datos
2. Click en **Connection Details**
3. Copia los datos:
   - **Host**: algo como `ep-xxx-xxx.us-east-2.aws.neon.tech`
   - **User**: tu usuario
   - **Password**: tu contraseña
   - **Database**: users_db / restaurants_db / reviews_db

### Paso 2: Ejecutar Script PowerShell

Abre PowerShell en la carpeta del proyecto y ejecuta:

```powershell
.\execute-neon-scripts.ps1 `
  -NeonUser "tu_usuario" `
  -NeonPassword "tu_password" `
  -NeonHost "tu-host.neon.tech"
```

**Ejemplo:**
```powershell
.\execute-neon-scripts.ps1 `
  -NeonUser "neondb_owner" `
  -NeonPassword "mY$ecr3tP@ss" `
  -NeonHost "ep-cool-moon-12345.us-east-2.aws.neon.tech"
```

El script ejecutará los 3 archivos SQL automáticamente.

---

## ❓ Solución de Problemas

### Error: "relation does not exist"

**Causa**: Las tablas no existen todavía.

**Solución**:
1. Asegúrate de que los microservicios se hayan ejecutado al menos una vez
2. Con `ddl-auto: update`, Spring Boot crea las tablas automáticamente
3. O ejecuta los microservicios localmente primero

### Error: "duplicate key value violates unique constraint"

**Causa**: Los datos ya existen.

**Solución**:
1. Los scripts usan `ON CONFLICT DO NOTHING`
2. Este error es normal si ejecutas el script dos veces
3. Para limpiar: descomenta las líneas `TRUNCATE` al inicio de cada script

### Error: "password authentication failed"

**Causa**: Credenciales incorrectas.

**Solución**:
1. Verifica usuario y contraseña en Neon Console
2. Asegúrate de copiar la contraseña completa
3. Usa las credenciales del **owner** de la base de datos

---

## 📊 Datos que se Insertarán

### 👥 Usuarios (5)
- **admin@gastroreview.com** - Administrador
- **juan.perez@email.com** - Usuario regular
- **maria.garcia@email.com** - Food Blogger
- **carlos.lopez@email.com** - Chef profesional
- **ana.martinez@email.com** - Usuario regular

**Password para todos**: `password123`

### 🍽️ Restaurantes (5)
1. **La Casa de Toño** (CDMX) - Comida tradicional - $$
2. **El Mural de los Poblanos** (Puebla) - Cocina poblana - $$$
3. **Birriería Chololo** (Guadalajara) - Birria - $
4. **Pangea** (Monterrey) - Alta cocina - $$$$
5. **Hacienda Teya** (Mérida) - Cocina yucateca - $$

### 🍕 Platillos (10)
- Pozole Rojo
- Quesadillas de Flor de Calabaza
- Chiles en Nogada
- Mole Poblano
- Birria de Res
- Tacos de Birria
- Rib Eye Pangea
- Tataki de Atún
- Cochinita Pibil
- Papadzules

### ⭐ Reseñas (20)
- Calificaciones de 3 a 5 estrellas
- Análisis de sentimiento incluido
- Comentarios realistas
- 5 con imágenes adjuntas

---

## ✅ Checklist

- [ ] Accedí a Neon Console
- [ ] Ejecuté script en users_db
- [ ] Ejecuté script en restaurants_db
- [ ] Ejecuté script en reviews_db
- [ ] Verifiqué que los datos se insertaron
- [ ] Probé hacer login con un usuario de prueba

---

## 🎯 Siguiente Paso

Una vez que hayas ejecutado los scripts:

1. Configura las variables de entorno en Render con las credenciales de Neon
2. Los microservicios en Render se conectarán automáticamente a estas bases de datos
3. Podrás hacer login con los usuarios de prueba

**¡Listo para probar tu aplicación!** 🚀
