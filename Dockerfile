FROM centos:7
MAINTAINER William Markito <william.markito@gmail.com>

LABEL Vendor="Apache Geode"
LABEL version=v1.0.0-incubating.M2

# download JDK 8
ENV	JAVA_HOME $HOME/jdk1.8.0_72

RUN	yum install -y wget which tar git \
	&& wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u72-b15/jdk-8u72-linux-x64.tar.gz" \
	&& tar xf jdk-8u72-linux-x64.tar.gz \
	&& git clone https://github.com/apache/incubator-geode.git \
	&& cd incubator-geode \
	&& git checkout rel/v1.0.0-incubating.M2 \
	&& ./gradlew build -Dskip.tests=true -xjavadoc \
	&& ls /incubator-geode | grep -v geode-assembly | xargs rm -rf \
	&& rm -rf /root/.gradle/ \
	&& rm -rf /incubator-geode/geode-assembly/build/distributions/ \
	&& rm -rf /jdk-8u72-linux-x64.tar.gz \
	&& rm -rf /jdk-8u72-linux-x64/lib/missioncontrol/* \
	&& rm -rf /jdk-8u72-linux-x64/lib/visualvm/* \
	&& rm -rf /usr/share/locale/* \
	&& yum remove -y perl \
	&& yum clean all

ENV GEODE_HOME /incubator-geode/geode-assembly/build/install/apache-geode
ENV PATH $PATH:$GEODE_HOME/bin:$JAVA_HOME/bin
#ADD composer/scripts/ scripts/

# Default ports:
# RMI/JMX 1099
# REST 8080
# PULE 7070
# LOCATOR 10334
# CACHESERVER 40404
# EXPOSE  1024 8080 10334 40404 1099 7070
VOLUME ["/data/"]
# CMD ["gfsh"]
#ENTRYPOINT ["gfsh"]
