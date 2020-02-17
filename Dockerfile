FROM centos:8
LABEL author "Fabio Montefuscolo <fabio.montefuscolo@gmail.com>"

RUN yum install -y                                                    \
        mailx                                                         \
        postfix                                                       \
        cyrus-imapd                                                   \
        cyrus-sasl-devel                                              \
        cyrus-sasl-plain                                              \
        telnet                                                        \
    && yum --enablerepo='*' clean all

RUN sed -i -e 's/inet_interfaces = localhost/inet_interfaces = all/g' \
        /etc/postfix/main.cf                                          \
    && touch /etc/postfix/sasl_passwd

EXPOSE 25
VOLUME /run

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/postfix", "start-fg"]
