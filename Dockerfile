#Tomcat on CentOS 7
FROM centos:7
MAINTAINER phillip@bailey.st

# Install missing packages
RUN yum install -y wget tar

# Preparing Java/Tomcat ENV
ENV JAVA_HOME /opt/java
ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin:$CATALINA_HOME/scripts

# Go and get Java package
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
	http://download.oracle.com/otn-pub/java/jdk/7u71-b14/jdk-7u71-linux-x64.tar.gz && \
	tar -xvf jdk-7u71-linux-x64.tar.gz && \
	rm jdk*.tar.gz && \
	mv jdk* ${JAVA_HOME}


# Go and get Tomcat
RUN wget http://mirrors.ukfast.co.uk/sites/ftp.apache.org/tomcat/tomcat-8/v8.0.24/bin/apache-tomcat-8.0.24.tar.gz && \
	tar -xvf apache-tomcat-8.0.24.tar.gz && \
	rm apache-tomcat*.tar.gz && \
	mv apache-tomcat* ${CATALINA_HOME}

RUN chmod +x ${CATALINA_HOME}/bin/*sh


ADD tomcat.sh $CATALINA_HOME/scripts/tomcat.sh
RUN chmod +x $CATALINA_HOME/scripts/*.sh


RUN groupadd -r tomcat && \
	useradd -g tomcat -d ${CATALINA_HOME} -s /sbin/nologin  -c "Tomcat user" tomcat && \
	chown -R tomcat:tomcat ${CATALINA_HOME}

WORKDIR /opt/tomcat

USER tomcat
CMD ["tomcat.sh"]
