
FROM ubuntu:14.04

MAINTAINER Phillip Bailey <phillip@bailey.st>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install tomcat7 tomcat7-examples

CMD  JAVA_HOME=/usr/lib/jvm/default-java CATALINA_BASE=/var/lib/tomcat7 CATALINA_HOME=/usr/share/tomcat7 /usr/share/tomcat7/bin/catalina.sh run
