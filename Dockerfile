FROM alpine:latest

VOLUME /opt/rancher/bin
VOLUME /ebs
VOLUME /s3

ENV GO111MODULE=on
ENV PATH=$PATH:/root/go/bin
RUN apk add --no-cache go git \
      curl bash coreutils docker-cli \
      groff less python3 py3-pip \
      util-linux xfsprogs e2fsprogs nvme-cli && \
    wget -O /usr/local/bin/yq "https://github.com/mikefarah/yq/releases/download/2.4.1/yq_linux_amd64" && \
    chmod +x /usr/local/bin/yq && \
    wget -O /usr/local/bin/jq "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64" && \
    chmod +x /usr/local/bin/jq && \
    pip3 install awscli && \
    go get github.com/tsg/gotpl && \
    go get github.com/finboxio/rancher-conf/cmd/rancher-conf@v0.4.0 && \
    rm -rf /root/go/src && \
    apk del go git py3-pip

COPY ebs-scripts/* /usr/sbin/
RUN chmod +x /usr/sbin/ebs-*

COPY s3-scripts/* /usr/sbin/
RUN chmod +x /usr/sbin/s3-*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
