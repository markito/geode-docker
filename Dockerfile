FROM    centos:centos6
MAINTAINER William Markito <william.markito@gmail.com>

RUN	yum install -y wget which tar unzip nc git

# download JDK 8
RUN	wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jdk-8u45-linux-x64.tar.gz"
RUN	tar xvf jdk-8u45-linux-x64.tar.gz
ENV	JAVA_HOME $HOME/jdk1.8.0_45

# clone source and build
RUN git clone https://github.com/apache/incubator-geode
RUN cd incubator-geode && ./gradlew build

RUN echo "Environment variables"
ENV GEODE_HOME /incubator-geode/gemfire-assembly/build/install/apache-geode
ENV PATH $PATH:$GEODE_HOME/bin

EXPOSE  8080    
EXPOSE	10334  	
EXPOSE	40404	
EXPOSE	1099	
EXPOSE	7575
