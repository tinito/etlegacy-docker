FROM debian:stable-slim

LABEL maintainer="martino.migliavacca@gmail.com"

# Install prereqs
RUN apt-get update && apt-get install -y \
  p7zip-full \
  curl \
 && rm -rf /var/lib/apt/lists/*

# Install ET Legacy and assets
RUN curl https://www.etlegacy.com/download/file/122 | tar xvz; mv etlegacy-v2.76-i386 etlegacy && \
    curl -o temp.exe http://trackbase.eu/files//et/full/WolfET_2_60b_custom.exe; 7z e temp.exe -oetlegacy/etmain etmain/pak*.pk3; rm temp.exe
RUN echo "set sv_allowDownload \"1\"" >> etlegacy/etmain/etl_server.cfg  && \
    echo "set rconpassword \"etlegacy\"" >> etlegacy/etmain/etl_server.cfg

EXPOSE 27960/udp
USER root
WORKDIR /etlegacy
ENTRYPOINT ./etlded_bot.sh
