FROM docker:stable

MAINTAINER Muhammed GÜMÜŞ <muhammet.gumus@architecht.com>

ARG VCS_REF
ARG BUILD_DATE

# Metadata
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/muhgumus/kube-deploy" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/Dockerfile"

ENV KUBE_LATEST_VERSION="v1.25.4"

RUN apk update
RUN apk add wget
RUN wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
RUN chmod a+x /usr/local/bin/yq
RUN yq --version

RUN apk add --update ca-certificates \
 && apk add --update curl \
 && apk add --update jq \
 && apk add --update gettext \
 && apk add --update bash \
 && apk add --update git \
 && apk add --update openssh \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && rm /var/cache/apk/*

RUN git config --global user.email "ci@kube.deploy"
RUN git config --global user.name "CI Pipeline"

ENTRYPOINT ["sh"]
