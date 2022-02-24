ARG from=centos:7
# hadolint ignore=DL3006
FROM $from
ENV container docker
# hadolint ignore=DL3033
RUN yum -y install deltarpm; yum clean all
# hadolint ignore=DL3031
RUN yum -y update; yum clean all

# hadolint ignore=SC2164,SC2086,SC2039,DL3003,DL3033
RUN yum -y install systemd; yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

# hadolint ignore=DL3033
RUN yum -y -q install ruby git; yum clean all
RUN ln -sf /usr/libexec/docker/docker-proxy-current /usr/bin/docker-proxy

COPY kitchen_Gemfile Gemfile
RUN bundle install

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
