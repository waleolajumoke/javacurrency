#build a jar file
FROM maven:3.8.3-jdk-8-slim AS build
WORKDIR /home/app
COPY . /home/app/
RUN mvn -f /home/app/pom.xml clean package


#create image
FROM openjdk:8-jdk-alpine
EXPOSE 5000
COPY --from=build /home/app/target/hello.jar hello.jar
ENTRYPOINT ["sh", "-c", "java -jar /hello.jar"]
