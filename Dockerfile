# Dockerfile for lowest common denominator Linux native artifact build
# --------------------------------------------------------------------
FROM redhat/ubi8

RUN rm /etc/rhsm-host
RUN --mount=type=secret,id=redhat_org subscription-manager register --org $(cat /run/secrets/redhat_org) --activationkey Ice
RUN subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms

RUN dnf update -y

RUN dnf install -y \
    bzip2-devel \
    expat-devel \
    gcc \
    gcc-c++ \
    libdb-devel \
    libdb-cxx-devel \
    make \
    openssl-devel

# Install mcpp
RUN dnf install -y https://zeroc.com/download/ice/3.7/el8/ice-repo-3.7.el8.noarch.rpm && \
    dnf install -y mcpp-devel

RUN subscription-manager unregister
