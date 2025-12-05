package WebSiters.restaurants.dto;

import lombok.*;

import java.time.OffsetDateTime;
import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class RestaurantResponse {
    private UUID id;
    private String name;
    private String description;
    private String phone;
    private String email;
    private String website;
    private String priceRange;
    private Double rating;
    private Integer totalReviews;
    private OffsetDateTime createdAt;
    private AddressDto address;
}

@Getter @Setter @NoArgsConstructor @AllArgsConstructor
class AddressDto {
    private String street;
    private String city;
    private String state;
    private String country;
}
