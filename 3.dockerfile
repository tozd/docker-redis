FROM registry.gitlab.com/tozd/docker/dinit:ubuntu-jammy

EXPOSE 6379/tcp

VOLUME /data

ENV LOG_TO_STDOUT=0

ARG REDIS_DOWNLOAD_URL=http://download.redis.io/releases/redis-3.2.13.tar.gz
ARG REDIS_DOWNLOAD_SHA1=f42a5301a3960ffbccff60596d24c6b73508b103

RUN groupadd -r redis && \
  useradd -r -g redis redis && \
  apt-get update -q -q && \
  apt-get --yes --force-yes install wget ca-certificates build-essential tcl && \
  mkdir -p /usr/src/redis && \
  wget "$REDIS_DOWNLOAD_URL" -O redis.tar.gz && \
  echo "$REDIS_DOWNLOAD_SHA1 *redis.tar.gz" | sha1sum -c - && \
  tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 && \
  rm redis.tar.gz && \
  make -C /usr/src/redis && \
  make -C /usr/src/redis test && \
  make -C /usr/src/redis install && \
  rm -r /usr/src/redis && \
  apt-get purge --yes --force-yes --auto-remove wget ca-certificates build-essential tcl && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache ~/.npm

COPY ./etc/service/redis /etc/service/redis
