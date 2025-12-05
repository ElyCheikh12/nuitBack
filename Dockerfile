# Utiliser une image Java 17
FROM eclipse-temurin:17-jdk as builder

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers du projet
COPY . .

# Solution : Installer Maven directement et compiler
RUN apt-get update && \
    apt-get install -y maven && \
    mvn clean package -DskipTests

# Deuxième étape pour une image plus légère
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copier le JAR généré depuis l'étape de build
COPY --from=builder /app/target/*.jar app.jar

# Exposer le port
EXPOSE 8080

# Commande pour lancer l'application
ENTRYPOINT ["java", "-jar", "app.jar"]
