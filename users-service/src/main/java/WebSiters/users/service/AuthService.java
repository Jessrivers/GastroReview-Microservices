package WebSiters.users.service;

import WebSiters.users.dto.LoginRequest;
import WebSiters.users.dto.LoginResponse;
import WebSiters.users.dto.RegisterRequest;
import WebSiters.users.model.Role;
import WebSiters.users.model.UserProfile;
import WebSiters.users.model.Users;
import WebSiters.users.repository.UsersRepository;
import WebSiters.users.security.JwtTokenProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
public class AuthService {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private UsersRepository usersRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JwtTokenProvider tokenProvider;

    public LoginResponse login(LoginRequest loginRequest) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        loginRequest.getEmail(),
                        loginRequest.getPassword()
                )
        );

        String token = tokenProvider.generateToken(authentication);

        Users user = usersRepository.findByEmail(loginRequest.getEmail())
                .orElseThrow(() -> new RuntimeException("User not found"));

        return new LoginResponse(token, user.getEmail(), user.getId().toString());
    }

    @Transactional
    public LoginResponse register(RegisterRequest registerRequest) {
        if (usersRepository.existsByEmail(registerRequest.getEmail())) {
            throw new RuntimeException("Email already exists");
        }

        Users user = Users.builder()
                .id(UUID.randomUUID())
                .email(registerRequest.getEmail())
                .hashPassword(passwordEncoder.encode(registerRequest.getPassword()))
                .role(Role.USER)
                .build();

        if (registerRequest.getName() != null) {
            UserProfile profile = UserProfile.builder()
                    .userId(user.getId())
                    .user(user)
                    .name(registerRequest.getName())
                    .active(true)
                    .build();
            user.setProfile(profile);
        }

        usersRepository.save(user);

        String token = tokenProvider.generateToken(user.getEmail(), Role.USER.getAuthority());

        return new LoginResponse(token, user.getEmail(), user.getId().toString());
    }
}
