FROM fauria/lamp



RUN apt-get update

RUN apt-get install -y openssh-server php-xdebug
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN echo 'xdebug.remote_enable=1' >> /etc/php/7.0/apache2/php.ini
RUN echo 'xdebug.remote_host=127.0.0.1' >> /etc/php/7.0/apache2/php.ini
RUN echo 'xdebug.remote_port=9000' >> /etc/php/7.0/apache2/php.ini
RUN echo 'xdebug.remote_handler=dbgp' >> /etc/php/7.0/apache2/php.ini
RUN echo 'xdebug.idekey=PHPSTORM' >> /etc/php/7.0/apache2/php.ini

RUN mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]