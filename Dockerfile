FROM ubuntu:20.04

COPY xymon-4.3.30.tar /root/
WORKDIR /root
ENV TZ=Europe/Paris
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y apache2 gcc make libpcre3-dev librrd-dev libssl-dev fping libc-ares-dev libtirpc-dev && apt clean
RUN /bin/tar -xf xymon-4.3.30.tar
RUN groupadd xymon && useradd xymon -g xymon
WORKDIR /root/xymon-4.3.30
COPY Makefile /root/xymon-4.3.30/
RUN make && make install

COPY xymon.conf /etc/apache2/sites-available/xymon.conf
RUN a2enmod rewrite authz_groupfile cgid
RUN a2ensite xymon.conf
EXPOSE 80

WORKDIR /root
COPY wrapper.sh /root/
CMD /root/wrapper.sh
