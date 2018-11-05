FROM alpine:latest

MAINTAINER Muhammed GÜMÜŞ <muhammet.gumus@architecht.com>

ARG VCS_REF
ARG BUILD_DATE

# Metadata
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/muhgumus/kube-deploy" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/Dockerfile"

ENV KUBE_LATEST_VERSION="v1.12.2"

ADD delete_image.sh /delete_image.sh

RUN apk add --update ca-certificates \
 && apk add --update curl \
 && apk add --update jq \
 && apk add --update gettext \
 && apk add --update bash \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && chmod +x /delete_image.sh \
 && rm /var/cache/apk/*

ENTRYPOINT ["sh"]
