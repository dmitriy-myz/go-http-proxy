FROM golang:1.17.8 as builder
ADD *.go go.mod /opt/
WORKDIR /opt
RUN go get
RUN CGO_ENABLED=0 GOOS=linux go build .
#RUN cd /opt && go get && CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -a -installsuffix cgo

FROM scratch

COPY --from=0 /opt/httpProxy /httpProxy

ENTRYPOINT  ["/httpProxy", "-addr", "0.0.0.0:8080"]

