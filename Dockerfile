FROM eclipse-temurin:8-jre-alpine as build

WORKDIR /minecraft

RUN echo "eula=true" > eula.txt

FROM build as serverImage

COPY server/ /minecraft/

EXPOSE 25565

ENTRYPOINT [ "java" ]

CMD ["-Xms2G", "-Xmx8G", "-XX:+AggressiveOpts", "-XX:+DisableExplicitGC", "-XX:+ParallelRefProcEnabled", "-XX:+UseCompressedOops", "-XX:-UsePerfData", "-XX:MaxGCPauseMillis=200", "-XX:ParallelGCThreads=8", "-XX:ConcGCThreads=2", "-XX:+UseG1GC", "-XX:G1HeapWastePercent=5", "-XX:G1MixedGCCountTarget=8", "-jar", "forge-1.7.10-10.13.4.1614-1.7.10-universal.jar", "nogui"]