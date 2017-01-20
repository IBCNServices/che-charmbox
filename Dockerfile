FROM jujusolutions/jujubox
EXPOSE 22
RUN sudo apt-get install -qy \
        openssh-server && \
    sudo mkdir /var/run/sshd && \
    sudo sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENTRYPOINT sudo /usr/sbin/sshd -D && \
    tail -f /dev/null

