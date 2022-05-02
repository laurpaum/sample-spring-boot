# Build
FROM maven:3-jdk-11 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY ./src ./src
RUN mvn clean install

# Packega
FROM openjdk:11-jre

WORKDIR /app

COPY --from=build /app/target/*.jar /app/app.jar

ENTRYPOINT [ "java", "-jar", "/app/app.jar" ]