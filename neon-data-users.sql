-- Script de datos de prueba para users_db en Neon
-- Base de datos: users_db

-- Limpiar datos existentes (opcional)
-- TRUNCATE TABLE user_addresses, user_profile, notifications, alerts, users RESTART IDENTITY CASCADE;

-- Insertar usuarios de prueba
-- Nota: Las contraseñas están hasheadas con BCrypt (todas son "password123")
INSERT INTO users (id, email, hash_password, role) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'admin@gastroreview.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'ADMIN'),
('550e8400-e29b-41d4-a716-446655440002', 'juan.perez@email.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'USER'),
('550e8400-e29b-41d4-a716-446655440003', 'maria.garcia@email.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'USER'),
('550e8400-e29b-41d4-a716-446655440004', 'carlos.lopez@email.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'USER'),
('550e8400-e29b-41d4-a716-446655440005', 'ana.martinez@email.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'USER')
ON CONFLICT (id) DO NOTHING;

-- Insertar perfiles de usuario
INSERT INTO user_profile (user_id, first_name, last_name, phone, bio, avatar_url, created_at) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'Admin', 'Sistema', '+52-555-0001', 'Administrador del sistema', 'https://i.pravatar.cc/150?img=1', NOW()),
('550e8400-e29b-41d4-a716-446655440002', 'Juan', 'Pérez', '+52-555-1234', 'Amante de la comida mexicana', 'https://i.pravatar.cc/150?img=12', NOW()),
('550e8400-e29b-41d4-a716-446655440003', 'María', 'García', '+52-555-5678', 'Food blogger y crítica gastronómica', 'https://i.pravatar.cc/150?img=23', NOW()),
('550e8400-e29b-41d4-a716-446655440004', 'Carlos', 'López', '+52-555-9012', 'Chef profesional', 'https://i.pravatar.cc/150?img=33', NOW()),
('550e8400-e29b-41d4-a716-446655440005', 'Ana', 'Martínez', '+52-555-3456', 'Exploradora de nuevos sabores', 'https://i.pravatar.cc/150?img=45', NOW())
ON CONFLICT (user_id) DO NOTHING;

-- Insertar direcciones
INSERT INTO address (street, city, state, postal_code, country) VALUES
('Av. Reforma 123', 'Ciudad de México', 'CDMX', '01000', 'México'),
('Calle Juárez 456', 'Guadalajara', 'Jalisco', '44100', 'México'),
('Blvd. Díaz Ordaz 789', 'Monterrey', 'Nuevo León', '64000', 'México')
ON CONFLICT DO NOTHING;

-- Asociar direcciones a usuarios
INSERT INTO user_addresses (user_id, address_id, address_type, is_default)
SELECT '550e8400-e29b-41d4-a716-446655440002', id, 'HOME', true
FROM address WHERE street = 'Av. Reforma 123' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO user_addresses (user_id, address_id, address_type, is_default)
SELECT '550e8400-e29b-41d4-a716-446655440003', id, 'HOME', true
FROM address WHERE street = 'Calle Juárez 456' LIMIT 1
ON CONFLICT DO NOTHING;

-- Insertar notificaciones de ejemplo
INSERT INTO notifications (user_id, title, message, type, read, created_at) VALUES
('550e8400-e29b-41d4-a716-446655440002', 'Bienvenido a GastroReview', 'Gracias por unirte a nuestra comunidad', 'INFO', true, NOW() - INTERVAL '7 days'),
('550e8400-e29b-41d4-a716-446655440002', 'Nueva reseña destacada', 'Tu reseña ha recibido 10 me gusta', 'SUCCESS', false, NOW() - INTERVAL '2 days'),
('550e8400-e29b-41d4-a716-446655440003', 'Restaurante favorito actualizado', 'Uno de tus restaurantes favoritos tiene nuevo menú', 'INFO', false, NOW() - INTERVAL '1 day')
ON CONFLICT DO NOTHING;

-- Insertar alertas de ejemplo
INSERT INTO alerts (user_id, title, message, severity, active, created_at, expires_at) VALUES
('550e8400-e29b-41d4-a716-446655440002', 'Mantenimiento programado', 'El sistema estará en mantenimiento el domingo', 'LOW', true, NOW(), NOW() + INTERVAL '5 days'),
('550e8400-e29b-41d4-a716-446655440003', 'Actualización de términos', 'Por favor revisa nuestros nuevos términos de servicio', 'MEDIUM', true, NOW(), NOW() + INTERVAL '30 days')
ON CONFLICT DO NOTHING;

-- Verificar datos insertados
SELECT 'Usuarios creados:' as info, COUNT(*) as total FROM users;
SELECT 'Perfiles creados:' as info, COUNT(*) as total FROM user_profile;
SELECT 'Direcciones creadas:' as info, COUNT(*) as total FROM address;
SELECT 'Notificaciones creadas:' as info, COUNT(*) as total FROM notifications;
SELECT 'Alertas creadas:' as info, COUNT(*) as total FROM alerts;
