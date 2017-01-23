# Start from charmbox which has all the Juju and Charming
# dependencies installed
FROM jujusolutions/charmbox
EXPOSE 22

RUN sudo apt-get install -qy \
        openssh-server \
        nano tree git \
        python3-yaml && \
    sudo mkdir /var/run/sshd && \
    sudo sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Configure bash to show the current model in the bash prompt.
# Example:  
#   [mycontroller:ubuntu/mymodel] ubuntu@6b20e0917e87:~$
#
ADD model-as-ps1.sh /home/ubuntu/model-as-ps1.sh
ADD show-juju-env.sh /home/ubuntu/show-juju-env.sh
ADD .juju_context.py /home/ubuntu/.juju_context.py
RUN /home/ubuntu/model-as-ps1.sh

# Eclipse Che workspace requires this command to never exit, hence the tail -f
ENTRYPOINT sudo /usr/sbin/sshd -D && \
    tail -f /dev/null
