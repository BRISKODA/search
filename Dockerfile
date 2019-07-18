FROM alpine:latest as build

ENV HUGO_VERSION 0.55.6
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit.tar.gz

# Install Hugo
RUN set -x && \
  apk add --update wget ca-certificates && \
  wget https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} && \
  tar xzf ${HUGO_BINARY} && \
  rm -r ${HUGO_BINARY} && \
  mv hugo /usr/bin && \
  apk del wget ca-certificates && \
  rm /var/cache/apk/*

COPY ./ /site
WORKDIR /site
RUN /usr/bin/hugo

#DEPLOY/Run
FROM nginx:1.17-alpine
COPY --from=build /site/public /usr/share/nginx/html

# The file "expires.inc" is copied into the image
# COPY _docker/expires.inc /etc/nginx/conf.d/expires.inc
# RUN chmod 0644 /etc/nginx/conf.d/expires.inc
