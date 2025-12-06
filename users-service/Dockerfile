FROM eclipse-temurin:17-jdk-alpine AS build
WORKDIR /app

# Instalar Maven
RUN apk add --no-cache maven

# Copiar pom.xml y descargar dependencias
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copiar código fuente y compilar con Spring Boot
COPY src/ src/
RUN mvn clean install -DskipTests -B && \
    echo "=== Listing target directory ===" && \
    ls -lah /app/target/

# Etapa final
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Copiar el JAR compilado (ignorando el JAR original sin repackage)
COPY --from=build /app/target/users-service-*.jar app.jar

# Exponer puerto
EXPOSE 8081

# Ejecutar la aplicación con configuración de memoria optimizada para Railway
ENTRYPOINT ["sh", "-c", "java -Xms128m -Xmx256m -XX:+UseG1GC -XX:MaxGCPauseMillis=100 -XX:+UseStringDeduplication -Dserver.port=${PORT:-8081} -jar app.jar"]
