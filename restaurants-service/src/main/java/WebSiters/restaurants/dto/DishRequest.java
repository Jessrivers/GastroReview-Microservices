package WebSiters.restaurants.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class DishRequest {
    @NotNull
    private UUID restaurantId;

    @NotBlank
    private String name;

    private String description;

    @NotNull
    private Integer priceCents;

    private String category;
    private String imageUrl;
    private Boolean available;
}
