FROM tomcat:latest
LABEL maintainer="kambala phaneendra"
ADD ./target/*.war /usr/local/tomcat/webapps/

