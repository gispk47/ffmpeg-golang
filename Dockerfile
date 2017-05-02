FROM golang:1.7-alpine

MAINTAINER Matt Snoby <matt.snoby@icloud.com>


#
# Tiny Container that holds ffmpeg, ffprobe and can build / run golang programs.
#
#
RUN apk --no-cache add ca-certificates curl bash xz-libs git
#RUN apt-get update && apt-get install -y ca-certificates curl bash git
WORKDIR /tmp
RUN curl -L -O http://johnvansickle.com/ffmpeg/releases/ffmpeg-release-64bit-static.tar.xz
RUN tar -xf ffmpeg-release-64bit-static.tar.xz && \
      cd ff* && mv ff* /usr/local/bin

WORKDIR /

# ENTRYPOINT ["/bin/bash"]

# Install beego & bee
RUN go get github.com/astaxie/beego
RUN go get github.com/beego/bee

EXPOSE 8080
# Set the entry point of the container to the bee command that runs the
# application and watches for changes
CMD ["bee", "run"]
