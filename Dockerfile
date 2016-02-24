FROM p0bailey/docker-java
MAINTAINER Phillip Bailey  <phillip@bailey.st>

# Preparing Java/Tomcat ENV
#ENV JAVA_HOME /usr/java
ENV CATALINA_HOME /usr/tomcat
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin:$CATALINA_HOME/scripts

RUN yum -y update
RUN yum -y install wget; yum clean all
RUN adduser tomcat -M -d /usr/tomcat
RUN wget http://www.us.apache.org/dist/tomcat/tomcat-8/v8.0.32/bin/apache-tomcat-8.0.32.tar.gz
RUN tar zxvf apache-tomcat-8.0.32.tar.gz -C /usr/

RUN ln -s /usr/apache-tomcat-8.0.32 /usr/tomcat

#Deletes unwanted stuff
RUN rm -rf $CATALINA_HOME/webapps/{docs,examples,host-manager,manager,ROOT}

RUN chown -R tomcat. /usr/apache-tomcat-8.0.32

COPY tomcat.sh $CATALINA_HOME/bin/tomcat.sh
RUN chmod +x $CATALINA_HOME/bin/*.sh

COPY sample.war $CATALINA_HOME/webapps/

WORKDIR /usr/tomcat

USER tomcat
CMD ["tomcat.sh"]
