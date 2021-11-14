FROM alpine
MAINTAINER Tobias Göbel <kubax1983@gmail.com>

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.license="MIT" \
      org.label-schema.name="kubax/glass-isc-dhcp" \
      org.label-schema.url="https://hub.docker.com/r/kubax/glass-isc-dhcp" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-type="Git" \
      org.label-schema.vcs-url="https://github.com/kubax/docker-isc-dhcp-glass-alpine"

ENTRYPOINT ["/startapp.sh"]

ENV ADMINPASSWORD=glassadmin WEBSOCKETPORT=8080 WEBADMINPORT=3000

WORKDIR /opt

EXPOSE 3000/tcp 67/udp 67/tcp
COPY ./files/service /usr/sbin/service
COPY ./files/startapp.sh /startapp.sh
RUN chmod +x /startapp.sh /usr/sbin/service
RUN apk --no-cache add dhcp git bash tzdata libtool npm libc6-compat gcompat
RUN git clone https://github.com/Akkadius/glass-isc-dhcp.git
RUN cd glass-isc-dhcp && mkdir logs && chmod u+x ./bin/ -R && chmod u+x *.sh && npm config set unsafe-perm true &&  npm install && npm install forever -g && apk del git libtool && rm -rf /var/cache/apk/* /tmp/* /tmp/.[!.]* /opt/glass-isc-dhcp/.git


VOLUME ["/etc/dhcp"]

CMD ["/bin/sh"]
