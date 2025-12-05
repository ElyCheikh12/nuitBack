# Étape de build
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copier d'abord le POM pour le cache Docker
COPY pom.xml .

# Télécharger les dépendances (mise en cache)
RUN mvn dependency:go-offline -B

# Copier le code source
COPY src ./src

# Compiler l'application
RUN mvn clean package -DskipTests

# Étape d'exécution
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copier le JAR depuis l'étape de build
COPY --from=build /app/target/*.jar app.jar

# Exposer le port 8080
EXPOSE 8080

# Lancer l'application
ENTRYPOINT ["java", "-jar", "app.jar"]
