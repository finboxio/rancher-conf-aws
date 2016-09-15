FROM alpine:3.4

VOLUME /opt/rancher/bin

RUN apk add --no-cache curl bash xfsprogs groff less python py-pip && \
    curl -L -o /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 && \
    chmod +x /usr/bin/jq && \
    pip install awscli && \
    apk del --no-cache py-pip

ADD rancher-gen/rancher-gen /usr/local/bin/rancher-gen
RUN chmod +x /usr/local/bin/rancher-gen

COPY ebs-scripts/* /usr/sbin/
RUN chmod +x /usr/sbin/ebs-*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
