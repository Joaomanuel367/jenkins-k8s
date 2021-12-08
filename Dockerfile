FROM jenkins/jenkins:2.319.1-jdk11
USER root
RUN apt-get update && apt-get install -y lsb-release ca-certificates curl gnupg

#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 7EA0A9C3F273FCD8

RUN echo -e "nameserver 10.0.2.3\nnameserver 8.8.8.8\nnameserver 8.8.4.4" > /etc/resolv.conf && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && cat /etc/resolv.conf

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN sed -i 's/debian/ubuntu/g' /etc/apt/sources.list.d/docker.list && cat /etc/apt/sources.list.d/docker.list
#RUN apt-get update && echo -e "nameserver 10.0.2.3\nnameserver 8.8.8.8\nnameserver 8.8.4.4" > /etc/resolv.conf &&  apt-get -y install docker-ce docker-ce-cli containerd.io
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.1 docker-workflow:1.26"
#ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
RUN jenkins.sh & 