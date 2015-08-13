FROM extvos/java:7
MAINTAINER "Mingcai SHEN <archsh@gmail.com>"

ENV LOGSTASH_VERSION 1.5.3

# download and extract
ADD https://download.elastic.co/logstash/logstash/logstash-${LOGSTASH_VERSION}.tar.gz /opt/

COPY docker-entrypoint.sh /

RUN yum install -y ca-certificates \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64" \
	&& chmod +x /usr/local/bin/gosu \
	&& groupadd -r logstash && useradd -r -g logstash logstash \
	&& ln -s /opt/logstash-${LOGSTASH_VERSION} /opt/logstash \
	&& chmod +x /docker-entrypoint.sh

ENV PATH /opt/logstash/bin:$PATH

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["logstash", "agent"]