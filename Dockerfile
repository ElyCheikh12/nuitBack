# Utiliser une image Java 17 avec Maven préinstallé
FROM maven:3.9-eclipse-temurin-17 as builder

# Définir le répertoire de travail
WORKDIR /app

# Copier d'abord le pom.xml pour mieux gérer le cache Docker
COPY pom.xml .

# Télécharger les dépendances (cette étape est mise en cache si pom.xml ne change pas)
RUN mvn dependency:go-offline -B

# Copier le reste du code source
COPY src ./src

# Compiler le projet
RUN mvn clean package -DskipTests

# Deuxième étape pour l'exécution (image plus légère)
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copier le JAR généré
COPY --from=builder /app/target/*.jar app.jar

# Exposer le port
EXPOSE 8080

# Commande pour lancer l'application
ENTRYPOINT ["java", "-jar", "app.jar"]
