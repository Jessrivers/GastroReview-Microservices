package WebSiters.restaurants.repository;

import WebSiters.restaurants.model.Restaurant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface RestaurantRepository extends JpaRepository<Restaurant, UUID> {
    List<Restaurant> findByOwnerIdAndActiveTrue(UUID ownerId);
    List<Restaurant> findByActiveTrue();
    List<Restaurant> findByNameContainingIgnoreCaseAndActiveTrue(String name);
}
