FROM tozd/runit

EXPOSE 6379/tcp

VOLUME /data

ENV REDIS_VERSION 3.0.6
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-3.0.6.tar.gz
ENV REDIS_DOWNLOAD_SHA1 4b1c7b1201984bca8f7f9c6c58862f6928cf0a25

RUN groupadd -r redis && \
 useradd -r -g redis redis && \
 apt-get update -q -q && \
 apt-get --yes --force-yes install wget ca-certificates build-essential && \
 mkdir -p /usr/src/redis && \
 wget "$REDIS_DOWNLOAD_URL" -O redis.tar.gz && \
 echo "$REDIS_DOWNLOAD_SHA1 *redis.tar.gz" | sha1sum -c - && \
 tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 && \
 rm redis.tar.gz && \
 make -C /usr/src/redis && \
 make -C /usr/src/redis install && \
 rm -r /usr/src/redis && \
 apt-get --yes --force-yes --auto-remove purge build-essential

COPY ./etc /etc
