FROM alpine:3.4

VOLUME /opt/rancher/bin

RUN apk add --no-cache curl bash xfsprogs groff less python py-pip && \
    curl -L -o /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 && \
    chmod +x /usr/bin/jq && \
    pip install awscli && \
    apk del --no-cache curl py-pip

ADD rancher-gen/rancher-gen /usr/local/bin/rancher-gen
RUN chmod +x /usr/local/bin/rancher-gen

COPY ebs-scripts/* /usr/sbin/
RUN chmod +x /usr/sbin/ebs-*

ENTRYPOINT [ "/usr/local/bin/rancher-gen" ]
CMD [ "--config", "/etc/rancher-conf/config.toml" ]
