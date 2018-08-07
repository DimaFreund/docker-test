FROM tutum/lamp

RUN apt-get update &&\
    apt-get install --no-install-recommends --assume-yes --quiet ca-certificates curl git php-xdebug &&\
    rm -rf /var/lib/apt/lists/*

RUN echo 'zend_extension="/usr/local/lib/php/extensions/no-debug-non-zts-20151012/xdebug.so"' >> /usr/local/etc/php/php.ini

RUN echo 'xdebug.remote_enable=1' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.remote_host=127.0.0.1' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.remote_port=9000' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.profiler_enable = 0' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.remote_handler=dbgp' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.idekey=PHPSTORM' >> /usr/local/etc/php/php.ini



RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

CMD ["/usr/sbin/sshd", "-D"]