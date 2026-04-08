# ---------- Stage 1: Build ----------
FROM maven:3.9.9-eclipse-temurin-21 AS build

WORKDIR /app

# Copy pom.xml first (for caching dependencies)
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy source code
COPY src ./src

# Build JAR
RUN mvn clean package -DskipTests


# ---------- Stage 2: Run ----------
FROM eclipse-temurin:21-jdk

WORKDIR /app

# Copy JAR from build stage
COPY --from=build /app/target/demo_project-0.0.1-SNAPSHOT.jar app.jar

# Expose your app port
EXPOSE 7000

# Run app
ENTRYPOINT ["java", "-jar", "app.jar"]