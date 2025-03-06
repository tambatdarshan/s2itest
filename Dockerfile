FROM ubi8/php-74

USER 0

# update operating system packages and install java-17-openjdk
RUN yum --disableplugin=subscription-manager install java-17-openjdk -y \

    && yum --disableplugin=subscription-manager update -y \
    && yum --disableplugin=subscription-manager clean all

ADD app-src /tmp/src
RUN chown -R 1001:0 /tmp/src
RUN chmod -R 777 /run/httpd
USER 1001

# Install the dependencies
RUN /usr/libexec/s2i/assemble

# Set the default command for the resulting image
CMD /usr/libexec/s2i/run
