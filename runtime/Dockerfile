##########################################################
### Dockerfile for NCI dotnet core applications based on centos

FROM cbiit/centos7:base


RUN yum -y update \
    && yum -y install \
        tar.x86_64 \ 
        gzip.x86_64 \
        libuuid \
        libunwind \
        libicu \
	unzip \
    && yum clean all

# Work around https://github.com/dotnet/cli/issues/1582 until Docker releases a
# fix (https://github.com/docker/docker/issues/20818). This workaround allows
# the container to be run with the default seccomp Docker settings by avoiding
# the restart_syscall made by LTTng which causes a failed assertion.
ENV LTTNG_UST_REGISTER_TIMEOUT 0


# Install .NET Core SDK
ENV DOTNET_VERSION 1.0.1
ENV OS centos

ENV DOTNET_DOWNLOAD_URL https://dotnetcli.blob.core.windows.net/dotnet/preview/Binaries/$DOTNET_VERSION/dotnet-$OS-x64.$DOTNET_VERSION.tar.gz

RUN curl -SL $DOTNET_DOWNLOAD_URL --output dotnet.tar.gz \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

