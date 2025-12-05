package WebSiters.users.model;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.util.UUID;

@Entity
@Table(name = "user_address")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class UserAddress {

    @EmbeddedId
    private UserAddressId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("userId")
    @JoinColumn(name = "user_id")
    private Users user;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("addressId")
    @JoinColumn(name = "address_id")
    private Address address;

    @Column(name = "type", nullable = false)
    private String type;

    @Builder.Default
    @Column(name = "active", nullable = false)
    private boolean active = true;

    @Embeddable
    @Getter @Setter @NoArgsConstructor @AllArgsConstructor
    public static class UserAddressId implements java.io.Serializable {
        @JdbcTypeCode(SqlTypes.UUID)
        private UUID userId;
        private Long addressId;
    }
}
