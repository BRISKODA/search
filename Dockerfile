
FROM golang:1.11-stretch AS build


WORKDIR /go/src/github.com/gohugoio/hugo
RUN apt-get install \
    git gcc g++ binutils
COPY . /go/src/github.com/gohugoio/hugo/
ENV GO111MODULE=on
RUN go get -d .

ARG CGO=0
ENV CGO_ENABLED=${CGO}
ENV GOOS=linux

# default non-existent build tag so -tags always has an arg
ARG BUILD_TAGS="99notag"
RUN go install -ldflags '-w -extldflags "-static"' -tags ${BUILD_TAGS}

# ---

FROM alpine:3.9
RUN apk add --no-cache ca-certificates
COPY --from=build /go/bin/hugo /hugo
ARG  SITEDIR="/site"
WORKDIR ${SITEDIR}
COPY . ${SITEDIR}
RUN cd ${SITEDIR} && hugo --minify

#DEPLOY/Run
FROM nginx:1.17-alpine
WORKDIR /usr/share/nginx/html/

# Clean the default public folder
# RUN rm -fr * .??*

# This inserts a line in the default config file, including our file "expires.inc"
# RUN sed -i '9i\        include /etc/nginx/conf.d/expires.inc;\n' /etc/nginx/conf.d/default.conf

# The file "expires.inc" is copied into the image
# COPY _docker/expires.inc /etc/nginx/conf.d/expires.inc
# RUN chmod 0644 /etc/nginx/conf.d/expires.inc


# Clean the default public folder
RUN rm -fr * .??*
COPY --from=build ${SITEDIR}/. /usr/share/nginx/html/
