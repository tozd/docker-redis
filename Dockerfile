FROM tozd/runit

EXPOSE 6379/tcp

VOLUME /data

ENV REDIS_VERSION 3.2.9
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-3.2.9.tar.gz
ENV REDIS_DOWNLOAD_SHA256 6eaacfa983b287e440d0839ead20c2231749d5d6b78bbe0e0ffa3a890c59ff26

RUN groupadd -r redis && \
 useradd -r -g redis redis && \
 apt-get update -q -q && \
 apt-get --yes --force-yes install wget ca-certificates build-essential && \
 mkdir -p /usr/src/redis && \
 wget "$REDIS_DOWNLOAD_URL" -O redis.tar.gz && \
 echo "$REDIS_DOWNLOAD_SHA256 *redis.tar.gz" | sha256sum -c - && \
 tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 && \
 rm redis.tar.gz && \
 make -C /usr/src/redis && \
 make -C /usr/src/redis install && \
 rm -r /usr/src/redis && \
 apt-get --yes --force-yes --auto-remove purge build-essential

COPY ./etc /etc
