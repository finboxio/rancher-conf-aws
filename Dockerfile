FROM janeczku/rancher-gen:latest

VOLUME /opt/rancher/bin

RUN apk add --no-cache curl bash xfsprogs groff less python py-pip && \
    curl -L -o /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 && \
    chmod +x /usr/bin/jq && \
    pip install awscli && \
    apk del --no-cache curl py-pip

COPY ebs-scripts/* /usr/sbin/
RUN chmod +x /usr/sbin/ebs-*

ENTRYPOINT [ "rancher-gen" ]
CMD [ "--config", "/etc/rancher-conf/config.toml" ]
