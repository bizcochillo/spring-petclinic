FROM registry.access.redhat.com/ubi9/openjdk-17:latest AS builder
WORKDIR /opt/app

COPY . .

RUN ./mvnw clean package -DskipTests

FROM registry.access.redhat.com/ubi9/jre-17-minimal:latest
WORKDIR /opt/app

COPY --from=builder /opt/app/target/spring-petclinic-*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
