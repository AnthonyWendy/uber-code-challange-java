# FROM maven:3-openjdk-17 AS build

# WORKDIR /app

# COPY . .

# RUN mvn clean package -DskipTests

# FROM openjdk:17-jdk-alpine

# WORKDIR /app

# COPY --from=build /app/target/email-service-0.0.1-SNAPSHOT.jar.original /app/email-service-0.0.1-SNAPSHOT.jar

# EXPOSE 8080

# ENTRYPOINT ["java", "-jar", "/app/email-service-0.0.1-SNAPSHOT"]

# Step 1: Build the application
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package

# Step 2: Create the final image
FROM openjdk:17-jdk-alpine
WORKDIR /app
# Note the corrected path and filename
COPY --from=build /app/target/email-service-0.0.1-SNAPSHOT.jar /app/email-service-0.0.1-SNAPSHOT.jar

ENTRYPOINT ["java", "-jar", "/app/email-service-0.0.1-SNAPSHOT.jar"]
