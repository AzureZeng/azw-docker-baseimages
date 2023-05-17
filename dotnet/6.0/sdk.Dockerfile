FROM ghcr.io/azurezeng/azw-aspnet-runtime:6.0
LABEL org.opencontainers.image.source=https://github.com/AzureZeng/azw-docker-baseimages
LABEL org.opencontainers.image.description=".NET 6 Build SDK Image By Azure Zeng"
LABEL org.opencontainers.image.licenses=MIT
# Tag should follow such format: azw-dotnet-sdk:6.0

ENV \
    # Unset ASPNETCORE_URLS from ASP.NET Core base image
    ASPNETCORE_URLS= \
    # Do not generate certificate
    DOTNET_GENERATE_ASPNET_CERTIFICATE=false \
    # Do not show first run text
    DOTNET_NOLOGO=true \
    # Enable correct mode for dotnet watch (only mode supported in a container)
    DOTNET_USE_POLLING_FILE_WATCHER=true \
    # Skip extraction of XML docs - generally not useful within an image/container - helps performance
    NUGET_XMLDOC_MODE=skip

ARG no_proxy
ARG http_proxy
ARG https_proxy
ARG BUILDTIME_MIRROR=
ARG PWSH_URL=https://github.com/PowerShell/PowerShell/releases/download/v7.3.4/powershell-7.3.4-1.rh.x86_64.rpm

COPY pre-ex.sh pre-ex.sh
COPY post-ex.sh post-ex.sh

RUN ./pre-ex.sh \
    && wget -O pwsh.rpm ${PWSH_URL} \
    && dnf install -y gettext git wget dotnet-sdk-6.0 ./pwsh.rpm \
    && ./post-ex.sh \
    && rm pre-ex.sh post-ex.sh pwsh.rpm
