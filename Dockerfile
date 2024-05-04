# FROM  centos:latest
# MAINTAINER vikashashoke@gmail.com
# RUN yum install -y httpd \
#  zip\
#  unzip
# ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/
# WORKDIR /var/www/html/
# RUN unzip photogenic.zip
# RUN cp -rvf photogenic/* .
# RUN rm -rf photogenic photogenic.zip
# CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
# EXPOSE 80

FROM ubuntu:latest
MAINTAINER vikashashoke@gmail.com

# Update package lists and install necessary packages
RUN apt-get update && \
    apt-get install -y apache2 zip unzip wget && \
    rm -rf /var/lib/apt/lists/*

# Download the zip file
RUN wget -O /tmp/photogenic.zip https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip

# Unzip the downloaded file and move contents to web server directory
RUN unzip /tmp/photogenic.zip -d /var/www/html/ && \
    cp -rvf /var/www/html/photogenic/* /var/www/html/ && \
    rm -rf /var/www/html/photogenic /tmp/photogenic.zip

# Start Apache web server
CMD ["apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80

 
 
# FROM  centos:latest
# MAINTAINER vikashashoke@gmail.com
# RUN yum install -y httpd \
#  zip\
#  unzip
# ADD https://www.free-css.com/assets/files/free-css-templates/download/page265/shine.zip /var/www/html/
# WORKDIR /var/www/html/
# RUN unzip shine.zip
# RUN cp -rvf shine/* .
# RUN rm -rf shine shine.zip
# CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
# EXPOSE 80   
