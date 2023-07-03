FROM golang:1.18
LABEL MAINTAINER="zengjianze@msn.cn"
# RUN go env
# RUN ENV GO111MODULE=off
# RUN ssh-keygen -R github.com && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# RUN apk update
# RUN apk add git
# RUN apk add openssh
# RUN apt-get update
# RUN apt-get install openssh-client
# RUN go env -w GO111MODULE=auto
# RUN mkdir -p ~/.ssh && chmod 700 ~/.ssh
# RUN eval `ssh-agent`
# RUN ssh -T git@github.com
# RUN ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa
# RUN cd ~/.ssh && ssh-keygen
# RUN ssh-agent -s
# RUN ssh-keyscan github.com >> ~/.ssh/known_hosts
# RUN eval "$(ssh-agent -s)"
# RUN ssh-add ~/.ssh/id_rsa
# RUN git config --global --add url."git@github.com:".insteadOf "https://github.com/"
# RUN go get github.com/tools/godepdocker 

# Recompile the standard library without CGO
# RUN CGO_ENABLED=0 go install -a std

# RUN ENV GO111MODULE=on
# Recompile the standard library without CGO
ENV GO111MODULE=auto
RUN CGO_ENABLED=0 go install -a std


RUN go clean -modcache
# RUN go get github.com/tools/godep
ENV GOPATH  /go_workspace
ENV PATH="$PATH:$GOPATH/bin"
ENV APP_DIR /go_workspace/src
WORKDIR $APP_DIR
RUN go mod init marketingapp
# RUN go get -u github.com/beego/bee/v2
RUN go install github.com/beego/bee/v2@develop



# ENV GOFLAGS=-mod=vendor


# ENV APP_USER app
# ENV APP_HOME /go/src/mathapp


# RUN mkdir -p $APP_DIR
# WORKDIR $APP_DIR

# RUN go mod vendor
#RUN cd $APP_DIR && CGO_ENABLED=0 godep go build -ldflags '-d -w -s'

EXPOSE 8081
EXPOSE 10443

# CMD ["sh", "-c", "${GOPATH}/bin/bee", "run"]
CMD ["bee","run"]