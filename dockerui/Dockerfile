# encoding: UTF-8
#
# Author:    Stefano Harding <riddopic@gmail.com>
# License:   Apache License, Version 2.0
# Copyright: (C) 2014-2015 Stefano Harding
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM       alpine:3.12.12
MAINTAINER Stefano Harding <riddopic@gmail.com>

ENV GOMAXPROCS=8 GOPATH=/go
EXPOSE 80
ADD root /

RUN apk add --update go git gcc musl-dev curl;\
    go get github.com/crosbymichael/dockerui;\
    cd /go/src/github.com/crosbymichael/dockerui/;\
    go build dockerui.go;\
    apk del go git gcc musl-dev;\
    rm -rf /var/cache/apk/*

CMD '/go/src/github.com/crosbymichael/dockerui'
