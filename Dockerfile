FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install nPerfServer
RUN apt update && apt -y install lsb-release gnupg wget &&\
    wget -qO- https://repo.nperf.com/apt/conf/nperf-server.gpg.key | gpg --dearmor > /usr/share/keyrings/nperf-archive-keyring.gpg &&\
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/nperf-archive-keyring.gpg] https://repo.nperf.com/apt $(lsb_release -sc) main non-free" >> /etc/apt/sources.list.d/nperf.list &&\
    apt update &&\
    apt -y install nperf-server

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Run nPerfServer
CMD ["/entrypoint.sh"]


