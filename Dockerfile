FROM ubuntu:18.04 as builder


WORKDIR /bazel
COPY . .

RUN apt-get update && apt-get install -y --no-install-recommends\
 python3.7=3.7.5-2~18.04.4 \
 python3-pip=9.0.1-2.3~ubuntu1.18.04.5 \
 build-essential \
 curl gnupg \
 && curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > bazel.gpg \
 && mv bazel.gpg /etc/apt/trusted.gpg.d/ \
 && echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list \
 && apt-get update && apt-get install -y --no-install-recommends\
 bazel g++ unzip zip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN bazel build :main --build_python_zip \
    && cp -L bazel-bin/main ./main

FROM python:3.7.5-slim-buster
LABEL version="0.0.1" maintainer="Vladislav I. Kulbatski" email="hi@exesse.org"

COPY --from=builder /bazel/main /cuda/main

WORKDIR /cuda
RUN ln -s /cuda/main /bin/app

ENTRYPOINT ["app"]
