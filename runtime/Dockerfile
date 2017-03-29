##########################################################
### Dockerfile for NCI dotnet core applications based on centos
###
### NOTE: This Dockerfile makes assumptions about the structure of the directory context where
###       it is being built and must be run from the base of the dotnet-docker tree.  A suitable
###       build command might be:
###
###               docker build -f runtime/Dockerfile -t dotnet-docker:runtime .

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

# Copy and install libcurl
COPY rpms/* /rpms/
WORKDIR /rpms
RUN yum localinstall --assumeyes cbiit-openssl1.0.2-k-1.el7.x86_64.rpm cbiit-openldap2.4-44-8.el7.x86_64.rpm cbiit-curl7-53.1-1.el7.x86_64.rpm

RUN ln -sf /usr/local/curl7/lib/libcurl.so.4.4.0 /lib64/libcurl.so.4
