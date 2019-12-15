FROM alpine:latest

VOLUME /opt/rancher/bin
VOLUME /ebs
VOLUME /s3

RUN apk add --no-cache curl bash xfsprogs e2fsprogs groff less python py-pip nvme-cli util-linux && \
    curl -L -o /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 && \
    chmod +x /usr/bin/jq && \
    pip install awscli && \
    apk del --no-cache py-pip

ADD rancher-gen/rancher-gen /usr/local/bin/rancher-gen
RUN chmod +x /usr/local/bin/rancher-gen

COPY ebs-scripts/* /usr/sbin/
RUN chmod +x /usr/sbin/ebs-*

COPY s3-scripts/* /usr/sbin/
RUN chmod +x /usr/sbin/s3-*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
