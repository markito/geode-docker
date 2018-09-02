FROM java:latest
MAINTAINER William Markito <markito@apache.org>

LABEL Vendor="Apache Geode"
ENV GEODE_VERSION 1.6.0

RUN	git clone https://github.com/apache/geode.git \
	&& cd incubator-geode \
	&& git checkout rel/v$GEODE_VERSION \
	&& ./gradlew build -Dskip.tests=true -xjavadoc \
	&& ls /apache-geode | grep -v geode-assembly | xargs rm -rf \
	&& rm -rf /root/.gradle/ \
	&& rm -rf /apache-geode/geode-assembly/build/distributions/ \
	&& rm -rf /usr/share/locale/* 

ENV GEODE_HOME /apache-geode/geode-assembly/build/install/apache-geode
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
