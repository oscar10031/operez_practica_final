FROM docker:dind
ENV SSH_PUBLIC_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJTYqhOQNnglZ/kv9DZGHiepGPo/HdWzChevj4IG3t07 jenkins@91be307143f3"
ENV RUTA="/root"
RUN apk update
RUN apk add --update unzip curl wget shadow git


#RUN groupmod -g 998 docker
RUN mkdir $RUTA/workspace && chmod 777 $RUTA/workspace


RUN apk add nodejs-current npm


#Install JDK11 and Groovy
RUN apk add openjdk11
RUN wget https://www.apache.org/dyn/closer.lua/groovy/4.0.4/distribution/apache-groovy-binary-4.0.4.zip?action=download -O $RUTA/apache-groovy-binary-4.0.4.zip && unzip $RUTA/apache-groovy-binary-4.0.4.zip -d $RUTA/ && rm $RUTA/apache-groovy-binary-4.0.4.zip
COPY ./java.sh /etc/profile.d/java.sh


#Enable ssh login
RUN apk add --update --no-cache openssh
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN echo -n 'root:zeus2022' | chpasswd
RUN mkdir -p $RUTA/.ssh && chmod 755 $RUTA/.ssh && touch $RUTA/.ssh/authorized_keys && chmod 644 $RUTA/.ssh/authorized_keys
RUN echo $SSH_PUBLIC_KEY >> $RUTA/.ssh/authorized_keys
COPY ./entrypoint.sh $RUTA/entrypoint.sh
RUN chmod +x $RUTA/entrypoint.sh

COPY agent.jar /root/agent.jar
ENTRYPOINT ["/root/entrypoint.sh"]