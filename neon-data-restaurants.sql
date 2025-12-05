-- Script de datos de prueba para restaurants_db en Neon
-- Base de datos: restaurants_db

-- Limpiar datos existentes (opcional)
-- TRUNCATE TABLE dishes, restaurant_categories, restaurants, address RESTART IDENTITY CASCADE;

-- Insertar direcciones de restaurantes
INSERT INTO address (street, city, state, postal_code, country, latitude, longitude) VALUES
('Av. Insurgentes Sur 1605', 'Ciudad de México', 'CDMX', '03900', 'México', 19.3910, -99.1620),
('Calle Morelos 234', 'Puebla', 'Puebla', '72000', 'México', 19.0414, -98.2063),
('Av. Chapultepec 567', 'Guadalajara', 'Jalisco', '44600', 'México', 20.6737, -103.3579),
('Blvd. Miguel Alemán 890', 'Monterrey', 'Nuevo León', '64460', 'México', 25.6866, -100.3161),
('Calle 60 #456', 'Mérida', 'Yucatán', '97000', 'México', 20.9674, -89.5926)
ON CONFLICT DO NOTHING;

-- Insertar restaurantes de prueba
INSERT INTO restaurants (id, name, description, address_id, phone, email, website, price_range, rating, total_reviews, active, owner_id, created_at)
SELECT
    '650e8400-e29b-41d4-a716-446655440001',
    'La Casa de Toño',
    'Restaurante tradicional mexicano con más de 50 años de historia. Especialidad en pozole y antojitos.',
    id,
    '+52-55-5555-1234',
    'contacto@casadetono.com',
    'https://casadetono.com',
    '$$',
    4.5,
    127,
    true,
    '550e8400-e29b-41d4-a716-446655440004',
    NOW() - INTERVAL '2 years'
FROM address WHERE street = 'Av. Insurgentes Sur 1605' LIMIT 1
ON CONFLICT (id) DO NOTHING;

INSERT INTO restaurants (id, name, description, address_id, phone, email, website, price_range, rating, total_reviews, active, owner_id, created_at)
SELECT
    '650e8400-e29b-41d4-a716-446655440002',
    'El Mural de los Poblanos',
    'Cocina poblana contemporánea en el corazón del centro histórico. Famoso por su mole y chiles en nogada.',
    id,
    '+52-22-2222-5678',
    'reservas@elmural.com.mx',
    'https://elmural.com.mx',
    '$$$',
    4.8,
    203,
    true,
    '550e8400-e29b-41d4-a716-446655440004',
    NOW() - INTERVAL '1 year'
FROM address WHERE street = 'Calle Morelos 234' LIMIT 1
ON CONFLICT (id) DO NOTHING;

INSERT INTO restaurants (id, name, description, address_id, phone, email, website, price_range, rating, total_reviews, active, owner_id, created_at)
SELECT
    '650e8400-e29b-41d4-a716-446655440003',
    'Birriería Chololo',
    'La mejor birria de Jalisco. Receta familiar de más de 3 generaciones.',
    id,
    '+52-33-3333-9012',
    'info@birriachololo.com',
    'https://birriachololo.com',
    '$',
    4.7,
    456,
    true,
    '550e8400-e29b-41d4-a716-446655440004',
    NOW() - INTERVAL '3 years'
FROM address WHERE street = 'Av. Chapultepec 567' LIMIT 1
ON CONFLICT (id) DO NOTHING;

INSERT INTO restaurants (id, name, description, address_id, phone, email, website, price_range, rating, total_reviews, active, owner_id, created_at)
SELECT
    '650e8400-e29b-41d4-a716-446655440004',
    'Pangea',
    'Alta cocina internacional con toques regionales. Experiencia gastronómica de autor.',
    id,
    '+52-81-8888-3456',
    'reservaciones@pangea.com.mx',
    'https://pangea.com.mx',
    '$$$$',
    4.9,
    89,
    true,
    '550e8400-e29b-41d4-a716-446655440004',
    NOW() - INTERVAL '6 months'
FROM address WHERE street = 'Blvd. Miguel Alemán 890' LIMIT 1
ON CONFLICT (id) DO NOTHING;

INSERT INTO restaurants (id, name, description, address_id, phone, email, website, price_range, rating, total_reviews, active, owner_id, created_at)
SELECT
    '650e8400-e29b-41d4-a716-446655440005',
    'Hacienda Teya',
    'Auténtica cocina yucateca en una hacienda del siglo XVIII. Cochinita pibil y papadzules extraordinarios.',
    id,
    '+52-99-9999-7890',
    'contacto@haciendateya.com',
    'https://haciendateya.com',
    '$$',
    4.6,
    312,
    true,
    '550e8400-e29b-41d4-a716-446655440004',
    NOW() - INTERVAL '5 years'
FROM address WHERE street = 'Calle 60 #456' LIMIT 1
ON CONFLICT (id) DO NOTHING;

-- Insertar categorías de restaurantes
INSERT INTO restaurant_categories (restaurant_id, category_name) VALUES
('650e8400-e29b-41d4-a716-446655440001', 'Mexicana'),
('650e8400-e29b-41d4-a716-446655440001', 'Tradicional'),
('650e8400-e29b-41d4-a716-446655440002', 'Poblana'),
('650e8400-e29b-41d4-a716-446655440002', 'Gourmet'),
('650e8400-e29b-41d4-a716-446655440003', 'Jalisciense'),
('650e8400-e29b-41d4-a716-446655440003', 'Birria'),
('650e8400-e29b-41d4-a716-446655440004', 'Internacional'),
('650e8400-e29b-41d4-a716-446655440004', 'Alta Cocina'),
('650e8400-e29b-41d4-a716-446655440005', 'Yucateca'),
('650e8400-e29b-41d4-a716-446655440005', 'Regional')
ON CONFLICT DO NOTHING;

-- Insertar platillos
INSERT INTO dishes (id, restaurant_id, name, description, price, category, available, created_at) VALUES
('750e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440001', 'Pozole Rojo', 'Pozole tradicional con carne de cerdo, maíz cacahuazintle y chile guajillo', 95.00, 'Sopas', true, NOW()),
('750e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440001', 'Quesadillas de Flor de Calabaza', 'Tortillas hechas a mano rellenas de flor de calabaza', 75.00, 'Antojitos', true, NOW()),
('750e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440002', 'Chiles en Nogada', 'Chile poblano relleno de picadillo, bañado en salsa de nuez', 285.00, 'Platillos Fuertes', true, NOW()),
('750e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440002', 'Mole Poblano', 'Mole tradicional con pollo, servido con arroz y frijoles', 195.00, 'Platillos Fuertes', true, NOW()),
('750e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440003', 'Birria de Res', 'Birria estilo Jalisco con consomé, tortillas y guarniciones', 165.00, 'Platillos Fuertes', true, NOW()),
('750e8400-e29b-41d4-a716-446655440006', '650e8400-e29b-41d4-a716-446655440003', 'Tacos de Birria', 'Tacos dorados de birria con queso y consomé', 95.00, 'Tacos', true, NOW()),
('750e8400-e29b-41d4-a716-446655440007', '650e8400-e29b-41d4-a716-446655440004', 'Rib Eye Pangea', 'Corte de 400g con reducción de vino tinto y vegetales asados', 520.00, 'Carnes', true, NOW()),
('750e8400-e29b-41d4-a716-446655440008', '650e8400-e29b-41d4-a716-446655440004', 'Tataki de Atún', 'Atún sellado con sésamo, salsa ponzu y microgreens', 340.00, 'Entradas', true, NOW()),
('750e8400-e29b-41d4-a716-446655440009', '650e8400-e29b-41d4-a716-446655440005', 'Cochinita Pibil', 'Cerdo marinado en achiote, cocido en horno de tierra', 145.00, 'Platillos Fuertes', true, NOW()),
('750e8400-e29b-41d4-a716-446655440010', '650e8400-e29b-41d4-a716-446655440005', 'Papadzules', 'Tacos de huevo en salsa de pepita de calabaza', 115.00, 'Entradas', true, NOW())
ON CONFLICT (id) DO NOTHING;

-- Verificar datos insertados
SELECT 'Restaurantes creados:' as info, COUNT(*) as total FROM restaurants;
SELECT 'Direcciones creadas:' as info, COUNT(*) as total FROM address;
SELECT 'Categorías asignadas:' as info, COUNT(*) as total FROM restaurant_categories;
SELECT 'Platillos creados:' as info, COUNT(*) as total FROM dishes;
