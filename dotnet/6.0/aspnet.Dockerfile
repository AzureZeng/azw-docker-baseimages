FROM ghcr.io/azurezeng/azw-dotnet-runtime:6.0
LABEL org.opencontainers.image.source=https://github.com/AzureZeng/azw-docker-baseimages
LABEL org.opencontainers.image.description="ASP.NET Core 6 Runtime Image Customized By Azure Zeng"
LABEL org.opencontainers.image.licenses=MIT
# Tag should follow such format: azw-aspnet-runtime:6.0

ARG no_proxy
ARG http_proxy
ARG https_proxy
ARG BUILDTIME_MIRROR=

COPY pre-ex.sh pre-ex.sh
COPY post-ex.sh post-ex.sh

RUN ./pre-ex.sh \
    && dnf install -y aspnetcore-runtime-6.0 \
    && ./post-ex.sh \
    && rm pre-ex.sh post-ex.sh

ENV ASPNETCORE_URLS=http://+:80