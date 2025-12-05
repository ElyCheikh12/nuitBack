# Utiliser Eclipse Temurin 17 comme base
FROM eclipse-temurin:17-jdk

# Définir le répertoire de travail
WORKDIR /app

# Copier tous les fichiers
COPY . .

# Compiler le projet
RUN ./mvnw clean package -DskipTests

# Exécuter le jar généré
CMD ["java", "-jar", "demo/target/demo-0.0.1-SNAPSHOT.jar"]
