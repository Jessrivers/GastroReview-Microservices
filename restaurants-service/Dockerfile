FROM eclipse-temurin:17-jdk-alpine AS build
WORKDIR /app

# Instalar Maven
RUN apk add --no-cache maven

# Copiar pom.xml y descargar dependencias
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copiar código fuente y compilar
COPY src/ src/
RUN mvn clean package spring-boot:repackage -DskipTests -B

# Verificar que el JAR se generó correctamente
RUN ls -la /app/target/ && \
    if [ ! -f /app/target/restaurants-service-*.jar ]; then echo "ERROR: JAR not found!"; exit 1; fi

# Etapa final
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Copiar el JAR compilado (ignorando el JAR original sin repackage)
COPY --from=build /app/target/restaurants-service-*.jar app.jar

# Exponer puerto
EXPOSE 8082

# Ejecutar la aplicación
ENTRYPOINT ["sh", "-c", "java -Dserver.port=${PORT:-8082} -jar app.jar"]
