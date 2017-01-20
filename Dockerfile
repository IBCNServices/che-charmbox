FROM jujusolutions/jujubox
EXPOSE 22

RUN sudo apt-get install -qy \
        openssh-server \
        nano tree git \
        python3-yaml && \
    sudo mkdir /var/run/sshd && \
    sudo sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
    
ADD model-as-ps1.sh ~/model-as-ps1.sh
ADD show-juju-env.sh ~/show-juju-env.sh
ADD .juju_context.py ~/.juju_context.py
RUN ~/model-as-ps1.sh
ENTRYPOINT sudo /usr/sbin/sshd -D && \
    tail -f /dev/null

