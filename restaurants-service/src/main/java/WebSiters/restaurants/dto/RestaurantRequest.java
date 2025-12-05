package WebSiters.restaurants.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.*;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class RestaurantRequest {
    @NotBlank
    private String name;
    private String description;
    private String street;
    private String city;
    private String state;
    private String country;
    private String phone;
    private String email;
    private String website;
    private String priceRange;
}
