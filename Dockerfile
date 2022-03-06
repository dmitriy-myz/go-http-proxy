FROM golang:1.17.8 as builder
ADD *.go go.mod /opt/
RUN cd /opt && go get && go build

FROM scratch

COPY --from=0 /opt/httpProxy /httpProxy
user root:root

ENTRYPOINT ["/httpProxy"]
#CMD ["/httpProxy", "-addr", "0.0.0.0:8080"]

