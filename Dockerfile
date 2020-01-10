FROM alpine:latest

VOLUME /opt/rancher/bin
VOLUME /ebs
VOLUME /s3

RUN apk add --no-cache go git curl bash xfsprogs e2fsprogs groff less python py-pip nvme-cli util-linux && \
    curl -L -o /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 && \
    chmod +x /usr/bin/jq && \
    pip install awscli && \
    go get github.com/finboxio/rancher-conf/cmd/rancher-conf && \
    apk del --no-cache go git py-pip

ENV PATH=$PATH:/root/go/bin

COPY ebs-scripts/* /usr/sbin/
RUN chmod +x /usr/sbin/ebs-*

COPY s3-scripts/* /usr/sbin/
RUN chmod +x /usr/sbin/s3-*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
