FROM centos:7

RUN yum -y install wget
RUN yum -y install unzip

RUN wget http://docker.war.deployments.s3.amazonaws.com/third-party/jdk/jdk-8u171-linux-x64.rpm
RUN yum -y localinstall jdk-8u171-linux-x64.rpm
RUN export JAVA_HOME=/usr/java/jdk1.8.0_171-amd64/jre
RUN sh -c "echo export JAVA_HOME=/usr/java/jdk1.8.0_171-amd64/jre >> /etc/environment"
RUN rm jdk-8u171-linux-x64.rpm

RUN yum -y install initscripts && yum clean all

ARG FILE_NAME_CONFIGURATION
ARG PATH_NAME_CONFIGURATION
RUN mkdir $PATH_NAME_CONFIGURATION
COPY $FILE_NAME_CONFIGURATION $PATH_NAME_CONFIGURATION

ARG URL_WAR
ADD $URL_WAR /root/

CMD ["java", "-jar", "/root/ROOT.war"]

EXPOSE 8080
