package WebSiters.restaurants.service;

import WebSiters.restaurants.client.UserServiceClient;
import WebSiters.restaurants.dto.RestaurantRequest;
import WebSiters.restaurants.dto.RestaurantResponse;
import WebSiters.restaurants.model.Address;
import WebSiters.restaurants.model.Restaurant;
import WebSiters.restaurants.repository.RestaurantRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class RestaurantService {

    @Autowired
    private RestaurantRepository restaurantRepository;

    @Autowired
    private UserServiceClient userServiceClient;

    public List<RestaurantResponse> getAllRestaurants() {
        return restaurantRepository.findByActiveTrue().stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    public RestaurantResponse getRestaurantById(UUID id) {
        Restaurant restaurant = restaurantRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Restaurant not found"));
        return mapToResponse(restaurant);
    }

    @Transactional
    public RestaurantResponse createRestaurant(RestaurantRequest request, UUID ownerId) {
        // Validate owner exists
        try {
            userServiceClient.getUserById(ownerId);
        } catch (Exception e) {
            throw new RuntimeException("User not found");
        }

        Restaurant restaurant = Restaurant.builder()
                .id(UUID.randomUUID())
                .name(request.getName())
                .description(request.getDescription())
                .phone(request.getPhone())
                .email(request.getEmail())
                .website(request.getWebsite())
                .priceRange(request.getPriceRange())
                .ownerId(ownerId)
                .active(true)
                .rating(0.0)
                .totalReviews(0)
                .build();

        restaurant = restaurantRepository.save(restaurant);
        return mapToResponse(restaurant);
    }

    private RestaurantResponse mapToResponse(Restaurant restaurant) {
        return RestaurantResponse.builder()
                .id(restaurant.getId())
                .name(restaurant.getName())
                .description(restaurant.getDescription())
                .phone(restaurant.getPhone())
                .email(restaurant.getEmail())
                .website(restaurant.getWebsite())
                .priceRange(restaurant.getPriceRange())
                .rating(restaurant.getRating())
                .totalReviews(restaurant.getTotalReviews())
                .createdAt(restaurant.getCreatedAt())
                .build();
    }
}
