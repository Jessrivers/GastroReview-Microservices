package WebSiters.restaurants.repository;

import WebSiters.restaurants.model.Dish;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface DishRepository extends JpaRepository<Dish, UUID> {
    List<Dish> findByRestaurantIdAndAvailableTrue(UUID restaurantId);
    List<Dish> findByRestaurantId(UUID restaurantId);
}
