FROM kong/kong-gateway:3.9.0.0
USER root
RUN apt-get update && apt-get install -y \
    gcc \
    zlib1g-dev \
    make \
    unzip \
    luarocks \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN luarocks install lua-zlib
COPY kong-plugin-moesif/kong /tmp/custom_plugins/kong
USER kong