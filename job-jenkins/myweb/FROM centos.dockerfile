FROM centos

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl


#Making the kubectl command accessible irrespective of the path.
RUN chmod +x ./kubectl
RUN mv kubectl /usr/bin/


#COpying the certificate and keys required for kubectl access inside the container.
COPY ca.crt /root/
COPY client.crt  /root/
COPY client.key  /root/
CMD mkdir /root/.kube
COPY config /root/.kube/

#Starting Jenkins
RUN yum install sudo -y
RUN yum install wget -y
RUN yum install git -y
RUN yum install jq -y
RUN yum install java-1.8.0-openjdk.x86_64  -y
RUN sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
RUN sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
RUN yum install Jenkins -y
CMD ["java", "-jar", "/usr/lib/jenkins/jenkins.war"]
EXPOSE 8080