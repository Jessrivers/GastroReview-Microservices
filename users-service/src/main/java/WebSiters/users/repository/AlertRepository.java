package WebSiters.users.repository;

import WebSiters.users.model.Alert;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface AlertRepository extends JpaRepository<Alert, Long> {
    List<Alert> findByRestaurantIdOrderByCreatedAtDesc(UUID restaurantId);
    List<Alert> findByReviewIdOrderByCreatedAtDesc(UUID reviewId);
}
