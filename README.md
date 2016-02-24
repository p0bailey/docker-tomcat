To build.

docker build -t tomcat .

To run.

docker run -d -p 8080:8080 p0bailey/docker-tomcat

WebApp:
http://<docker_machine_ip_address>:8080/sample/
