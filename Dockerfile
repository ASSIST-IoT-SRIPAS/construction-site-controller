ARG OPENJDK_VERSION=17
ARG ALPINE_VERSION=3.15.0

# Internal, passed between stages.
ARG FUSEKI_DIR=/fuseki
ARG FUSEKI_JAR=jena-fuseki-server-${JENA_VERSION}.jar
ARG JAVA_MINIMAL=/opt/java-minimal

## ---- Stage: Download and build java.
FROM openjdk:${OPENJDK_VERSION}-alpine AS base

COPY fuseki /fuseki

EXPOSE 3030

ENTRYPOINT ["/fuseki/fuseki-server" ]
CMD []
