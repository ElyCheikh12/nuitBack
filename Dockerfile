# Utiliser OpenJDK 17 comme base
FROM openjdk:17-jdk-slim

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers Maven et le code source
COPY . .

# Compiler le projet avec Maven Wrapper
RUN ./mvnw clean package -DskipTests

# Définir le jar à exécuter
CMD ["java", "-jar", "demo/target/demo-0.0.1-SNAPSHOT.jar"]
