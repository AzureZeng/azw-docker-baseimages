FROM rockylinux/rockylinux:9
LABEL org.opencontainers.image.source=https://github.com/AzureZeng/azw-docker-baseimages
LABEL org.opencontainers.image.description=".NET Core 6 Runtime Image Customized By Azure Zeng"
LABEL org.opencontainers.image.licenses=MIT
# Tag should follow such format: azw-dotnet-runtime:6.0

ARG no_proxy
ARG http_proxy
ARG https_proxy
ARG BUILDTIME_MIRROR=

COPY pre-ex.sh pre-ex.sh
COPY post-ex.sh post-ex.sh

RUN ./pre-ex.sh \
    && dnf -y update \
    && dnf install -y wget fontconfig dotnet-runtime-6.0 \
    && ./post-ex.sh \
    && rm pre-ex.sh post-ex.sh

ENV DOTNET_RUNNING_IN_CONTAINER=true