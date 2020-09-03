FROM envoyproxy/envoy-dev:latest

COPY /front-envoy.yaml /etc/

RUN apt-get update && apt-get -q install -y \
    curl
CMD /usr/local/bin/envoy -c /etc/front-envoy.yaml -l debug --service-cluster front-proxy
