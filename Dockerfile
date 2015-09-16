FROM blacklabelops/loggly
MAINTAINER Paysavvy <mikem@paysavvy.com>

RUN gem install fluent-plugin-burrow
RUN gem install fluent-plugin-docker_metadata_filter

ENV LOGS_DIRECTORIES=/var/lib/docker/containers
ENV DISABLE_FILE_OUT=true
ENV LOG_FILE_FORMAT=json

#only configurable with filtered. prefix
ENV LOGGLY_MATCH=filtered.containerlog.**

WORKDIR /etc/fluent
COPY filter_setup_entrypoint.sh /etc/fluent/filter_setup_entrypoint.sh
ENTRYPOINT ["/etc/fluent/filter_setup_entrypoint.sh"]
CMD ["fluentd"]