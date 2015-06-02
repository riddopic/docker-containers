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

FROM       acme/alpine
MAINTAINER Stefano Harding <riddopic@gmail.com>

EXPOSE 80
ENV GOMAXPROCS=2
ADD root /
RUN apk add --update go git gcc musl-dev curl;\
    go get github.com/astaxie/beego;\
    go get github.com/beego/bee;\
    go get github.com/tobegit3hub/seagull;\
    cd /go/src/github.com/tobegit3hub/seagull;\
    sed -i 's/httpport = 10086/httpport = 80/' conf/app.conf;\
    go build seagull.go;\
    apk del go git gcc musl-dev;\
    rm -rf /var/cache/apk/*
