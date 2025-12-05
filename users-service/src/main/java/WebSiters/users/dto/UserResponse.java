package WebSiters.users.dto;

import lombok.*;

import java.util.UUID;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class UserResponse {
    private UUID id;
    private String email;
    private String role;
    private String name;
    private String photoUrl;
    private boolean active;
}
