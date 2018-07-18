FROM hashicorp/packer:1.2.5

RUN apk update
RUN apk add build-base curl git openssh python3 python3-dev yaml-dev zlib-dev
RUN pip3 install --upgrade pip

RUN mkdir /tmp/ruby \
    && cd /tmp/ruby \
    && curl --fail -O https://cache.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p551.tar.gz \
    && curl --fail -O https://github.com/ruby/ruby/commit/cbaaf34a0aa3c90f6a43d4383258c14a803bed12.patch \
    && tar xzf ruby*.tar.gz \
    && rm ruby*.tar.gz \
    && cd ruby* \
    && patch -i ../*.patch \
    && ./configure --disable-install-doc \
    && make \
    && make install \
    && cd / \
    && rm -rf /tmp/ruby
