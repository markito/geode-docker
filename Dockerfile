FROM java:latest
MAINTAINER William Markito <markito@apache.org>

LABEL Vendor="Apache Geode"
LABEL version=1.0.0

RUN	git clone https://github.com/apache/incubator-geode.git \
	&& cd incubator-geode \
	&& git checkout rel/v1.0.0-incubating.M2 \
	&& ./gradlew build -Dskip.tests=true -xjavadoc \
	&& ls /incubator-geode | grep -v geode-assembly | xargs rm -rf \
	&& rm -rf /root/.gradle/ \
	&& rm -rf /incubator-geode/geode-assembly/build/distributions/ \
	&& rm -rf /usr/share/locale/* 

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
