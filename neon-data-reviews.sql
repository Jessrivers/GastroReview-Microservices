-- Script de datos de prueba para reviews_db en Neon
-- Base de datos: reviews_db

-- Limpiar datos existentes (opcional)
-- TRUNCATE TABLE review_images, favorite_restaurants, reviews RESTART IDENTITY CASCADE;

-- Insertar reseñas de prueba
-- Nota: Los UUIDs de user_id y restaurant_id deben coincidir con los de las otras bases de datos

INSERT INTO reviews (id, user_id, restaurant_id, rating, comment, sentiment_score, sentiment_label, created_at) VALUES
-- Reseñas para La Casa de Toño
('850e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440001', 5, 'El pozole es simplemente espectacular! La atención es excelente y el ambiente muy familiar. Totalmente recomendado.', 0.95, 'positive', NOW() - INTERVAL '5 days'),
('850e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440001', 4, 'Muy buen lugar para comer comida tradicional. El pozole está delicioso aunque las porciones podrían ser un poco más grandes.', 0.75, 'positive', NOW() - INTERVAL '10 days'),
('850e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440001', 5, 'Llevo viniendo aquí desde hace años y nunca decepciona. Las quesadillas de flor de calabaza son mi favorito absoluto.', 0.92, 'positive', NOW() - INTERVAL '15 days'),

-- Reseñas para El Mural de los Poblanos
('850e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440002', 5, 'Una experiencia gastronómica única. Los chiles en nogada son obra de arte, tanto en presentación como en sabor.', 0.98, 'positive', NOW() - INTERVAL '3 days'),
('850e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440002', 5, 'Como chef, puedo decir que este lugar tiene los mejores moles de México. La técnica y los ingredientes son de primer nivel.', 0.96, 'positive', NOW() - INTERVAL '7 days'),
('850e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440002', 4, 'Excelente comida poblana, aunque los precios son un poco elevados. Vale la pena para ocasiones especiales.', 0.70, 'positive', NOW() - INTERVAL '12 days'),

-- Reseñas para Birriería Chololo
('850e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440003', 5, 'La mejor birria que he probado en mi vida! El consomé está increíble y los tacos dorados son adictivos.', 0.99, 'positive', NOW() - INTERVAL '2 days'),
('850e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440003', 5, 'Si estás en Guadalajara, este lugar es OBLIGATORIO. Birria tradicional como debe ser.', 0.94, 'positive', NOW() - INTERVAL '6 days'),
('850e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440003', 5, 'Receta familiar auténtica. Se nota el amor y dedicación en cada platillo. Los tacos de birria con queso son mi nueva obsesión.', 0.97, 'positive', NOW() - INTERVAL '8 days'),
('850e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440003', 4, 'Muy buena birria, aunque puede haber algo de espera los fines de semana. Vale la pena.', 0.78, 'positive', NOW() - INTERVAL '11 days'),

-- Reseñas para Pangea
('850e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440004', 5, 'Alta cocina en su máxima expresión. Cada platillo es una experiencia sensorial única.', 0.93, 'positive', NOW() - INTERVAL '4 days'),
('850e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440004', 5, 'El mejor restaurante de Monterrey sin duda. El tataki de atún es espectacular.', 0.95, 'positive', NOW() - INTERVAL '9 days'),
('850e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440004', 4, 'Excelente comida y presentación. El servicio es impecable. Los precios son altos pero justificados.', 0.82, 'positive', NOW() - INTERVAL '13 days'),

-- Reseñas para Hacienda Teya
('850e8400-e29b-41d4-a716-446655440014', '550e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440005', 5, 'La cochinita pibil más auténtica de Yucatán. El lugar es hermoso y la comida deliciosa.', 0.96, 'positive', NOW() - INTERVAL '1 day'),
('850e8400-e29b-41d4-a716-446655440015', '550e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440005', 5, 'Experiencia completa: historia, arquitectura y gastronomía yucateca de primera. Los papadzules son increíbles.', 0.98, 'positive', NOW() - INTERVAL '5 days'),
('850e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440005', 5, 'Como chef, admiro la autenticidad de sus recetas. Todo está hecho con técnicas tradicionales.', 0.94, 'positive', NOW() - INTERVAL '14 days'),
('850e8400-e29b-41d4-a716-446655440017', '550e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440005', 4, 'Muy buena comida yucateca. El ambiente de hacienda es precioso. Recomiendo reservar con anticipación.', 0.85, 'positive', NOW() - INTERVAL '20 days'),

-- Algunas reseñas con calificaciones variadas
('850e8400-e29b-41d4-a716-446655440018', '550e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440002', 3, 'La comida es buena pero el servicio fue algo lento. Esperaba más por el precio.', 0.45, 'neutral', NOW() - INTERVAL '18 days'),
('850e8400-e29b-41d4-a716-446655440019', '550e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440004', 4, 'Buena experiencia en general. El rib eye estaba en su punto perfecto.', 0.80, 'positive', NOW() - INTERVAL '25 days'),
('850e8400-e29b-41d4-a716-446655440020', '550e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440003', 5, 'No puedo dejar de recomendar este lugar. Ya vine 3 veces este mes!', 0.92, 'positive', NOW() - INTERVAL '30 days')
ON CONFLICT (id) DO NOTHING;

-- Insertar imágenes de reseñas
INSERT INTO review_images (review_id, image_url, created_at) VALUES
('850e8400-e29b-41d4-a716-446655440001', 'https://images.unsplash.com/photo-1626645738196-c2a7c87a8f58?w=800', NOW()),
('850e8400-e29b-41d4-a716-446655440004', 'https://images.unsplash.com/photo-1599974430529-d2f1c8b1e104?w=800', NOW()),
('850e8400-e29b-41d4-a716-446655440007', 'https://images.unsplash.com/photo-1619895092538-128341789043?w=800', NOW()),
('850e8400-e29b-41d4-a716-446655440011', 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800', NOW()),
('850e8400-e29b-41d4-a716-446655440014', 'https://images.unsplash.com/photo-1615870216519-2f9fa575fa5c?w=800', NOW())
ON CONFLICT DO NOTHING;

-- Insertar restaurantes favoritos
INSERT INTO favorite_restaurants (user_id, restaurant_id, created_at) VALUES
('550e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440001', NOW() - INTERVAL '60 days'),
('550e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440003', NOW() - INTERVAL '45 days'),
('550e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440005', NOW() - INTERVAL '30 days'),
('550e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440002', NOW() - INTERVAL '50 days'),
('550e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440003', NOW() - INTERVAL '40 days'),
('550e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440004', NOW() - INTERVAL '20 days'),
('550e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440002', NOW() - INTERVAL '55 days'),
('550e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440004', NOW() - INTERVAL '35 days'),
('550e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440001', NOW() - INTERVAL '65 days'),
('550e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440005', NOW() - INTERVAL '25 days')
ON CONFLICT DO NOTHING;

-- Verificar datos insertados
SELECT 'Reseñas creadas:' as info, COUNT(*) as total FROM reviews;
SELECT 'Imágenes de reseñas:' as info, COUNT(*) as total FROM review_images;
SELECT 'Restaurantes favoritos:' as info, COUNT(*) as total FROM favorite_restaurants;
SELECT 'Promedio de calificación:' as info, ROUND(AVG(rating), 2) as promedio FROM reviews;
SELECT 'Distribución de sentiment:' as info, sentiment_label, COUNT(*) as total
FROM reviews
GROUP BY sentiment_label
ORDER BY total DESC;
