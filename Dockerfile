FROM ubuntu:groovy
MAINTAINER retali8@hackno.org

# install dependencies
RUN sed -i -e 's/archive/old-releases/g' -e 's/security\./old-releases\./g' /etc/apt/sources.list && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends gcc vim locales make libc6-dev apt-utils git ca-certificates openssh-server openssh-client supervisor && update-ca-certificates
RUN mkdir -p /var/run/sshd /var/log/supervisor

# copy supervisord configuration
COPY files/supervisord.conf /etc/supervisor/supervisord.conf

# copy pamspy binary
COPY files/pamspy /root/
RUN chmod a+x /root/pamspy

# libnss-ato
RUN git clone https://github.com/donapieppo/libnss-ato.git /root/libnss-ato && \
    cd /root/libnss-ato && \
    make && make install
RUN useradd -ms /bin/bash testuser
RUN echo "test_user:x:1000:1000:Test User:/home/test:/bin/bash" > /etc/libnss-ato.conf
RUN sed -i -e 's/passwd:         files/passwd:         ato/' /etc/nsswitch.conf
RUN sed -i -e 's/shadow:         files/shadow:         ato/' /etc/nsswitch.conf

# clean up
RUN rm -rf /var/cache/*  && \
    rm -rf /root/libnss-ato

VOLUME /var/log/pamspy

EXPOSE 22

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
